import 'package:http/http.dart' as http;
import 'package:outsourcing/service/token.dart';

import '../global.dart';

class OrderService {
  Future<http.Response> getOrder() async {
    // SharedPreferences localStorage = await SharedPreferences.getInstance();
    // var token = localStorage.getString('token')?.replaceAll('"', "");
    var token = await getToken();
    var url = Uri.parse(baseURL + '/service-orders/');
    http.Response response = await http.get(url, headers: setHeaders(token));
    print(response.body);
    print(token);
    return response;
  }
}
