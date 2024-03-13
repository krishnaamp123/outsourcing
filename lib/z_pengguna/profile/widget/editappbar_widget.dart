import 'package:flutter/material.dart';

AppBar buildEditAppBar(BuildContext context) {
  return AppBar(
    iconTheme: const IconThemeData(
      size: 30,
      color: Color.fromRGBO(45, 3, 59, 1),
    ),
    leading: Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: IconButton(
        icon: const Icon(Icons.arrow_back_ios_rounded),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ),
    title: const Text(
      'Profile',
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        letterSpacing: 0,
        color: Color.fromRGBO(45, 3, 59, 1),
      ),
    ),
    centerTitle: true,
    toolbarHeight: 110,
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}
