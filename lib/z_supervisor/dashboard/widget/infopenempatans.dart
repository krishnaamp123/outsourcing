import 'package:flutter/material.dart';
import 'package:outsourcing/core.dart';

class InfoPenempatanSWidget extends StatefulWidget {
  final void Function() animator;
  final BuildContext context;

  const InfoPenempatanSWidget({
    Key? key,
    required this.animator,
    required this.context,
  }) : super(key: key);

  @override
  State<InfoPenempatanSWidget> createState() => _InfoPenempatanSState();
}

class _InfoPenempatanSState extends State<InfoPenempatanSWidget> {
  double opacity = 1.0;
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 400),
      opacity: opacity,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          height: 100,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(229, 184, 244, 1),
                Color.fromRGBO(129, 12, 168, 1),
                Color.fromRGBO(45, 3, 59, 1),
              ],
            ),
          ),
          child: const Row(
            children: [
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(
                    "Penempatan Supervisor Info :",
                    18,
                    Colors.white,
                    FontWeight.bold,
                    letterSpace: 0,
                  ),
                  SizedBox(height: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextWidget(
                        "Jangan lupa untuk melakukan pengecekan berkala\nterhadap karyawan dan juga kepuasan pengguna",
                        14,
                        Colors.white,
                        FontWeight.normal,
                        letterSpace: 0,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
