import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:outsourcing/supervisor/dashboard/view/dashboard_supervisor.dart';
import 'package:outsourcing/supervisor/profile/view/profile_supervisor.dart';
import 'package:outsourcing/supervisor/respon_complaint/view/rcpage.dart';

class StartSupervisor extends StatefulWidget {
  // final String supervisor;
  const StartSupervisor({Key? key}) : super(key: key);

  @override
  State<StartSupervisor> createState() => _StartSupervisorState();
}

class _StartSupervisorState extends State<StartSupervisor> {
  final items = const [
    Icon(
      Icons.home_filled,
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
        widget = HomeSupervisor();
        break;
      case 1:
        widget = ResponseComplaint();
        break;
      case 2:
        widget = const ProfileSupervisor();
        break;
      default:
        widget = HomeSupervisor();
        break;
    }
    return widget;
  }
}
