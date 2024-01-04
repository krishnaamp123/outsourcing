import 'package:flutter/material.dart';
import 'package:outsourcing/z_autentikasi/view/login_page.dart';
import 'package:outsourcing/components/text_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TitlePenempatanKWidget extends StatefulWidget {
  final void Function() animator;
  final BuildContext context;
  final String labelText;

  const TitlePenempatanKWidget({
    Key? key,
    required this.animator,
    required this.context,
    required this.labelText,
  }) : super(key: key);

  @override
  State<TitlePenempatanKWidget> createState() => _TitlePenempatanKState();
}

class _TitlePenempatanKState extends State<TitlePenempatanKWidget> {
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
              logout(widget.context);
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

  Future<void> logout(BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('token');
    localStorage.remove('karyawan');

    // Navigasi ke halaman login atau halaman awal aplikasi setelah logout
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}
//   void logout() async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();
//     var token = localStorage.getString('access_token');
//     localStorage.remove('token');
//     Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (context) => LoginPage()));
//   }
// }

// void logout() async {
//     var res = await Network().getData('/logout');
//     var body = json.decode(res.body);
//     if (res.statusCode == 200) {
//       SharedPreferences localStorage = await SharedPreferences.getInstance();
//       localStorage.remove('user');
//       localStorage.remove('token');
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (context) => LoginPage()));
//     }
//   }
// }
