import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:outsourcing/model/orderlayanan_model.dart';
import 'package:outsourcing/service/token.dart';

import '../global.dart';

class OrderLayananService {
  Future<http.Response> getOrderLayanan() async {
    // SharedPreferences localStorage = await SharedPreferences.getInstance();
    // var token = localStorage.getString('token')?.replaceAll('"', "");
    var token = await getToken();
    var url = Uri.parse(baseURL + '/transactions/');
    http.Response response = await http.get(url, headers: {
      'Content-Type': 'application/json',
    });
    print(response.body);
    print(token);
    return response;
  }

  Future<http.Response> postOrderLayanan(
      OrderLayananModel orderlayananModel) async {
    // SharedPreferences localStorage = await SharedPreferences.getInstance();
    // var token = localStorage.getString('token')?.replaceAll('"', "");
    var token = await getToken();
    var url = Uri.parse(baseURL + '/transactions/');
    http.Response response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(orderlayananModel.toJson()));
    print(response.body);
    return response;
  }

  Future<http.Response> postMOU(OrderLayananModel orderlayananModel) async {
    // SharedPreferences localStorage = await SharedPreferences.getInstance();
    // var token = localStorage.getString('token')?.replaceAll('"', "");
    var token = await getToken();
    var url = Uri.parse(baseURL + '/transactions/1/upload-mou/');
    http.Response response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(orderlayananModel.toJson()));
    print(response.body);
    return response;
  }
}
