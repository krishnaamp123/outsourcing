import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:outsourcing/autentikasi/model/api_login.dart';
import 'package:outsourcing/autentikasi/view/login_page.dart';
import 'package:outsourcing/autentikasi/view/startkaryawan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? usernameError;
  String? emailError;
  String? passwordError;

  String? validateUsername(String? usernameValue) {
    if (usernameValue == null || usernameValue.isEmpty) {
      return 'Masukkan username';
    }
    return null;
  }

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
    final usernameValue = usernameController.text.trim();
    final emailValue = emailController.text.trim();
    final passwordValue = passwordController.text.trim();

    final usernameValidation = validateUsername(usernameValue);
    final emailValidation = validateEmail(emailValue);
    final passwordValidation = validatePassword(passwordValue);

    usernameError = usernameValidation;
    emailError = emailValidation;
    passwordError = passwordValidation;

    return usernameValidation == null &&
        emailValidation == null &&
        passwordValidation == null;
  }

  void navigateToStart(BuildContext context) {
    String username = usernameController.text.trim();
    List<String> parts = username.split('@');
    String usernameWithoutDomain = parts[0];

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => StartKaryawan(),
      ),
    );
  }

  Future<void> handleRegis(BuildContext context) async {
    if (validateForm()) {
      await login();
      navigateToStart(context);
    }
  }

  Future<void> login() async {
    var data = {
      'username': usernameController.text.trim(),
      'email': emailController.text.trim(),
      'password': passwordController.text.trim(),
    };

    var res = await Network().auth(data, '/register');
    var body = json.decode(res.body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['token']));
      localStorage.setString('user', json.encode(body['user']));
    }
  }

  // bool validateForm() {
  //   if (usernameController.text.isEmpty) {
  //     usernameError = 'Masukkan username';
  //     emailError = null;
  //     passwordError = null;
  //     return false;
  //   } else if (emailController.text.isEmpty) {
  //     emailError = 'Masukkan email';
  //     usernameError = null;
  //     passwordError = null;
  //     return false;
  //   } else if (passwordController.text.isEmpty) {
  //     passwordError = 'Masukkan password';
  //     usernameError = null;
  //     emailError = null;
  //     return false;
  //   }
  //   return true;
  // }

  // void navigateToLogin(BuildContext context) {
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (context) => const LoginPage()),
  //   );
  // }

  // void handleRegis(BuildContext context) {
  //   if (validateForm()) {
  //     final snackBar = SnackBar(
  //       elevation: 0,
  //       behavior: SnackBarBehavior.floating,
  //       backgroundColor: Colors.transparent,
  //       content: AwesomeSnackbarContent(
  //         title: 'Info',
  //         message:
  //             'Terimakasih akun anda sudah berhasil dibuat, tunggu beberapa saat untuk menuju login',
  //         contentType: ContentType.success,
  //       ),
  //     );

  //     ScaffoldMessenger.of(context)
  //       ..hideCurrentSnackBar()
  //       ..showSnackBar(snackBar);

  //     Future.delayed(const Duration(seconds: 2), () {
  //       navigateToLogin(context);
  //     });
  //   }
  // }

  void navigateToLoginPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }
}
