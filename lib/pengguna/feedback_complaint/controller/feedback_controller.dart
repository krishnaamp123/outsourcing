import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class FeedbackController {
  final TextEditingController feedbacktextController = TextEditingController();
  String? feedbackError;

  String? validateFeedback(String? value) {
    if (value == null || value.isEmpty) {
      feedbackError = 'Masukkan feedback';
      return feedbackError;
    }
    feedbackError = null;
    return null;
  }

  void onKirimPressed(BuildContext context) {
    if (feedbacktextController.text.isEmpty) {
      feedbackError = 'Masukkan feedback';
    } else {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Info',
          message:
              'Terimakasih atas masukannya, kami akan berusaha memperbaikinya',
          contentType: ContentType.help,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }
}
