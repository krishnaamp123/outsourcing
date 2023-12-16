import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class ComplaintController {
  final TextEditingController complainttextController = TextEditingController();
  String? complaintError;

  String? validateComplaint(String? value) {
    if (value == null || value.isEmpty) {
      complaintError = 'Masukkan complaint';
      return complaintError;
    }
    complaintError = null;
    return null;
  }

  void onKirimPressed(BuildContext context) {
    if (complainttextController.text.isEmpty) {
      complaintError = 'Masukkan complaint';
    } else {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Info',
          message:
              'Mohon maaf atas ketidaknyamanannya, admin akan merespon sesegera mungkin',
          contentType: ContentType.help,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }
}
