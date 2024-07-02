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

  String? usernameError;
  String? emailError;
  String? passwordError;
  String? alamatError;
  String? nikError;
  String? telponError;
  String? tempatError;

  int? selectedDomisili;
  DateTime? selectedDate;
  String? selectedGender;

  String? validateUsername(String? usernameValue) {
    if (usernameValue == null || usernameValue.isEmpty) {
      //print("Username is empty");
      return 'Masukkan nama lengkap';
    }
    return null;
  }

  String? validateEmail(String? emailValue) {
    if (emailValue == null || emailValue.isEmpty) {
      //print("Email is empty");
      return 'Masukkan email';
    } else {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(emailValue)) {
        //print("Email format is invalid");
        return 'Format email tidak valid';
      }
    }
    return null;
  }

  String? validatePassword(String? passwordValue) {
    if (passwordValue == null || passwordValue.isEmpty) {
      //print("Password is empty");
      return 'Masukkan password';
    } else if (passwordValue.length < 6) {
      //print("Password format is invalid");
      return 'Password harus memiliki minimal 6 karakter';
    }
    return null;
  }

  String? validateAlamat(String? alamatValue) {
    if (alamatValue == null || alamatValue.isEmpty) {
      //print("Alamat is empty");
      return 'Masukkan alamat';
    }
    return null;
  }

  String? validateNIK(String? nikValue) {
    if (nikValue == null || nikValue.isEmpty) {
      //print("NIK is empty");
      return 'Masukkan nomor NIK';
    } else if (nikValue.length < 16) {
      //print("NIK format is invalid");
      return 'Nomor NIK harus memiliki minimal 16 karakter';
    }
    return null;
  }

  String? validateTelpon(String? telponValue) {
    if (telponValue == null || telponValue.isEmpty) {
      //print("Telpon is empty");
      return 'Masukkan nomor telpon';
    } else if (telponValue.length < 11) {
      //print("Telpon format is invalid");
      return 'Nomor telpon harus memiliki minimal 11 karakter';
    }
    return null;
  }

  String? validateTempat(String? tempatValue) {
    if (tempatValue == null || tempatValue.isEmpty) {
      //print("Tempat is empty");
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

    //print("Username error: $usernameError");
    //print("Email error: $emailError");
    //print("Password error: $passwordError");
    //print("Alamat error: $alamatError");
    //print("NIK error: $nikError");
    //print("Telpon error: $telponError");
    //print("Tempat error: $tempatError");
    //print("isDateSelected: $selectedDate");
    //print("selectedDomisili: $selectedDomisili");
    //print("selectedGender: $selectedGender");

    return usernameValidation == null &&
        emailValidation == null &&
        passwordValidation == null &&
        alamatValidation == null &&
        nikValidation == null &&
        telponValidation == null &&
        tempatValidation == null &&
        selectedDate != null &&
        selectedDomisili != null &&
        selectedGender != null;
  }

  Future<void> handleSignin(BuildContext context) async {
    if (validateForm()) {
      print("Form is valid");
      bool signedIn = await signin();
      if (signedIn) {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        print("Sign-in successful");
        var userregis = localStorage.getString('userregis');
        print('userprofile: $userregis');
        navigateToOTP(context);
      } else {
        print("Sign-in failed");
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Info',
            message:
                'Harap periksa kembali akun yang anda masukan, akun anda sudah terdaftar',
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } else {
      print("Form is not valid");
    }
  }

  Future<bool> signin() async {
    var data = {
      'Email': emailController.text,
      'Password': passwordController.text,
      'service_user_profile': {
        'Fullname': usernameController.text,
        'Regency_ID': selectedDomisili,
        'Full_Address': alamatController.text,
        'Birth_Place': tempatController.text,
        'Birth_Date': selectedDate!.toUtc().toIso8601String(),
        'Phone': telponController.text,
        'NIK': nikController.text,
        'Gender': selectedGender.toString(),
      }
    };

    var res = await Network().auth(data, '/service_user/register/');
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['data']['token']);
      localStorage.setString('userregis',
          json.encode(body['data']['registered_user']['service_user_profile']));
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
            'Terimakasih telah mendaftarkan akun, harap melakukan verifikasi melalui email',
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
