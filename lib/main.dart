import 'package:outsourcing/autentikasi/view/start.dart';
import 'package:outsourcing/autentikasi/view/startkaryawan.dart';
import 'package:outsourcing/autentikasi/view/startsupervisor.dart';
import 'package:outsourcing/core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CheckAuth(),
      theme: ThemeData(primarySwatch: Colors.purple),
    );
  }
}

class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;
  var roles;

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null) {
      setState(() {
        isAuth = true;
        roles = localStorage.getString('roles'); // Ambil peran (role) pengguna
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (isAuth) {
      // Berdasarkan peran (role) pengguna, tentukan halaman yang akan ditampilkan
      if (roles == 'service_user') {
        child = Start();
      } else if (roles == 'employee') {
        child = StartKaryawan();
      } else if (roles == 'supervisor') {
        child = StartSupervisor();
      } else {
        // Jika peran tidak sesuai, bisa menampilkan halaman default atau splash screen
        child = const Splash();
      }
    } else {
      child = const Splash();
    }

    return Scaffold(
      body: child,
    );
  }
}
