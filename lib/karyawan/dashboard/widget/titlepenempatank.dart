import 'package:flutter/material.dart';
import 'package:outsourcing/components/text_widget.dart';

class TitlePenempatanKWidget extends StatefulWidget {
  final void Function() animator;
  final BuildContext context;
  final String labelText;

  const TitlePenempatanKWidget({
    Key? key,
    required this.animator,
    required this.context,
    required this.labelText,
  }) : super(key: key);

  @override
  State<TitlePenempatanKWidget> createState() => _TitlePenempatanKState();
}

class _TitlePenempatanKState extends State<TitlePenempatanKWidget> {
  double opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 300),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextWidget(
            widget.labelText,
            25,
            const Color.fromRGBO(45, 3, 59, 1),
            FontWeight.bold,
            letterSpace: 0,
          ),
        ],
      ),
    );
  }
}
