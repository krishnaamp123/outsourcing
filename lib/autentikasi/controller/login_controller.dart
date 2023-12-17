import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:outsourcing/autentikasi/model/api_login.dart';
import 'package:outsourcing/autentikasi/view/startkaryawan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core.dart';

class LoginController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? emailError;
  String? passwordError;

  // @override
  // void oninit() {
  //   handleLogin(emailController, passwordController);
  // }

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

  String? validatePassword(String? passwordValue) {
    if (passwordValue == null || passwordValue.isEmpty) {
      return 'Masukkan password';
    }
    return null;
  }

  bool validateForm() {
    final emailValue = emailController.text.trim();
    final passwordValue = passwordController.text.trim();

    final emailValidation = validateEmail(emailValue);
    final passwordValidation = validatePassword(passwordValue);

    emailError = emailValidation;
    passwordError = passwordValidation;

    return emailValidation == null && passwordValidation == null;
  }

  void navigateToStart(BuildContext context) {
    String username = emailController.text.trim();
    List<String> parts = username.split('@');
    String usernameWithoutDomain = parts[0];

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => StartKaryawan(),
      ),
    );
  }

  Future<void> handleLogin(BuildContext context) async {
    if (validateForm()) {
      login();
      navigateToStart(context);
    }
  }

  void login() async {
    var data = {
      'email': emailController.text.trim(),
      'password': passwordController.text.trim(),
    };

    var res = await Network().auth(data, '/login');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['access_token']));
      localStorage.setString('user', json.encode(body['user']));
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
