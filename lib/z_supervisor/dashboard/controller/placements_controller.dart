import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outsourcing/model/placement_model.dart';
import 'package:outsourcing/service/placement_service.dart';
import 'package:outsourcing/z_supervisor/dashboard/view/detail_penempatans.dart';

class PlacementSController extends GetxController implements GetxService {
  var listPlacement = <PlacementModel>[].obs;
  final placement = PlacementService();
  var isLoading = false.obs;

  Future<void> getPlacement() async {
    isLoading.value = true;
    try {
      var response = await placement.getPlacement();
      var responsedecode = jsonDecode(response.body);

      // Check if the 'datas' field exists and is a list
      if (responsedecode.containsKey('datas') &&
          responsedecode['datas'] is List) {
        listPlacement.clear();

        // Convert each item in the 'datas' list to PlacementModel
        for (var item in responsedecode['datas']) {
          PlacementModel data = PlacementModel.fromJson(item);
          listPlacement.add(data);
        }
      } else {
        throw Exception("'datas' field is missing or not a list");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToDetails(
    BuildContext context,
    String id,
    String startDate,
    String endDate,
    String status,
    String note,
    String duration,
    String totalEmployee,
    String namaPemesan,
    String alamat,
    String namaSupervisor,
    String alamatSupervisor,
    String telponSupervisor,
    String profileSupervisor,
    String useridSupervisor,
    List<Employees> employees,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPenempatanS(
          id: id,
          startDate: startDate,
          endDate: endDate,
          status: status,
          note: note,
          duration: duration,
          totalEmployee: totalEmployee,
          namaPemesan: namaPemesan,
          alamat: alamat,
          namaSupervisor: namaSupervisor,
          alamatSupervisor: alamatSupervisor,
          telponSupervisor: telponSupervisor,
          profileSupervisor: profileSupervisor,
          useridSupervisor: useridSupervisor,
          employees: employees,
        ),
      ),
    );
  }
}
