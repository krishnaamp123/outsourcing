import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:outsourcing/buangan/orderlama_model.dart';
import 'package:outsourcing/service/token.dart';

import '../global.dart';

class OrderLamaService {
  // Future<http.Response> getOrder() async {
  //   // SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   // var token = localStorage.getString('token')?.replaceAll('"', "");
  //   var token = await getToken();
  //   var url = Uri.parse(baseURL + '/service-orders/user-list/');
  //   print(response.body);
  //   print(token);
  //   return response;
  // }

  Future<http.Response> postOrder(OrderLamaModel orderLamaModel) async {
    // SharedPreferences localStorage = await SharedPreferences.getInstance();
    // var token = localStorage.getString('token')?.replaceAll('"', "");
    var token = await getToken();
    var url = Uri.parse(baseURL + '/service-orders/');
    http.Response response = await http.post(url,
        headers: setHeaders(token), body: jsonEncode(orderLamaModel.toJson()));
    print(response.body);
    return response;
  }

  Future<http.Response> postMOU(OrderLamaModel orderLamaModel) async {
    // SharedPreferences localStorage = await SharedPreferences.getInstance();
    // var token = localStorage.getString('token')?.replaceAll('"', "");
    var token = await getToken();
    var url = Uri.parse(baseURL + '/service-orders/upload-mou/');
    http.Response response = await http.post(url,
        headers: setHeaders(token), body: jsonEncode(orderLamaModel.toJson()));
    print(response.body);
    return response;
  }
}
