import 'package:flutter/material.dart';
import 'package:outsourcing/components/text_widget.dart';

class ButtonLanjut extends StatelessWidget {
  final Function()? onTap;

  const ButtonLanjut({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(45, 3, 59, 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const TextWidget(
          "Berikutnya",
          16,
          Colors.white,
          FontWeight.normal,
          letterSpace: 0,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
