import 'package:flutter/material.dart';
import 'package:outsourcing/components/text_widget.dart';

class ButtonPesanan extends StatefulWidget {
  const ButtonPesanan({super.key});

  @override
  State<ButtonPesanan> createState() => _ButtonPesananState();
}

class _ButtonPesananState extends State<ButtonPesanan> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Menampilkan pop-up "Pesanan dibuat" ketika tombol ditekan
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const TextWidget(
                "Konfirmasi",
                20,
                Color.fromRGBO(45, 3, 59, 1),
                FontWeight.bold,
                letterSpace: 0,
                textAlign: TextAlign.left,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TextWidget(
                    "Upload file MOU\nPastikan file telah ditandatangani",
                    15,
                    Color.fromRGBO(193, 71, 233, 1),
                    FontWeight.normal,
                    letterSpace: 0,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Fungsi untuk mengunggah file PDF
                    },
                    icon: const Icon(Icons.upload_file),
                    label: const Text('Upload PDF'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(193, 71, 233, 1),
                      shadowColor: Colors.white, // Warna teks
                      minimumSize: const Size(240, 40),
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const TextWidget(
                    "Buat Pesanan",
                    18,
                    Color.fromRGBO(45, 3, 59, 1),
                    FontWeight.bold,
                    letterSpace: 0,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 70),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: TextWidget(
            "Buat Pesanan",
            16,
            Colors.white,
            FontWeight.bold,
            letterSpace: 0,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
