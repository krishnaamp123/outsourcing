import 'package:flutter/material.dart';

class ResponseWidget extends StatefulWidget {
  const ResponseWidget({super.key});

  @override
  State<ResponseWidget> createState() => _ResponseWidgetState();
}

class _ResponseWidgetState extends State<ResponseWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Response"),
    );
  }
}
