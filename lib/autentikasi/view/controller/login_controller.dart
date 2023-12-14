import 'package:flutter/material.dart';
import 'package:outsourcing/autentikasi/view/regis_page.dart';
import 'package:outsourcing/main.dart';

class LoginController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  String? usernameError;
  String? passwordError;

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Masukkan username';
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
    if (usernameController.text.isEmpty) {
      usernameError = 'Masukkan username';
      passwordError = null;
      return false;
    } else if (passwordController.text.isEmpty) {
      passwordError = 'Masukkan password';
      usernameError = null;
      return false;
    }
    return true;
  }

  void navigateToStart(BuildContext context) {
    String username = usernameController.text;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Start(username: username),
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
