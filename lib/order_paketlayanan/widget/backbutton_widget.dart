import 'package:flutter/material.dart';
import 'package:outsourcing/components/text_widget.dart';

class BackButtonWidget2 extends StatefulWidget {
  final void Function() animator;
  final BuildContext context;

  const BackButtonWidget2({
    Key? key,
    required this.animator,
    required this.context,
  }) : super(key: key);

  @override
  State<BackButtonWidget2> createState() => _BackButtonState();
}

class _BackButtonState extends State<BackButtonWidget2> {
  double opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 300),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                opacity = 0.0; // Mengubah opacity menjadi 0 saat tombol ditekan
              });
              widget.animator();
              Future.delayed(const Duration(milliseconds: 300), () {
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
                  "Paket Layanan",
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
