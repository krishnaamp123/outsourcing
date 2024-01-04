import 'package:flutter/material.dart';
import 'package:outsourcing/components/text_widget.dart';

class TextFieldRC extends StatelessWidget {
  final TextEditingController controller;
  final String upText;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const TextFieldRC({
    Key? key,
    required this.controller,
    required this.upText,
    required this.hintText,
    required this.obscureText,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Column(
        children: [
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
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            onChanged: onChanged,
            validator: validator,
            maxLines: null,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              fillColor: Colors.grey.shade100,
              filled: true,
              hintText: hintText,
            ),
          ),
        ],
      ),
    );
  }
}
