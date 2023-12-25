import 'package:flutter/material.dart';
import 'package:outsourcing/components/text_widget.dart';

class ButtonPenilaian extends StatefulWidget {
  const ButtonPenilaian({super.key});

  @override
  State<ButtonPenilaian> createState() => _ButtonPenilaianState();
}

class _ButtonPenilaianState extends State<ButtonPenilaian> {
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
                    "Unggah Penilaian",
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
                    "Unggah file penilaian anda\nPastikan penilaian sudah diisi",
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
                    label: const Text('Unggah Penilaian',
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
            "Unggah Penilaian",
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
