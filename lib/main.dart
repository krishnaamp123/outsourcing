import 'package:outsourcing/core.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

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
      theme: ThemeData(primarySwatch: Colors.purple),
    );
  }
}

class Start extends StatefulWidget {
  final String username;
  const Start({Key? key, required this.username}) : super(key: key);

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

  int index = 1;

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
        child: getSelectedWidget(index: index, username: widget.username),
      ),
    );
  }

  Widget getSelectedWidget({required int index, required String username}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = Home(username: username);
        break;
      case 1:
        widget = Order(username: username);
        break;
      case 2:
        widget = FeedbackComplaint(username: username);
        break;
      case 3:
        widget = const ProfileUser();
        break;
      default:
        widget = Order(username: username);
        break;
    }
    return widget;
  }
}
