import 'dart:async';
import 'package:flutter/material.dart';
import 'package:outsourcing/components/text_widget.dart';
import 'package:outsourcing/autentikasi/view/login_page.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  bool _showLogo = true;
  bool _showContent = false;
  bool position = false;
  var opacity = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _showLogo = false;
        _showContent = true;
      });
    });
  }

  animator() async {
    if (opacity == 0) {
      opacity = 1;
      position = true;
    } else {
      opacity = 0;
      position = false;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.white),
        child: Stack(
          children: [
            AnimatedOpacity(
              opacity: _showLogo ? 1.0 : 0.0,
              curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 400),
              child: Center(
                child: Image.asset(
                  'lib/images/logotok.png',
                  height: 200,
                  width: 200,
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              top: _showContent ? 60 : 150,
              left: 20,
              right: 20,
              child: AnimatedOpacity(
                opacity: _showContent ? 1.0 : 0.0,
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 400),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    TextWidget(
                      "Penyedia",
                      35,
                      Color.fromRGBO(45, 3, 59, 1),
                      FontWeight.bold,
                      letterSpace: 5,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextWidget(
                      "Jasa",
                      35,
                      Color.fromRGBO(45, 3, 59, 1),
                      FontWeight.bold,
                      letterSpace: 5,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextWidget(
                      "Kebutuhan",
                      35,
                      Color.fromRGBO(45, 3, 59, 1),
                      FontWeight.bold,
                      letterSpace: 5,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextWidget(
                      "Outsourcing",
                      35,
                      Color.fromRGBO(45, 3, 59, 1),
                      FontWeight.bold,
                      letterSpace: 5,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextWidget("Cari Jasa Outsourcing?\nOutsourcingApp Aja!",
                        18, Color.fromRGBO(129, 12, 168, 1), FontWeight.bold),
                  ],
                ),
              ),
            ),
            AnimatedPositioned(
              bottom: 60,
              duration: const Duration(milliseconds: 400),
              left: _showContent ? 20 : -100,
              child: AnimatedOpacity(
                opacity: _showContent ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 400),
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  child: Container(
                    width: 150,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(45, 3, 59, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Mulai",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
