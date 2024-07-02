import 'package:flutter/material.dart';
import 'package:outsourcing/global.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../core.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart'; // pastikan untuk menambahkan package ini

class OTPController {
  Future<void> postVerified(BuildContext context, int id) async {
    var url = Uri.parse('$baseURL/verify/');
    http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'user_id': id}),
    );

    if (response.statusCode == 200) {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Info',
          message:
              'Email berhasil dikirimkan, periksa email untuk melanjutkan verifikasi',
          contentType: ContentType.success,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Info',
          message: 'Email gagal dikirimkan, periksa email yang diinputkan',
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      print("Error: ${response.statusCode}");
    }
  }

  void loginNow(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }
}
