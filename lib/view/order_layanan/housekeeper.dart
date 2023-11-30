// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class HousekeeperPage extends StatefulWidget {
  const HousekeeperPage({Key? key}) : super(key: key);

  @override
  State<HousekeeperPage> createState() => _HousekeeperPageState();
}

class _HousekeeperPageState extends State<HousekeeperPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
