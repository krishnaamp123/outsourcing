import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:outsourcing/service/auth_service.dart';
import 'package:outsourcing/core.dart';
import 'package:outsourcing/z_karyawan/dashboard/controller/penempatank_controller.dart';
import 'package:outsourcing/z_karyawan/dashboard/widget/infopenempatank.dart';
import 'package:outsourcing/z_karyawan/dashboard/widget/listpenempatank.dart';
import 'package:outsourcing/z_karyawan/dashboard/widget/titlepenempatank.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeKaryawan extends StatefulWidget {
  // final String username;
  const HomeKaryawan({Key? key}) : super(key: key);

  @override
  State<HomeKaryawan> createState() => _HomeKaryawanState();
}

class _HomeKaryawanState extends State<HomeKaryawan> {
  String name = '';

  var opacity = 0.0;
  bool position = false;
  final _formKey = GlobalKey<FormState>();
  //text editing controllers
  final PenempatanKController penempatankController = PenempatanKController();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      animator();
    });
    _loadUserData();
    _printToken();
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

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userData = localStorage.getString('karyawan');
    if (userData != null) {
      var user = jsonDecode(userData);
      if (user != null && user['fullname'] != null) {
        String fullName = user['fullname'];
        List<String> nameParts =
            fullName.split(' '); // Memisahkan berdasarkan spasi
        String firstName = '';

        if (nameParts.length >= 2) {
          // Pastikan ada minimal 2 kata dalam nama
          firstName =
              '${nameParts[0]} ${nameParts[1]}'; // Mengambil dua kata pertama
        } else {
          firstName =
              fullName; // Jika hanya ada satu kata, gunakan seluruh nama
        }

        setState(() {
          name = firstName;
        });
      }
    }
  }

  void _printToken() async {
    Network network = Network();
    String token = await network.getToken();
    print('Token: $token'); // Cetak token ke debug console
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // String username = widget.username;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 60),
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                top: position ? 1 : 1,
                left: 20,
                right: 20,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: TitlePenempatanKWidget(
                    animator: animator,
                    context: context,
                    labelText: 'Penempatan',
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                top: position ? 50 : 50,
                right: 20,
                left: 20,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'lib/images/logotok.png',
                        height: 40,
                        width: 40,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget("Halo", 15, Colors.black.withOpacity(.7),
                              FontWeight.bold),
                          TextWidget(
                              '${name}',
                              20,
                              const Color.fromARGB(255, 222, 198, 198),
                              FontWeight.bold),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedPositioned(
                  top: position ? 105 : 105,
                  right: 20,
                  left: 20,
                  duration: const Duration(milliseconds: 400),
                  child: AnimatedOpacity(
                    opacity: opacity,
                    duration: const Duration(milliseconds: 400),
                    child: SizedBox(
                      width: size.width,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextWidget(
                            "Status Karyawan : ",
                            18,
                            Color.fromRGBO(45, 3, 59, 1),
                            FontWeight.bold,
                            letterSpace: 0,
                          ),
                          TextWidget(
                            "Aktif",
                            18,
                            Colors.green,
                            FontWeight.bold,
                            letterSpace: 0,
                          ),
                        ],
                      ),
                    ),
                  )),
              AnimatedPositioned(
                top: position ? 140 : 140,
                right: 20,
                left: 20,
                duration: const Duration(milliseconds: 300),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: InfoPenempatanKWidget(
                    animator: animator,
                    context: context,
                  ),
                ),
              ),
              AnimatedPositioned(
                  top: position ? 260 : 260,
                  right: 20,
                  left: 20,
                  duration: const Duration(milliseconds: 400),
                  child: AnimatedOpacity(
                    opacity: opacity,
                    duration: const Duration(milliseconds: 400),
                    child: SizedBox(
                      width: size.width,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextWidget(
                            "Penempatan Karyawan",
                            20,
                            Color.fromRGBO(45, 3, 59, 1),
                            FontWeight.bold,
                            letterSpace: 0,
                          ),
                        ],
                      ),
                    ),
                  )),
              AnimatedPositioned(
                top: position ? 290 : 340,
                left: 20,
                right: 20,
                duration: const Duration(milliseconds: 500),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: opacity,
                  child: const ListPenempatanKWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
