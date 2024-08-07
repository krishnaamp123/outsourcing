import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:outsourcing/core.dart';
import 'package:outsourcing/z_supervisor/dashboard/widget/infopenempatans.dart';
import 'package:outsourcing/z_supervisor/dashboard/widget/listplacements.dart';
import 'package:outsourcing/z_supervisor/dashboard/widget/titlepenempatans.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeSupervisor extends StatefulWidget {
  // final String username;
  const HomeSupervisor({Key? key}) : super(key: key);

  @override
  State<HomeSupervisor> createState() => _HomeSupervisorState();
}

class _HomeSupervisorState extends State<HomeSupervisor> {
  String name = '';
  var opacity = 0.0;
  bool position = false;
  String statusnya = '';
  Color statusColor = Colors.orange;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      animator();
    });
    _loadUserData();
    _loadStatusData();
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
    var userData = localStorage.getString('supervisor');
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

  _loadStatusData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var statusData = localStorage.getString('supervisor');
    if (statusData != null) {
      var status = jsonDecode(statusData);
      if (status != null && status['status'] != null) {
        String statuskaryawan = status['status'];
        setState(() {
          if (statuskaryawan == 'ACTIVE') {
            statusnya = 'Aktif';
            statusColor = Colors.green;
          } else if (statuskaryawan == 'NONACTIVE') {
            statusnya = 'Tidak Aktif';
            statusColor = Colors.red;
          } else {
            statusnya = 'Belum Aktif';
            statusColor = Colors.orange;
          }
        });
      } else {
        setState(() {
          statusnya = 'Belum Aktif';
          statusColor = Colors.orange;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 30),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
                  child: TitlePenempatanSWidget(
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
                              '${name}', 20, Colors.black, FontWeight.bold),
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
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const TextWidget(
                            "Status Supervisor : ",
                            18,
                            Color.fromRGBO(45, 3, 59, 1),
                            FontWeight.bold,
                            letterSpace: 0,
                          ),
                          TextWidget(
                            statusnya,
                            18,
                            statusColor,
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
                  child: InfoPenempatanSWidget(
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
                      width: MediaQuery.of(context).size.width,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextWidget(
                            "Penempatan Supervisor",
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
                  child: const ListPlacementSWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
