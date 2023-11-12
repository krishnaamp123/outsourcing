import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomNavigationBar(
          showUnselectedLabels: false,
          showSelectedLabels: false,
          items: const [
            BottomNavigationBarItem(
                label: "HH",
                icon: Icon(
                  Icons.home_filled,
                  color: Color.fromRGBO(129, 12, 168, 1),
                )),
            BottomNavigationBarItem(
                label: "HH",
                icon: Icon(
                  Icons.calendar_month_rounded,
                  color: Color.fromRGBO(45, 3, 59, 1),
                )),
            BottomNavigationBarItem(
                label: "HH",
                icon: Icon(
                  Icons.whatshot_outlined,
                  color: Color.fromRGBO(45, 3, 59, 1),
                )),
            BottomNavigationBarItem(
                label: "HH",
                icon: Icon(
                  Icons.account_circle_outlined,
                  color: Color.fromRGBO(45, 3, 59, 1),
                )),
          ]),
    );
  }
}
