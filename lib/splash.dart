import 'dart:async';
import 'package:flutter/material.dart';
import 'package:outsourcing/components/text_widget.dart';
import 'package:outsourcing/z_autentikasi/view/login_page.dart';

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
              curve: Curves.decelerate,
              duration: const Duration(milliseconds: 400),
              child: Center(
                child: Image.asset(
                  'lib/images/logotok.png',
                  height: 100,
                  width: 100,
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              top: _showContent ? 90 : 150,
              left: 20,
              right: 20,
              child: AnimatedOpacity(
                opacity: _showContent ? 1.0 : 0.0,
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 400),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Center(
                      child: TextWidget(
                        "Penyedia",
                        35,
                        Color.fromRGBO(45, 3, 59, 1),
                        FontWeight.bold,
                        letterSpace: 8,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Center(
                      child: TextWidget(
                        "Layanan",
                        35,
                        Color.fromRGBO(45, 3, 59, 1),
                        FontWeight.bold,
                        letterSpace: 11,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Center(
                      child: TextWidget(
                        "Outsourcing",
                        35,
                        Color.fromRGBO(45, 3, 59, 1),
                        FontWeight.bold,
                        letterSpace: 1,
                      ),
                    ),
                    Center(
                      child: Image.asset(
                        'lib/images/landingpage.jpg',
                        height: 300,
                        width: 500,
                      ),
                    ),
                    const Center(
                      child: TextWidget("Cari Jasa Outsourcing?", 18,
                          Color.fromRGBO(129, 12, 168, 1), FontWeight.bold,
                          letterSpace: 2),
                    ),
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'lib/images/logonyamping.png',
                            height: 50,
                            width: 190,
                          ),
                          const TextWidget(
                            "Aja!",
                            18,
                            Color.fromRGBO(129, 12, 168, 1),
                            FontWeight.bold,
                            letterSpace: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedPositioned(
              bottom: 80,
              duration: const Duration(milliseconds: 400),
              left: _showContent ? 70 : -100,
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
                    width: 250,
                    height: 50,
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
