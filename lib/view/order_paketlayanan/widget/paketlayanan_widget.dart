import 'package:flutter/material.dart';
import 'package:outsourcing/components/text_widget.dart';

class PaketLayananWidget extends StatelessWidget {
  final String name;
  final String desc;

  const PaketLayananWidget({
    Key? key,
    required this.name,
    required this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: Row(
          children: [
            const SizedBox(
              width: 15,
            ),
            TextWidget(
              name,
              18,
              const Color.fromRGBO(45, 3, 59, 1),
              FontWeight.bold,
              letterSpace: 0,
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 5,
            ),
            TextWidget(
              desc,
              15,
              const Color.fromRGBO(193, 71, 233, 1),
              FontWeight.normal,
              letterSpace: 0,
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
