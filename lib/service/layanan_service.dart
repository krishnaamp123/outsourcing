import 'package:http/http.dart' as http;
import 'package:outsourcing/service/token.dart';

import '../global.dart';

class LayananService {
  Future<http.Response> getLayanan() async {
    // SharedPreferences localStorage = await SharedPreferences.getInstance();
    // var token = localStorage.getString('token')?.replaceAll('"', "");
    var token = await getToken();
    var url = Uri.parse('$baseURL/services/?page=1');
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json',
    });
    print(response.body);
    print(token);
    return response;
  }
}
