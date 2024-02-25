import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:outsourcing/model/order_model.dart';
import 'package:outsourcing/service/token.dart';

import '../global.dart';

class OrderService {
  Future<http.Response> getOrder() async {
    // SharedPreferences localStorage = await SharedPreferences.getInstance();
    // var token = localStorage.getString('token')?.replaceAll('"', "");
    var token = await getToken();
    var url = Uri.parse(baseURL + '/service-orders/user-list/');
    http.Response response = await http.get(url, headers: setHeaders(token));
    print(response.body);
    print(token);
    return response;
  }

  Future<http.Response> postOrder(OrderModel orderModel) async {
    // SharedPreferences localStorage = await SharedPreferences.getInstance();
    // var token = localStorage.getString('token')?.replaceAll('"', "");
    var token = await getToken();
    var url = Uri.parse(baseURL + '/service-orders/');
    http.Response response = await http.post(url,
        headers: setHeaders(token), body: jsonEncode(orderModel.toJson()));
    print(response.body);
    return response;
  }

  Future<http.Response> postMOU(OrderModel orderModel) async {
    // SharedPreferences localStorage = await SharedPreferences.getInstance();
    // var token = localStorage.getString('token')?.replaceAll('"', "");
    var token = await getToken();
    var url = Uri.parse(baseURL + '/service-orders/upload-mou/');
    http.Response response = await http.post(url,
        headers: setHeaders(token), body: jsonEncode(orderModel.toJson()));
    print(response.body);
    return response;
  }
}
