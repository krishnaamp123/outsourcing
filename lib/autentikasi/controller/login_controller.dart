import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
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
    final emailValue = emailController.text;
    final passwordValue = passwordController.text;

    final emailValidation = validateEmail(emailValue);
    final passwordValidation = validatePassword(passwordValue);

    emailError = emailValidation;
    passwordError = passwordValidation;

    return emailValidation == null && passwordValidation == null;
  }

  void navigateToStart(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => StartKaryawan(),
      ),
    );
  }

  Future<void> handleLogin(BuildContext context) async {
    if (validateForm()) {
      bool loggedIn = await login(); // Tunggu sampai proses login selesai
      if (loggedIn) {
        navigateToStart(
            context); // Navigasi ke halaman StartKaryawan setelah login berhasil
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
  }

  Future<bool> login() async {
    var data = {
      'email': emailController.text,
      'password': passwordController.text,
    };

    var res = await Network().auth(data, '/login');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString(
          'token', json.encode(body['payload']['data']['access_token']));
      localStorage.setString('user', json.encode(body['user']));
      return true; // Jika login berhasil
    } else {
      return false; // Jika login gagal
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

// class LoginController {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   String? emailError;
//   String? passwordError;

//   String? validateEmail(String? emailValue) {
//     if (emailValue == null || emailValue.isEmpty) {
//       return 'Masukkan email';
//     } else {
//       final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
//       if (!emailRegex.hasMatch(emailValue)) {
//         return 'Format email tidak valid';
//       }
//     }
//     return null;
//   }

//   String? validatePassword(String? passwordValue) {
//     if (passwordValue == null || passwordValue.isEmpty) {
//       return 'Masukkan password';
//     }
//     return null;
//   }

//   bool validateForm() {
//     final emailValue = emailController.text;
//     final passwordValue = passwordController.text;

//     final emailValidation = validateEmail(emailValue);
//     final passwordValidation = validatePassword(passwordValue);

//     emailError = emailValidation;
//     passwordError = passwordValidation;

//     return emailValidation == null && passwordValidation == null;
//   }

//   void navigateToStart(BuildContext context) {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => StartKaryawan(),
//       ),
//     );
//   }

//   Future<void> handleLogin(BuildContext context) async {
//     if (validateForm()) {
//       bool loggedIn = await login(); // Tunggu sampai proses login selesai
//       if (loggedIn) {
//         navigateToStart(
//             context); // Navigasi ke halaman StartKaryawan setelah login berhasil
//       } else {
//         final snackBar = SnackBar(
//           elevation: 0,
//           behavior: SnackBarBehavior.floating,
//           backgroundColor: Colors.transparent,
//           content: AwesomeSnackbarContent(
//             title: 'Info',
//             message:
//                 'Harap periksa kembali akun yang anda masukan, akun yang anda masukan belum terdaftar',
//             contentType: ContentType.failure,
//           ),
//         );

//         ScaffoldMessenger.of(context)
//           ..hideCurrentSnackBar()
//           ..showSnackBar(snackBar);
//       }
//     }
//   }

//   Future<bool> login() async {
//     var data = {
//       'email': emailController.text,
//       'password': passwordController.text,
//     };

//     var res = await Network().auth(data, '/login');
//     var body = json.decode(res.body);
//     if (res.statusCode == 200) {
//       SharedPreferences localStorage = await SharedPreferences.getInstance();
//       localStorage.setString('token', json.encode(body['access_token']));
//       localStorage.setString('user', json.encode(body['user']));
//       return true; // Jika login berhasil
//     } else {
//       return false; // Jika login gagal
//     }
//   }

//   void navigateToRegister(BuildContext context) {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (context) => const RegisterPage(),
//       ),
//     );
//   }
// }
