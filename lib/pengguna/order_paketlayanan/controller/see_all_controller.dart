import 'package:flutter/material.dart';

class SeeAllController {
  final TextEditingController alamatController = TextEditingController();
  String? alamatError;

  String? validateAlamat(String? value) {
    if (value == null || value.isEmpty) {
      alamatError = 'Masukkan alamat';
      return alamatError;
    }
    alamatError = null;
    return null;
  }
}
