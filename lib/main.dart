import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:outsourcing/pages/dashboard.dart';
import 'package:outsourcing/pages/history.dart';
import 'package:outsourcing/pages/order.dart';
import 'package:outsourcing/pages/profile/profile_user.dart';
import 'package:outsourcing/pages/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedSplashScreen(
        splash: Image.asset('lib/images/logotok.png'),
        splashIconSize: double.infinity,
        duration: 3000,
        splashTransition: SplashTransition.fadeTransition,
        nextScreen: const Splash(),
      ),
    );
  }
}

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  final items = const [
    Icon(
      Icons.home_filled,
      color: Colors.white,
      size: 30,
    ),
    Icon(
      Icons.payment,
      color: Colors.white,
      size: 30,
    ),
    Icon(
      Icons.history_rounded,
      color: Colors.white,
      size: 30,
    ),
    Icon(
      Icons.person,
      color: Colors.white,
      size: 30,
    ),
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        items: items,
        index: index,
        onTap: (selectedIndex) {
          setState(() {
            index = selectedIndex;
          });
        },
        color: const Color.fromRGBO(45, 3, 59, 1),
        backgroundColor: Colors.white,
        buttonBackgroundColor: const Color.fromRGBO(45, 3, 59, 1),
        height: 60,
      ),
      body: Container(
        child: getSelectedWidget(index: index),
      ),
    );
  }

  Widget getSelectedWidget({required int index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = const Home();
        break;
      case 1:
        widget = const Order();
        break;
      case 2:
        widget = const History();
        break;
      case 3:
        widget = ProfileUser();
        break;
      default:
        widget = const Home();
        break;
    }
    return widget;
  }
}
