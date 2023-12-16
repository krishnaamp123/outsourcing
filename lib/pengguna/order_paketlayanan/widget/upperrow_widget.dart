import 'dart:async';

import 'package:flutter/material.dart';
import 'package:outsourcing/components/text_widget.dart';

class UpperRowWidget extends StatefulWidget {
  final Function animator;
  final BuildContext context;

  const UpperRowWidget({
    Key? key,
    required this.animator,
    required this.context,
  }) : super(key: key);

  @override
  State<UpperRowWidget> createState() => _UpperRowWidgetState();
}

class _UpperRowWidgetState extends State<UpperRowWidget> {
  double opacity = 1.0;
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 400),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              widget.animator();
              Timer(const Duration(milliseconds: 600), () {
                Navigator.pop(context);
              });
            },
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Color.fromRGBO(45, 3, 59, 1),
              size: 30,
            ),
          ),
          const Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                  "Layanan Kami",
                  25,
                  Color.fromRGBO(45, 3, 59, 1),
                  FontWeight.bold,
                  letterSpace: 0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
