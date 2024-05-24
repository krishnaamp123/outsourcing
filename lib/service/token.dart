import 'package:shared_preferences/shared_preferences.dart';

Future<String> getToken() async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  return localStorage.getString('token') ?? '';
}

Map<String, String> setHeaders(String token) {
  return {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };
}

Map<String, String> setHeadersNoToken() {
  return {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
}
