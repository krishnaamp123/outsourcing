import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class ResponseSController {
  final TextEditingController responsetextController = TextEditingController();
  String? responsesError;

  String? validateResponse(String? value) {
    if (value == null || value.isEmpty) {
      responsesError = 'Masukkan response';
      return responsesError;
    }
    responsesError = null;
    return null;
  }

  void onKirimPressed(BuildContext context) {
    if (responsetextController.text.isEmpty) {
      responsesError = 'Masukkan response';
    } else {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Info',
          message:
              'Terimakasih telah melakukan respon, semoga pengguna puas dengan response anda',
          contentType: ContentType.help,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }
}
