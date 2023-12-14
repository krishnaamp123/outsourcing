import 'package:flutter/material.dart';

class ButtonTanggal extends StatefulWidget {
  const ButtonTanggal({
    super.key,
  });

  @override
  State<ButtonTanggal> createState() => _ButtonTanggalState();
}

class _ButtonTanggalState extends State<ButtonTanggal> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final DateTime? dateTime = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
        );
        if (dateTime != null) {
          setState(() {
            selectedDate = dateTime;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 80),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(45, 3, 59, 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            "${selectedDate.year} - ${selectedDate.month} - ${selectedDate.day}",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
