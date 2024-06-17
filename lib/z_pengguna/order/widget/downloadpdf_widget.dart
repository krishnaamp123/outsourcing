import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:outsourcing/components/text_widget.dart';

class DownloadPdfCard extends StatelessWidget {
  const DownloadPdfCard({Key? key}) : super(key: key);

  Future<void> _openPdf(BuildContext context) async {
    try {
      // Get the directory to save the downloaded file.
      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}/test.pdf';

      // Load the PDF file from the assets.
      final byteData = await rootBundle.load('lib/pdf/test.pdf');

      // Write the PDF file to the local file system.
      final file = File(path);
      await file.writeAsBytes(byteData.buffer.asUint8List());

      // Open the PDF file in a viewer.
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PdfViewScreen(path: path),
        ),
      );
    } catch (e) {
      // Handle any errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal untuk membuka file MOU: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openPdf(context),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: const SizedBox(
          height: 50,
          width: 180,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.download,
                color: Colors.blue,
                size: 30,
              ),
              SizedBox(
                height: 0,
              ),
              TextWidget(
                "Unduh MOU",
                18,
                Color.fromRGBO(45, 3, 59, 1),
                FontWeight.bold,
                letterSpace: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PdfViewScreen extends StatelessWidget {
  final String path;

  const PdfViewScreen({Key? key, required this.path}) : super(key: key);

  Future<void> _downloadPdf(BuildContext context) async {
    try {
      final directory = await getExternalStorageDirectory();
      final downloadPath = '${directory!.path}/downloaded_test.pdf';

      // Copy the PDF file to the download directory.
      final file = File(path);
      await file.copy(downloadPath);

      Fluttertoast.showToast(msg: 'File MOU diunduh ke $downloadPath');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Gagal untuk mengunduh file MOU: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0), // Mengatur tinggi AppBar
        child: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Color.fromRGBO(45, 3, 59, 1),
                size: 30,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          title: const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 35.0), // Menambahkan padding bawah
              child: TextWidget(
                'File MOU',
                25,
                Color.fromRGBO(45, 3, 59, 1),
                FontWeight.bold,
                letterSpace: 0,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: IconButton(
                icon: const Icon(
                  Icons.download,
                  color: Color.fromRGBO(45, 3, 59, 1),
                  size: 30,
                ),
                onPressed: () => _downloadPdf(context),
              ),
            ),
          ],
          centerTitle: true,
        ),
      ),
      body: PDFView(
        filePath: path,
      ),
    );
  }
}
