import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outsourcing/core.dart';
import 'package:outsourcing/model/serviceuser_model.dart';
import 'package:outsourcing/service/serviceuser_service.dart';

class ServiceUserController extends GetxController implements GetxService {
  var listServiceUser = <ServiceUserModel>[].obs;
  final serviceuser = ServiceUserService();
  var isLoading = false.obs;
  late int userId;

  // Method untuk mengatur ID pengguna
  void setUserId(int userid) {
    userId = userid;
    getServiceUser();
  }

  Future<void> getServiceUser() async {
    isLoading.value = true;
    try {
      var response = await serviceuser.getServiceUser(userId);
      var responsedecode = jsonDecode(response.body);

      // Check if the 'data' field exists and is not null
      if (responsedecode.containsKey('data') &&
          responsedecode['data'] != null) {
        listServiceUser.clear();

        // Convert 'data' object to ServiceUserModel
        ServiceUserModel data =
            ServiceUserModel.fromJson(responsedecode['data']);
        listServiceUser.add(data);
      } else {
        throw Exception("'data' field is missing or null");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToDetails(
    BuildContext context,
    int id,
    String email,
    String fullname,
    String password,
    String fulladdress,
    String birthplace,
    String birthdate,
    String nik,
    String gender,
    String phone,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(
          id: id,
          email: email,
          fullname: fullname,
          password: password,
          fulladdress: fulladdress,
          birthplace: birthplace,
          birthdate: birthdate,
          nik: nik,
          gender: gender,
          phone: phone,
        ),
      ),
    );
  }
}
