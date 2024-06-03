import 'package:http/http.dart' as http;

import '../global.dart';

class RegencyService {
  Future<http.Response> getRegency() async {
    var url = Uri.parse('$baseURL/regencies/?page=1');
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json',
    });
    print(response.body);
    return response;
  }
}

// class RegencyService {
//   Future<http.Response> getRegency() async {
//     // SharedPreferences localStorage = await SharedPreferences.getInstance();
//     // var token = localStorage.getString('token')?.replaceAll('"', "");
//     var token = await getToken();
//     var url = Uri.parse(baseURL + '/regencies/?page=1');
//     http.Response response = await http.get(url, headers: setHeaders(token));
//     print(response.body);
//     print(token);
//     return response;
//   }
// }
