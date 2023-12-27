import 'package:flutter/material.dart';
import 'package:outsourcing/pengguna/order_layanan/view/orderlayanandetail.dart';

class OrderLayananController {
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController hariController = TextEditingController();

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

  void handleOrderLayanan(BuildContext context, List<String>? selectedItems,
      int jumlahCleaner, String name, String image, String baseprice) {
    if (validateForm()) {
      navigateToOrderLayananDetail(
          context, selectedItems, jumlahCleaner, name, image, baseprice);
    }
  }

  void navigateToOrderLayananDetail(
      BuildContext context,
      List<String>? selectedItems,
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
        ),
      ),
    );
  }
}
