import 'package:flutter/material.dart';
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
    }
    return null;
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

  void handleCleaner(BuildContext context) {
    if (validateForm()) {
      navigateToCleanerDetail(context);
    }
  }

  void navigateToCleanerDetail(BuildContext context) {
    String alamat = alamatController.text;
    String hari = hariController.text;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CleanerDetail(
          alamat: alamat,
          hari: hari,
        ),
      ),
    );
  }
}
