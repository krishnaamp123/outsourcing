import 'package:outsourcing/core.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
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
