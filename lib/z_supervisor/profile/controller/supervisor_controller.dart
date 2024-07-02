import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outsourcing/model/supervisor_model.dart';
import 'package:outsourcing/service/supervisor_service.dart';
import 'package:outsourcing/z_supervisor/profile/view/edit_supercisor.dart';

class SupervisorController extends GetxController implements GetxService {
  var listSupervisor = <SupervisorModel>[].obs;
  final supervisor = SupervisorService();
  var isLoading = false.obs;
  late int userId;

  // Method untuk mengatur ID pengguna
  void setUserId(int userid) {
    userId = userid;
    getSupervisor();
  }

  Future<void> getSupervisor() async {
    isLoading.value = true;
    try {
      var response = await supervisor.getSupervisor(userId);
      var responsedecode = jsonDecode(response.body);

      // Check if the 'data' field exists and is not null
      if (responsedecode.containsKey('data') &&
          responsedecode['data'] != null) {
        listSupervisor.clear();

        // Convert 'data' object to SupervisorModel
        SupervisorModel data = SupervisorModel.fromJson(responsedecode['data']);
        listSupervisor.add(data);
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
    String npwp,
    String gender,
    String phone,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditSupervisorProfilePage(
          id: id,
          email: email,
          fullname: fullname,
          password: password,
          fulladdress: fulladdress,
          birthplace: birthplace,
          birthdate: birthdate,
          nik: nik,
          npwp: npwp,
          gender: gender,
          phone: phone,
        ),
      ),
    );
  }
}
