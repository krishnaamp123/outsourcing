import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:outsourcing/pengguna/autentikasi/view/login_page.dart';

class RegisController {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cpasswordController = TextEditingController();

  String? usernameError;
  String? emailError;
  String? passwordError;
  String? cpasswordError;

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Masukkan username';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Masukkan email';
    } else {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(value)) {
        return 'Format email tidak valid';
      }
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Masukkan password';
    }
    return null;
  }

  String? validatecPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Masukkan password kembali';
    }
    return null;
  }

  bool validateForm() {
    if (usernameController.text.isEmpty) {
      usernameError = 'Masukkan username';
      emailError = null;
      passwordError = null;
      cpasswordError = null;
      return false;
    } else if (emailController.text.isEmpty) {
      emailError = 'Masukkan email';
      usernameError = null;
      passwordError = null;
      cpasswordError = null;
      return false;
    } else if (passwordController.text.isEmpty) {
      passwordError = 'Masukkan password';
      usernameError = null;
      emailError = null;
      cpasswordError = null;
      return false;
    } else if (cpasswordController.text.isEmpty) {
      cpasswordError = 'Masukkan password kembali';
      usernameError = null;
      emailError = null;
      passwordError = null;
      return false;
    }
    return true;
  }

  void navigateToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void handleRegis(BuildContext context) {
    if (validateForm()) {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Info',
          message:
              'Terimakasih akun anda sudah berhasil dibuat, tunggu beberapa saat untuk menuju login',
          contentType: ContentType.success,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);

      Future.delayed(const Duration(seconds: 2), () {
        navigateToLogin(context);
      });
    }
  }

  void navigateToLoginPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }
}
