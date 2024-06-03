import 'package:flutter/material.dart';

class SeeAllController {
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController namapesananController = TextEditingController();
  String? alamatError;
  String? namapesananError;

  String? validateAlamat(String? value) {
    if (value == null || value.isEmpty) {
      alamatError = 'Masukkan alamat';
      return alamatError;
    }
    alamatError = null;
    return null;
  }

  String? validateNamaPesanan(String? value) {
    if (value == null || value.isEmpty) {
      namapesananError = 'Masukkan nama pemesanan';
      return namapesananError;
    }
    namapesananError = null;
    return null;
  }
}
