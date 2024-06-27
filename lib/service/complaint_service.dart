import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:outsourcing/CookieClient.dart';
import 'package:outsourcing/service/token.dart';
import 'package:cookie_jar/cookie_jar.dart';

import '../global.dart';

class ComplaintService {
  Future<http.Response> postComplaint(String comment, int id) async {
    var token = await getToken();
    if (token.isEmpty) {
      throw Exception('Token is missing');
    }

    var url = Uri.parse('$baseURL/complaints/');
    var cj = CookieJar();
    var uri = Uri.parse(baseURL);

    await cj.saveFromResponse(uri, [Cookie('session', token)]);
    var cookies = await cj.loadForRequest(uri);
    print('Cookies: $cookies');

    var headers = {
      'Content-Type': 'application/json',
    };

    var body = json.encode({
      'placement_employee_id': id,
      'comment': comment,
    });

    var client = http.Client();
    client = CookieClient(client, cookieJar: cj);

    http.Response response = await client.post(
      url,
      headers: headers,
      body: body,
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response;
  }

  Future<http.Response> getComplaint() async {
    var token = await getToken();
    if (token.isEmpty) {
      throw Exception('Token is missing');
    }

    var url = Uri.parse('$baseURL/complaints/');
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
}
