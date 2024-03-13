// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class TextFieldEditWidget extends StatefulWidget {
  final String label;
  final String text;
  final ValueChanged<String> onChanged;
  final maxLines;

  const TextFieldEditWidget({
    Key? key,
    required this.label,
    required this.text,
    required this.onChanged,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  State<TextFieldEditWidget> createState() => _TextFieldEditWidgetState();
}

class _TextFieldEditWidgetState extends State<TextFieldEditWidget> {
  late final TextEditingController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    // TODO: implement initState
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
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
          ),
          maxLines: widget.maxLines,
        )
      ],
    );
  }
}
