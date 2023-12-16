import 'package:flutter/material.dart';
import 'package:outsourcing/autentikasi/view/regis_page.dart';
import 'package:outsourcing/autentikasi/view/start.dart';
import 'package:outsourcing/autentikasi/view/startkaryawan.dart';
import 'package:outsourcing/autentikasi/view/startsupervisor.dart';

class LoginController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? emailError;
  String? passwordError;

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

  bool validateForm() {
    if (emailController.text.isEmpty) {
      emailError = 'Masukkan email';
      passwordError = null;
      return false;
    } else if (passwordController.text.isEmpty) {
      passwordError = 'Masukkan password';
      emailError = null;
      return false;
    }
    return true;
  }

  void navigateToStart(BuildContext context) {
    String username = emailController.text;
    List<String> parts = username.split('@');
    String usernameWithoutDomain = parts[0];

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => StartSupervisor(username: usernameWithoutDomain),
      ),
    );
  }

  void handleLogin(BuildContext context) {
    if (validateForm()) {
      navigateToStart(context);
    }
  }

  void navigateToRegister(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const RegisterPage(),
      ),
    );
  }
}
