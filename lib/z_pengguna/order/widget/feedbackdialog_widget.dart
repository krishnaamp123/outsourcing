import 'dart:async';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:outsourcing/service/feedback_service.dart';

class FeedbackDialogWidget extends StatefulWidget {
  final Function()? onTap;
  final int id;

  const FeedbackDialogWidget({
    Key? key,
    required this.id,
    this.onTap,
  }) : super(key: key);

  @override
  State<FeedbackDialogWidget> createState() => _FeedbackDialogWidgetState();
}

class _FeedbackDialogWidgetState extends State<FeedbackDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  final _feedbackController = TextEditingController();
  final feedback = FeedbackService();
  int _rating = 1;

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  Future<void> _sendFeedback(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final transactionId = widget.id;
      print('Transaction ID: $transactionId'); // Debug log
      print('Rating: $_rating'); // Debug log
      Navigator.of(context).pop();
      var response = await feedback.postFeedback(
          transactionId, _rating, _feedbackController.text);
      if (response.statusCode == 201) {
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Info',
            message:
                'Feedback berhasil dikirimkan, terima kasih atas masukannya!',
            contentType: ContentType.success,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      } else if (response.statusCode == 409) {
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Info',
            message:
                'Feedback sudah dikirimkan sebelumnya, terima kasih atas masukannya!',
            contentType: ContentType.help,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      } else {
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Info',
            message:
                'Feedback gagal dikirimkan, mohon periksa kembali inputan anda!',
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Ajukan Feedback",
        style: TextStyle(
          color: Color.fromRGBO(45, 3, 59, 1),
          fontWeight: FontWeight.bold,
          letterSpacing: 0,
          fontSize: 18, // Ukuran teks diperkecil
        ),
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RatingBar.builder(
              initialRating: 1,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false, // Tidak mengizinkan setengah bintang
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating =
                      rating.toInt(); // Mengubah nilai rating menjadi integer
                });
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _feedbackController,
              decoration: const InputDecoration(
                labelText: 'Feedback',
                labelStyle: TextStyle(
                  color: Color.fromRGBO(129, 12, 168, 1),
                ),
                hintText: 'ex: Layanan bagus...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Feedback tidak boleh kosong';
                }
                return null;
              },
              maxLines: 3, // Mengubah agar teks memanjang ke bawah
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            _sendFeedback(context); // Mengirim feedback
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Radius tombol
            ),
            backgroundColor: const Color.fromRGBO(193, 71, 233, 1),
          ),
          child: const Text(
            "Kirim",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 0,
            ), // Ukuran teks diperkecil
          ),
        ),
      ],
    );
  }
}
