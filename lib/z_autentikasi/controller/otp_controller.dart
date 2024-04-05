import 'package:flutter/material.dart';
import '../../core.dart';

class OTPController {
  void checkEmail(BuildContext context) {
    Navigator.pop(
      context,
    );
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
