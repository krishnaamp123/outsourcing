import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:outsourcing/CookieClient.dart';
import 'package:outsourcing/service/token.dart';
import 'package:cookie_jar/cookie_jar.dart';

import '../global.dart';

class ServiceUserService {
  Future<http.Response> getServiceUser(int id) async {
    var token = await getToken();
    if (token.isEmpty) {
      throw Exception('Token is missing');
    }

    var url = Uri.parse('$baseURL/users/$id/');
    var cj = CookieJar();
    var uri = Uri.parse(baseURL);

    // Simpan cookie token
    await cj.saveFromResponse(uri, [Cookie('session', token)]);
    var cookies = await cj.loadForRequest(uri);
    print('Cookies: $cookies');

    var headers = {
      'Content-Type': 'application/json',
    };

    var client = http.Client();
    client = CookieClient(client, cookieJar: cj);

    http.Response response = await client.get(
      url,
      headers: headers,
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response;
  }

  Future<Uint8List> fetchImageWithCookie(int id) async {
    var token = await getToken();
    if (token.isEmpty) {
      throw Exception('Token is missing');
    }

    var imageUrl = Uri.parse('$baseURL/resource/users/$id/profile/');
    var cj = CookieJar();
    var uri = Uri.parse(baseURL);

    // Simpan cookie token
    await cj.saveFromResponse(uri, [Cookie('session', token)]);
    var cookies = await cj.loadForRequest(uri);
    print('Cookies: $cookies');

    var headers = {
      'Cookie':
          cookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; '),
      'Content-Type': 'application/json',
    };

    var client = http.Client();
    client = CookieClient(client, cookieJar: cj);

    http.Response response = await client.get(
      imageUrl,
      headers: headers,
    );

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      print('Failed to load image: ${response.statusCode}, ${response.body}');
      throw Exception('Failed to load image');
    }
  }

  Future<http.Response> patchServiceUser(
    int id,
    String fullname,
    String fulladdress,
    String phone,
    String? password,
    File? profilepic,
  ) async {
    var token = await getToken();
    if (token.isEmpty) {
      throw Exception('Token is missing');
    }

    var url = Uri.parse('$baseURL/users/$id/');
    var cj = CookieJar();
    var uri = Uri.parse(baseURL);

    await cj.saveFromResponse(uri, [Cookie('session', token)]);
    var cookies = await cj.loadForRequest(uri);
    print('Cookies: $cookies');

    var headers = {
      'Content-Type': 'application/json',
    };

    var body = <String, dynamic>{
      'service_user_profile': {
        'fullname': fullname,
        'full_address': fulladdress,
        'phone': phone,
      },
    };

    if (password != null && password.isNotEmpty) {
      body['password'] = password;
    }

    if (profilepic != null) {
      List<int> imageBytes = await profilepic.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      body['profile_pic'] = base64Image;
    }

    var client = http.Client();
    client = CookieClient(client, cookieJar: cj);

    http.Response response = await client.patch(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response;
  }
}
