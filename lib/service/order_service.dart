import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:outsourcing/CookieClient.dart';
import 'package:outsourcing/model/order_model.dart';
import 'package:outsourcing/service/token.dart';
import 'package:cookie_jar/cookie_jar.dart';

import '../global.dart';

class OrderService {
  Future<http.Response> getOrder() async {
    var token = await getToken();
    if (token.isEmpty) {
      throw Exception('Token is missing');
    }

    var url = Uri.parse('$baseURL/transactions/');
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

  Future<http.Response> postOrder(OrderModel orderModel) async {
    var token = await getToken();
    if (token.isEmpty) {
      throw Exception('Token is missing');
    }

    var url = Uri.parse('$baseURL/transactions/');
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

    http.Response response = await client.post(
      url,
      headers: headers,
      body: jsonEncode(orderModel.toJson()),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response;
  }

  Future<http.Response> postMOU(File pdfFile, String id) async {
    var token = await getToken();
    if (token.isEmpty) {
      throw Exception('Token is missing');
    }

    var url = Uri.parse('$baseURL/transactions/$id/upload-mou/');
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

    List<int> fileBytes = await pdfFile.readAsBytes();
    String base64Pdf = base64Encode(fileBytes);

    var body = jsonEncode({
      'file': base64Pdf,
    });

    http.Response response = await client.post(
      url,
      headers: headers,
      body: body,
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response;
  }
}
