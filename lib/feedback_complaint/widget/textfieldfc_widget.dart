import 'package:flutter/material.dart';
import 'package:outsourcing/components/text_widget.dart';

class TextFieldFC extends StatelessWidget {
  final TextEditingController controller;
  final String upText;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const TextFieldFC({
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
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TextFormField(
              controller: controller,
              obscureText: obscureText,
              maxLines: null,
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
              onChanged: onChanged,
              validator:
                  validator != null ? (value) => validator!(value) : null,
            ),
          )
        ],
      ),
    );
  }
}
