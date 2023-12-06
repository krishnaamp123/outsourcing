import 'package:flutter/material.dart';
import 'package:outsourcing/components/text_widget.dart';

class TextFieldLayanan extends StatelessWidget {
  final controller;
  final String upText;
  final String hintText;
  final bool obscureText;

  const TextFieldLayanan({
    super.key,
    required this.controller,
    required this.upText,
    required this.hintText,
    required this.obscureText,
    required String? Function(dynamic value) validator,
    required Null Function(dynamic _) onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(children: [
        Container(
          alignment: Alignment.centerLeft,
          child: TextWidget(
            upText,
            15,
            const Color.fromRGBO(129, 12, 168, 1),
            FontWeight.normal,
            letterSpace: 0,
            textAlign: TextAlign.left,
          ),
        ),
        const SizedBox(height: 5),
        Card(
          elevation: 5, // Atur elevation di sini
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Atur radius di sini
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              fillColor: Colors.white,
              filled: true,
              hintText: hintText,
            ),
          ),
        )
      ]),
    );
  }
}
