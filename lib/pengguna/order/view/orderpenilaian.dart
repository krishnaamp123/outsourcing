import 'dart:async';
import 'package:flutter/material.dart';
import 'package:outsourcing/core.dart';
import 'package:outsourcing/pengguna/order/widget/buttonpenilaian_widget.dart';

class OrderPenilaian extends StatefulWidget {
  final Function()? onTap;
  final String name;
  final String harga;
  final String alamat;
  final String tanggal;
  final String status;
  final Color colors;

  const OrderPenilaian({
    Key? key,
    required this.name,
    required this.tanggal,
    required this.alamat,
    required this.status,
    required this.harga,
    required this.colors,
    this.onTap,
  }) : super(key: key);

  @override
  State<OrderPenilaian> createState() => _OrderPenilaianState();
}

class _OrderPenilaianState extends State<OrderPenilaian> {
  var animate = false;
  var opacity = 0.0;
  bool position = false;
  late Size size;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      animator();
    });
  }

  animator() {
    if (opacity == 1) {
      opacity = 0;
      animate = true;
      position = false;
    } else {
      opacity = 1;
      animate = false;
      position = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    String harga = widget.harga;
    String alamat = widget.alamat;
    String name = widget.name;
    String tanggal = widget.tanggal;
    String status = widget.status;
    Color colors = widget.colors;
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(top: 60),
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              top: position ? 1 : 50,
              left: 20,
              right: 20,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: opacity,
                child: BackButtonWidget(
                  animator: animator,
                  context: context,
                  labelText: 'Detail Order',
                ),
              ),
            ),
            AnimatedPositioned(
                top: position ? 60 : 100,
                duration: const Duration(milliseconds: 400),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    height: size.height,
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          name,
                          20,
                          const Color.fromRGBO(45, 3, 59, 1),
                          FontWeight.bold,
                          letterSpace: 0,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextWidget(
                          "Harga Telah Disesuaikan\nDengan Customisasi Anda",
                          15,
                          Colors.black.withOpacity(.6),
                          FontWeight.bold,
                          letterSpace: 0,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const SizedBox(
                                height: 50,
                                width: 50,
                                child: Center(
                                  child: Icon(
                                    Icons.attach_money,
                                    color: Colors.green,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      "Harga",
                                      15,
                                      Colors.black.withOpacity(.6),
                                      FontWeight.bold,
                                      letterSpace: 0,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextWidget(
                                      harga,
                                      18,
                                      const Color.fromRGBO(45, 3, 59, 1),
                                      FontWeight.bold,
                                      letterSpace: 0,
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const SizedBox(
                            height: 50,
                            width: 240,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.download,
                                  color: Colors.blue,
                                  size: 30,
                                ),
                                SizedBox(
                                  height: 0,
                                ),
                                TextWidget(
                                  "Unduh File Penilaian",
                                  18,
                                  Color.fromRGBO(45, 3, 59, 1),
                                  FontWeight.bold,
                                  letterSpace: 0,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                )),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              top: position ? 280 : 330,
              left: 20,
              right: 20,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: opacity,
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SizedBox(
                    height: 170,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          const TextWidget(
                            "Alamat Anda",
                            15,
                            Color.fromRGBO(129, 12, 168, 1),
                            FontWeight.normal,
                            letterSpace: 0,
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextWidget(
                            alamat,
                            18,
                            const Color.fromRGBO(45, 3, 59, 1),
                            FontWeight.bold,
                            letterSpace: 0,
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const TextWidget(
                            "Hari Pemesanan",
                            15,
                            Color.fromRGBO(129, 12, 168, 1),
                            FontWeight.normal,
                            letterSpace: 0,
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextWidget(
                            tanggal,
                            18,
                            const Color.fromRGBO(45, 3, 59, 1),
                            FontWeight.bold,
                            letterSpace: 0,
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const TextWidget(
                            "Status",
                            15,
                            Color.fromRGBO(129, 12, 168, 1),
                            FontWeight.normal,
                            letterSpace: 0,
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextWidget(
                            status,
                            18,
                            colors,
                            FontWeight.bold,
                            letterSpace: 0,
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              top: position ? 660 : 330,
              right: 30,
              left: 30,
              duration: const Duration(milliseconds: 400),
              child: AnimatedOpacity(
                opacity: opacity,
                duration: const Duration(milliseconds: 400),
                child: SizedBox(
                  width: size.width,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ButtonPenilaian(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
