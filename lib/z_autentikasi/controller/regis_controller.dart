import 'dart:convert';

import 'package:get/get.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:outsourcing/model/regency_model.dart';
import 'package:outsourcing/service/auth_service.dart';
import 'package:outsourcing/service/regency_service.dart';
import 'package:outsourcing/z_autentikasi/view/login_page.dart';
import 'package:outsourcing/z_autentikasi/view/otp_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisController extends GetxController implements GetxService {
  var listRegency = <RegencyModel>[].obs;
  final regency = RegencyService();
  var isLoading = false.obs;

  Future<void> getRegency() async {
    isLoading.value = true;
    var response = await regency.getRegency();
    var responsedecode = jsonDecode(response.body);
    listRegency.clear();
    for (var i = 0; i < responsedecode['datas'].length; i++) {
      RegencyModel data = RegencyModel.fromJson(responsedecode['datas'][i]);
      listRegency.add(data);
    }
    isLoading.value = false;
  }

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController nikController = TextEditingController();
  final TextEditingController telponController = TextEditingController();
  final TextEditingController tempatController = TextEditingController();
  bool isDateSelected = false;

  String? usernameError;
  String? emailError;
  String? passwordError;
  String? alamatError;
  String? nikError;
  String? telponError;
  String? tempatError;

  String? validateUsername(String? usernameValue) {
    if (usernameValue == null || usernameValue.isEmpty) {
      return 'Masukkan nama lengkap';
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
    } else if (passwordValue.length < 6) {
      return 'Password harus memiliki minimal 6 karakter';
    }
    return null;
  }

  String? validateAlamat(String? alamatValue) {
    if (alamatValue == null || alamatValue.isEmpty) {
      return 'Masukkan alamat';
    }
    return null;
  }

  String? validateNIK(String? nikValue) {
    if (nikValue == null || nikValue.isEmpty) {
      return 'Masukkan nomor NIK';
    } else if (nikValue.length < 16) {
      return 'Nomor NIK harus memiliki minimal 16 karakter';
    }
    return null;
  }

  String? validateTelpon(String? telponValue) {
    if (telponValue == null || telponValue.isEmpty) {
      return 'Masukkan nomor telpon';
    } else if (telponValue.length < 11) {
      return 'Nomor telpon harus memiliki minimal 11 karakter';
    }
    return null;
  }

  String? validateTempat(String? tempatValue) {
    if (tempatValue == null || tempatValue.isEmpty) {
      return 'Masukkan tempat lahir';
    }
    return null;
  }

  bool validateForm() {
    final usernameValue = usernameController.text;
    final emailValue = emailController.text;
    final passwordValue = passwordController.text;
    final alamatValue = alamatController.text;
    final nikValue = nikController.text;
    final telponValue = telponController.text;
    final tempatValue = tempatController.text;

    final usernameValidation = validateUsername(usernameValue);
    final emailValidation = validateEmail(emailValue);
    final passwordValidation = validatePassword(passwordValue);
    final alamatValidation = validateAlamat(alamatValue);
    final nikValidation = validateNIK(nikValue);
    final telponValidation = validateTelpon(telponValue);
    final tempatValidation = validateTempat(tempatValue);

    usernameError = usernameValidation;
    emailError = emailValidation;
    passwordError = passwordValidation;
    alamatError = alamatValidation;
    nikError = nikValidation;
    telponError = telponValidation;
    tempatError = tempatValidation;

    return usernameValidation == null &&
        emailValidation == null &&
        passwordValidation == null &&
        alamatValidation == null &&
        nikValidation == null &&
        telponValidation == null &&
        tempatValidation == null &&
        isDateSelected;
  }

  Future<void> handleSignin(BuildContext context) async {
    if (validateForm()) {
      bool signedIn = await signin();
      if (signedIn) {
        navigateToOTP(context);
      } else {
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Info',
            message:
                'Harap periksa kembali akun yang anda masukan, akun yang anda masukan sudah terdaftar',
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    }
  }

  Future<bool> signin() async {
    var data = {
      'Fullname': usernameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'address': alamatController.text,
      'identity_card_number': nikController.text,
      'phone': telponController.text,
      'tempat': tempatController.text,
    };

    var res = await Network().auth(data, '/service-users/register/');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token',
          json.encode(body['payload']['data']['tokens']['access_token']));
      localStorage.setString(
          'user',
          json.encode(body['payload']['data']['created_user_profile']
              ['created_profile']));
      return true; // Jika login berhasil
    } else {
      return false; // Jika login gagal
    }
  }

  void navigateToOTP(BuildContext context) async {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Info',
        message:
            'Terimakasih telah mendaftarkan akun anda, harap melakukan verifikasi melalui email',
        contentType: ContentType.success,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);

    await Future.delayed(Duration(seconds: 3));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OTPPage(),
      ),
    );
  }

  void navigateToLoginPage(BuildContext context) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }
}
