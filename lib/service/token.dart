import 'package:shared_preferences/shared_preferences.dart';

// var token;

Future<String> getToken() async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  return localStorage.getString('token')?.replaceAll('"', "") ?? '';
}

setHeaders(String token) => {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

setHeadersNoToken() => {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
