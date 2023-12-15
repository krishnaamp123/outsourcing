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
        // Menampilkan bottom sheet "Pesanan dibuat" ketika tombol ditekan
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TextWidget(
                    "Konfirmasi",
                    20,
                    Color.fromRGBO(45, 3, 59, 1),
                    FontWeight.bold,
                    letterSpace: 0,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextWidget(
                    "Upload file MOU\nPastikan file telah ditandatangani",
                    15,
                    Colors.black.withOpacity(0.6),
                    FontWeight.bold,
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
                    label: const Text('Upload PDF',
                        style: TextStyle(
                          color: Color.fromRGBO(193, 71, 233, 1),
                        )),
                    icon: const Icon(
                      Icons.upload_file,
                      color: Color.fromRGBO(193, 71, 233, 1),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shadowColor: Colors.purple, // Warna teks
                      minimumSize: const Size(240, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
              ),
            );
          },
        );
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(240, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: const Color.fromRGBO(193, 71, 233, 1),
      ),
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
