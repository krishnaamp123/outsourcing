import 'dart:io';

import 'package:flutter/material.dart';

// This class handles the Page to dispaly the user's info on the "Edit Profile" Screen
class PPKaryawan extends StatefulWidget {
  final String imagePath;
  final bool isEdit;
  final VoidCallback onClicked;

  const PPKaryawan({
    Key? key,
    required this.imagePath,
    this.isEdit = false,
    required this.onClicked,
  }) : super(key: key);

  @override
  State<PPKaryawan> createState() => _PPKaryawanState();
}

class _PPKaryawanState extends State<PPKaryawan> {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  //image
  Widget buildImage() {
    final image = widget.imagePath.contains('https://')
        ? NetworkImage(widget.imagePath)
        : FileImage(File(widget.imagePath));

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image as ImageProvider,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: widget.onClicked),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            widget.isEdit ? Icons.add_a_photo : Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
