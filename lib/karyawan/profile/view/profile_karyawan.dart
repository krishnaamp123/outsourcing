import 'dart:async';

import 'package:flutter/material.dart';
import 'package:outsourcing/components/text_widget.dart';

// This class handles the Page to dispaly the user's info on the "Edit Profile" Screen
class ProfileKaryawan extends StatefulWidget {
  const ProfileKaryawan({super.key});

  @override
  State<ProfileKaryawan> createState() => _ProfileKaryawanState();
}

class _ProfileKaryawanState extends State<ProfileKaryawan> {
  var opacity = 0.0;
  bool position = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      animator();

      setState(() {});
    });
  }

  animator() {
    if (opacity == 1) {
      opacity = 0;
      position = false;
    } else {
      opacity = 1;
      position = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(top: 60, left: 0, right: 0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 400),
            top: position ? 1 : 100,
            right: 20,
            left: 20,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              opacity: opacity,
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: TextWidget(
                    "Profile",
                    25,
                    Color.fromRGBO(45, 3, 59, 1),
                    FontWeight.bold,
                    letterSpace: 0,
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
