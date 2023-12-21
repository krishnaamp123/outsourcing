import 'package:flutter/material.dart';
import 'package:outsourcing/core.dart';
import 'package:outsourcing/pengguna/order_layanan/view/cleanerdetail.dart';

class CleanerController {
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

  void handleCleaner(
      BuildContext context, List<String>? selectedItems, int jumlahCleaner) {
    if (validateForm()) {
      navigateToCleanerDetail(context, selectedItems, jumlahCleaner);
    }
  }

  void navigateToCleanerDetail(
      BuildContext context, List<String>? selectedItems, int jumlahCleaner) {
    String alamat = alamatController.text;
    String hari = hariController.text;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CleanerDetail(
          alamat: alamat,
          hari: hari,
          selectedItems: selectedItems ?? [],
          jumlahCleaner: jumlahCleaner,
        ),
      ),
    );
  }
}
