import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:outsourcing/global.dart';
import 'package:http/http.dart' as http;
import '../../core.dart';

class ForgotController {
  final TextEditingController emailController = TextEditingController();
  String? emailError;

  String? validateEmail(String? emailValue) {
    if (emailValue == null || emailValue.isEmpty) {
      return 'Masukkan email';
    } else {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(emailValue)) {
        return 'Format email tidak valid';
      }
    }
    return null;
  }

  bool validateForm() {
    final emailValue = emailController.text;
    final emailValidation = validateEmail(emailValue);
    emailError = emailValidation;
    return emailValidation == null;
  }

  Future<void> handleForgot(BuildContext context) async {
    if (validateForm()) {
      await postForgot(context);
    } else {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Info',
          message:
              'Harap periksa kembali akun yang anda masukan, akun yang anda masukan belum terdaftar',
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  Future<void> postForgot(BuildContext context) async {
    var url = Uri.parse('$baseURL/forgot/');
    http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'email': emailController.text}),
    );

    if (response.statusCode == 200) {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Info',
          message:
              'Email berhasil dikirimkan, periksa email untuk melanjutkan lupa password',
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

  void backLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }
}
