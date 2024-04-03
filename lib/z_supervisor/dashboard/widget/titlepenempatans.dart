import 'package:flutter/material.dart';
import 'package:outsourcing/z_autentikasi/view/login_page.dart';
import 'package:outsourcing/components/text_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TitlePenempatanSWidget extends StatefulWidget {
  final void Function() animator;
  final BuildContext context;
  final String labelText;

  const TitlePenempatanSWidget({
    Key? key,
    required this.animator,
    required this.context,
    required this.labelText,
  }) : super(key: key);

  @override
  State<TitlePenempatanSWidget> createState() => _TitlePenempatanSState();
}

class _TitlePenempatanSState extends State<TitlePenempatanSWidget> {
  double opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 300),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(
            widget.labelText,
            25,
            const Color.fromRGBO(45, 3, 59, 1),
            FontWeight.bold,
            letterSpace: 0,
          ),
          InkWell(
            onTap: () {
              _showLogoutConfirmationDialog(context);
            },
            child: const Icon(
              Icons.logout_outlined,
              color: Color.fromRGBO(45, 3, 59, 1),
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text('Anda yakin ingin logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Tutup dialog tanpa melakukan logout
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Tutup dialog sebelum melakukan logout
                logout(context); // Panggil fungsi logout setelah menutup dialog
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  Future<void> logout(BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('token');
    localStorage.remove('supervisor');
    print('Token setelah logout: ${localStorage.getString('token')}');
    print('Supervisor setelah logout: ${localStorage.getString('supervisor')}');

    // Navigasi ke halaman login atau halaman awal aplikasi setelah logout
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}
