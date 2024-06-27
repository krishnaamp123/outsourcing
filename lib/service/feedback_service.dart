import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:outsourcing/CookieClient.dart';
import 'package:outsourcing/service/token.dart';
import 'package:cookie_jar/cookie_jar.dart';

import '../global.dart';

class FeedbackService {
  Future<http.Response> postFeedback(int id, int rating, String comment) async {
    var token = await getToken();
    if (token.isEmpty) {
      throw Exception('Token is missing');
    }

    if (id <= 0) {
      throw Exception('Invalid transaction ID');
    }

    var url = Uri.parse('$baseURL/feedbacks/');
    var cj = CookieJar();
    var uri = Uri.parse(baseURL);

    await cj.saveFromResponse(uri, [Cookie('session', token)]);
    var cookies = await cj.loadForRequest(uri);
    print('Cookies: $cookies');

    var headers = {
      'Content-Type': 'application/json',
    };

    var body = json.encode({
      'transaction_id': id,
      'review': rating,
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

  Future<http.Response> getFeedback() async {
    var token = await getToken();
    if (token.isEmpty) {
      throw Exception('Token is missing');
    }

    var url = Uri.parse('$baseURL/feedbacks/');
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
