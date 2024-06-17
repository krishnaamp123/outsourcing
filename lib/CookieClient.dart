import 'package:http/http.dart' as http;
import 'package:cookie_jar/cookie_jar.dart';
import 'dart:convert';

class CookieClient extends http.BaseClient {
  final http.Client _inner;
  final CookieJar _cookieJar;

  CookieClient(this._inner, {required CookieJar cookieJar})
      : _cookieJar = cookieJar;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    var cookies = await _cookieJar.loadForRequest(request.url);
    var cookieHeader =
        cookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; ');
    request.headers['Cookie'] = cookieHeader;

    var response = await _inner.send(request);

    var responseCookies = response.headers['set-cookie'];
    if (responseCookies != null) {
      await _cookieJar.saveFromResponse(
          request.url, [Cookie.fromSetCookieValue(responseCookies)]);
    }

    return response;
  }
}
