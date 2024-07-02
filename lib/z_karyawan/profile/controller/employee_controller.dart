import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outsourcing/model/employee_model.dart';
import 'package:outsourcing/service/employee_service.dart';
import 'package:outsourcing/z_karyawan/profile/view/edit_karyawan.dart';

class EmployeeController extends GetxController implements GetxService {
  var listEmployee = <EmployeeModel>[].obs;
  final employee = EmployeeService();
  var isLoading = false.obs;
  late int userId;

  // Method untuk mengatur ID pengguna
  void setUserId(int userid) {
    userId = userid;
    getEmployee();
  }

  Future<void> getEmployee() async {
    isLoading.value = true;
    try {
      var response = await employee.getEmployee(userId);
      var responsedecode = jsonDecode(response.body);

      // Check if the 'data' field exists and is not null
      if (responsedecode.containsKey('data') &&
          responsedecode['data'] != null) {
        listEmployee.clear();

        // Convert 'data' object to EmployeeModel
        EmployeeModel data = EmployeeModel.fromJson(responsedecode['data']);
        listEmployee.add(data);
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
    String education,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditEmployeeProfilePage(
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
          education: education,
        ),
      ),
    );
  }
}
