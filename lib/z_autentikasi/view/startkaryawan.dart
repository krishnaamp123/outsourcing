import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:outsourcing/z_karyawan/dashboard/view/dashboard_karyawan.dart';
import 'package:outsourcing/z_karyawan/profile/view/profile_karyawan.dart';

class StartKaryawan extends StatefulWidget {
  // final String employee;
  const StartKaryawan({Key? key}) : super(key: key);

  @override
  State<StartKaryawan> createState() => _StartKaryawanState();
}

class _StartKaryawanState extends State<StartKaryawan> {
  final items = const [
    Icon(
      Icons.home_filled,
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
        widget = const HomeKaryawan();
        break;
      case 1:
        widget = const ProfileKaryawan();
        break;
      default:
        widget = const HomeKaryawan();
        break;
    }
    return widget;
  }
}
