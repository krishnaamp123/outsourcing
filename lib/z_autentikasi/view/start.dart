import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:outsourcing/core.dart';
import 'package:outsourcing/z_pengguna/profile/view/profileuser.dart';

class Start extends StatefulWidget {
  // final String service_user;
  const Start({Key? key}) : super(key: key);

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
        child: getSelectedWidget(index: index),
      ),
    );
  }

  Widget getSelectedWidget({required int index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = Home();
        break;
      case 1:
        widget = Order();
        break;
      case 2:
        widget = FeedbackComplaint();
        break;
      case 3:
        widget = ProfilePage();
        break;
      default:
        widget = Home();
        break;
    }
    return widget;
  }
}
