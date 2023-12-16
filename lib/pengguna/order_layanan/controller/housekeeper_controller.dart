import 'package:flutter/material.dart';
import 'package:outsourcing/core.dart';

class HousekeeperController {
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

  void handleHousekeeper(BuildContext context) {
    if (validateForm()) {
      navigateToHousekeeperDetail(context);
    }
  }

  void navigateToHousekeeperDetail(BuildContext context) {
    String alamat = alamatController.text;
    String hari = hariController.text;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HousekeeperDetail(
          alamat: alamat,
          hari: hari,
        ),
      ),
    );
  }
}
