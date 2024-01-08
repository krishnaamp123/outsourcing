import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outsourcing/model/order_model.dart';
import 'package:outsourcing/z_pengguna/order_layanan/view/orderlayanandetail.dart';
import 'package:outsourcing/service/order_service.dart';

class OrderLayananController extends GetxController implements GetxService {
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController hariController = TextEditingController();
  var postOrder = OrderModel().obs;
  final service = OrderService();
  var isLoading = false.obs;
  String? alamatCon, hariCon, nameCon, bestpriceCon;
  int? jumlahCleanerCon;
  List<String> selectedItemsCon = [];

  String? alamatError;
  String? hariError;

  String? validateAlamat(String? value) {
    if (value == null || value.isEmpty) {
      return 'Masukkan alamat';
    }
    return null;
  }

  String? validateHari(String? value) {
    if (value == null || value.isEmpty) {
      return 'Masukkan jumlah hari';
    } else {
      final parsedValue = int.tryParse(value);
      if (parsedValue == null || parsedValue <= 0) {
        return 'Masukkan angka untuk jumlah hari';
      }
      return null;
    }
  }

  bool validateForm() {
    if (alamatController.text.isEmpty) {
      alamatError = 'Masukkan alamat';
      hariError = null;
      return false;
    } else if (hariController.text.isEmpty) {
      hariError = 'Masukkan jumlah hari';
      alamatError = null;
      return false;
    }
    return true;
  }

  void handleOrderLayanan(
      BuildContext context,
      List<String>? selectedItems,
      List<int>? hargaitem,
      int jumlahCleaner,
      String name,
      String image,
      String baseprice) {
    if (validateForm()) {
      navigateToOrderLayananDetail(context, selectedItems, hargaitem,
          jumlahCleaner, name, image, baseprice);
    }
  }

  void navigateToOrderLayananDetail(
      BuildContext context,
      List<String>? selectedItems,
      List<int>? hargaitem,
      int jumlahCleaner,
      String name,
      String image,
      String baseprice) {
    String alamat = alamatController.text;
    String hari = hariController.text;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderLayananDetail(
          alamat: alamat,
          hari: hari,
          name: name,
          image: image,
          baseprice: baseprice,
          selectedItems: selectedItems ?? [],
          jumlahCleaner: jumlahCleaner,
          hargaitem: hargaitem ?? [],
        ),
      ),
    );
  }

  Future<void> PostOrder({required int user_id}) async {
    isLoading.value = true;

    var response = await service.postOrder(postOrder.value);
    var responsedecode = jsonDecode(response.body);

    if (response.statusCode == 200) {
      Get.back();
      Get.snackbar(
        'Create Berhasil',
        "Data berhasil ditambah",
        colorText: Colors.white,
        backgroundColor: Colors.lightBlue,
      );
      // resetForm();
    } else {
      Get.snackbar(
        'Create Gagal',
        "Data gagal ditambah, mohon periksa kembali",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
    isLoading.value = false;

    // Get.back();
  }
}
