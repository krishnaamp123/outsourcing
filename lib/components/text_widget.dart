import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight fontWeight;
  final double letterSpace;
  final TextAlign textAlign; // Tambahkan parameter TextAlign

  const TextWidget(
    this.text,
    this.size,
    this.color,
    this.fontWeight, {
    this.letterSpace = 3,
    this.textAlign = TextAlign.left, // Tetapkan nilai default TextAlign
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign, // Gunakan nilai TextAlign yang diberikan
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
        letterSpacing: letterSpace,
      ),
    );
  }
}
