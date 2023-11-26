import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    iconTheme: const IconThemeData(
      size: 30,
      color: Color.fromRGBO(45, 3, 59, 1),
    ), // set backbutton color here which will reflect in all screens.
    leading: const BackButton(),
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}
