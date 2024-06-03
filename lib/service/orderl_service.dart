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
    var url = Uri.parse('$baseURL/transactions/');
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json',
    });
    print(response.body);
    print(token);
    return response;
  }

  Future<http.Response> postOrder(OrderModel orderModel) async {
    var token = await getToken();
    var url = Uri.parse('$baseURL/transactions/');
    http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer $token', // Tambahkan token jika diperlukan
      },
      body: jsonEncode(orderModel.toJson()),
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    print(token);
    return response;
  }

  // Future<http.Response> postOrderLayanan(
  //     OrderLayananModel orderlayananModel) async {
  //   // SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   // var token = localStorage.getString('token')?.replaceAll('"', "");
  //   var token = await getToken();
  //   var url = Uri.parse(baseURL + '/transactions/');
  //   http.Response response = await http.post(url,
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonEncode(orderlayananModel.toJson()));
  //   print(response.body);
  //   return response;
  // }

  Future<http.Response> postMOU(OrderModel orderModel) async {
    // SharedPreferences localStorage = await SharedPreferences.getInstance();
    // var token = localStorage.getString('token')?.replaceAll('"', "");
    var token = await getToken();
    var url = Uri.parse('$baseURL/transactions/1/upload-mou/');
    http.Response response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(orderModel.toJson()));
    print(response.body);
    print(token);
    return response;
  }
}
