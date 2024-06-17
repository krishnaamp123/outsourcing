import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  final String _url = 'http://10.0.2.2:8080/api/v1';

  Future<String> getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    return localStorage.getString('token') ?? '';
  }

  auth(data, apiURL) async {
    var fullUrl = Uri.parse(_url + apiURL);
    return await http.post(fullUrl,
        body: jsonEncode(data), headers: _setHeaders());
  }

  getData(apiURL) async {
    var fullUrl = Uri.parse(_url + apiURL);
    var token = await getToken();
    return await http.get(fullUrl, headers: _setHeadersWithToken(token));
  }

  Map<String, String> _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  Map<String, String> _setHeadersWithToken(String token) => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
}

// class Network {
//   final String _url = 'http://10.0.2.2:8080';
//   // 192.168.1.2 is my IP, change with your IP address
//   var token;

//   Future<String> getToken() async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();
//     return localStorage.getString('token')?.replaceAll('"', "") ?? '';
//   }

//   auth(data, apiURL) async {
//     var fullUrl = Uri.parse(_url + apiURL);
//     return await http.post(fullUrl,
//         body: jsonEncode(data), headers: _setHeaders());
//   }

//   getData(apiURL) async {
//     var fullUrl = Uri.parse(_url + apiURL);
//     var token = await getToken();
//     return await http.post(fullUrl, headers: setHeaders(token));
//   }

//   _setHeaders() => {
//         'Content-type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $token',
//       };

//   setHeaders(String token) => {
//         'Content-type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $token',
//       };
// }

