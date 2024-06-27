import 'dart:async';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:outsourcing/components/text_widget.dart';
import 'package:outsourcing/service/response_service.dart';

class ResponseDialogWidget extends StatefulWidget {
  final Function()? onTap;
  final int id;
  final String namapemesan;
  final String namakaryawan;
  final String comment;
  final String reply;

  const ResponseDialogWidget({
    Key? key,
    required this.id,
    required this.namapemesan,
    required this.namakaryawan,
    required this.comment,
    required this.reply,
    this.onTap,
  }) : super(key: key);

  @override
  State<ResponseDialogWidget> createState() => _ResponseDialogWidgetState();
}

class _ResponseDialogWidgetState extends State<ResponseDialogWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final _responController = TextEditingController();
  final respon = ResponseService();

  @override
  void dispose() {
    _responController.dispose();
    super.dispose();
  }

  Future<void> _sendResponse(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // Ganti dengan metode yang sesuai untuk mengirim complaint ke server
      Navigator.of(context).pop();
      var response =
          await respon.postResponse(_responController.text, widget.id);
      if (response.statusCode == 201) {
        // Menampilkan snackbar sukses setelah pengiriman berhasil
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Info',
            message:
                'Response berhasil dikirimkan, terimakasih telah merespon pengguna!',
            contentType: ContentType.success,
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
                'Response gagal dikirimkan, mohon periksa kembali inputan anda!',
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
    String namapemesan = widget.namapemesan;
    String namakaryawan = widget.namakaryawan;
    String comment = widget.comment;
    return AlertDialog(
      title: const Text(
        "Ajukan Response",
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const TextWidget(
              'Pemesan :',
              15,
              Color.fromRGBO(129, 12, 168, 1),
              FontWeight.normal,
              letterSpace: 0,
              textAlign: TextAlign.left,
            ),
            TextWidget(
              namapemesan,
              15,
              const Color.fromRGBO(45, 3, 59, 1),
              FontWeight.normal,
              letterSpace: 0,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 5),
            const TextWidget(
              'Karyawan :',
              15,
              Color.fromRGBO(129, 12, 168, 1),
              FontWeight.normal,
              letterSpace: 0,
              textAlign: TextAlign.left,
            ),
            TextWidget(
              namakaryawan,
              15,
              const Color.fromRGBO(45, 3, 59, 1),
              FontWeight.normal,
              letterSpace: 0,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 5),
            const TextWidget(
              'Complaint :',
              15,
              Color.fromRGBO(129, 12, 168, 1),
              FontWeight.normal,
              letterSpace: 0,
              textAlign: TextAlign.left,
            ),
            TextWidget(
              comment,
              15,
              const Color.fromRGBO(45, 3, 59, 1),
              FontWeight.normal,
              letterSpace: 0,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _responController,
              decoration: const InputDecoration(
                labelText: 'Response',
                labelStyle: TextStyle(
                  color: Color.fromRGBO(129, 12, 168, 1),
                ),
                hintText: 'ex: Maaf sebelumnya...',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Response tidak boleh kosong';
                }
                return null;
              },
              maxLines: 2,
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            _sendResponse(context); // Mengirim complaint
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
