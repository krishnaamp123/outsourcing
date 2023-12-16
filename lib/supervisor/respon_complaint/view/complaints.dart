import 'package:flutter/material.dart';

class ComplaintSWidget extends StatefulWidget {
  const ComplaintSWidget({super.key});

  @override
  State<ComplaintSWidget> createState() => _ComplaintSWidgetState();
}

class _ComplaintSWidgetState extends State<ComplaintSWidget> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Complaint"),
    );
  }
}
