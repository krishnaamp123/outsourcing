import 'dart:async';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:outsourcing/service/complaint_service.dart';

class ComplaintDialogWidget extends StatefulWidget {
  final Function()? onTap;
  final int id;

  const ComplaintDialogWidget({
    Key? key,
    required this.id,
    this.onTap,
  }) : super(key: key);

  @override
  State<ComplaintDialogWidget> createState() => _ComplaintDialogWidgetState();
}

class _ComplaintDialogWidgetState extends State<ComplaintDialogWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();
  final complaint = ComplaintService();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _sendComplaint(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // Ganti dengan metode yang sesuai untuk mengirim complaint ke server
      Navigator.of(context).pop();
      var response =
          await complaint.postComplaint(_commentController.text, widget.id);
      if (response.statusCode == 201) {
        // Menampilkan snackbar sukses setelah pengiriman berhasil
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Info',
            message:
                'Complaint berhasil dikirimkan, mohon menunggu respon dari supervisor!',
            contentType: ContentType.success,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar); // Menutup dialog
      } else {
        // Menampilkan snackbar error jika pengiriman gagal
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Info',
            message:
                'Complaint gagal dikirimkan, mohon periksa kembali inputan anda!',
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
        "Ajukan Complaint",
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
            TextFormField(
              controller: _commentController,
              decoration: const InputDecoration(
                labelText: 'Complaint',
                labelStyle: TextStyle(
                  color: Color.fromRGBO(129, 12, 168, 1),
                ), // Warna label diubah menjadi ungu
                hintText: 'ex: Karyawan menghilang...',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Complaint tidak boleh kosong';
                }
                return null;
              },
              maxLines: 2, // Mengubah agar teks memanjang ke bawah
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            _sendComplaint(context); // Mengirim complaint
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
