import 'dart:async';
import 'package:flutter/material.dart';
import 'package:outsourcing/components/text_widget.dart';
import 'package:outsourcing/view/order_paketlayanan/widget/backbutton_widget.dart';
import 'package:outsourcing/core.dart';
import 'package:outsourcing/view/oppoinment.dart';

class PaketLayanan extends StatefulWidget {
  final AssetImage image;
  final String name;
  final String desc;
  const PaketLayanan(
      {super.key, required this.image, required this.name, required this.desc});

  @override
  State<PaketLayanan> createState() => _PaketLayananState();
}

class _PaketLayananState extends State<PaketLayanan> {
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
                ),
              ),
            ),
            AnimatedPositioned(
                top: 1,
                right: animate ? 10 : -200,
                duration: const Duration(milliseconds: 400),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: Container(
                    height: size.height / 2,
                    width: size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: widget.image, fit: BoxFit.cover)),
                  ),
                )),
            AnimatedPositioned(
                left: animate ? 1 : -100,
                duration: const Duration(milliseconds: 400),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: Container(
                    padding: const EdgeInsets.only(top: 80, left: 20),
                    height: size.height / 2,
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          widget.name,
                          25,
                          Colors.black,
                          FontWeight.bold,
                          letterSpace: 0,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextWidget(
                          widget.desc,
                          15,
                          Colors.black.withOpacity(.6),
                          FontWeight.bold,
                          letterSpace: 0,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const SizedBox(
                                height: 60,
                                width: 60,
                                child: Center(
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.orange,
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
                                      "Rating",
                                      17,
                                      Colors.black.withOpacity(.5),
                                      FontWeight.bold,
                                      letterSpace: 0,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const TextWidget(
                                      "4,5 from 5",
                                      23,
                                      Colors.black,
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
                          height: 20,
                        ),
                        Row(
                          children: [
                            Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const SizedBox(
                                height: 60,
                                width: 60,
                                child: Center(
                                  child: Icon(
                                    Icons.people_rounded,
                                    color: Colors.blue,
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
                                      "Patient",
                                      17,
                                      Colors.black.withOpacity(.5),
                                      FontWeight.bold,
                                      letterSpace: 0,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const TextWidget(
                                      "130 +",
                                      23,
                                      Colors.black,
                                      FontWeight.bold,
                                      letterSpace: 0,
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )),
            AnimatedPositioned(
                top: 300,
                right: animate ? 1 : -50,
                duration: const Duration(milliseconds: 400),
                child: Container(
                  height: 150,
                  width: size.width / 2,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        Colors.white.withOpacity(.1),
                        Colors.white,
                        Colors.white
                      ])),
                )),
            AnimatedPositioned(
                top: animate ? 380 : 480,
                left: 1,
                right: 1,
                duration: const Duration(milliseconds: 400),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: Container(
                    padding: const EdgeInsets.only(left: 20, right: 40),
                    height: size.height / 5,
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TextWidget(
                            "Biography", 25, Colors.black, FontWeight.bold),
                        const SizedBox(
                          height: 20,
                        ),
                        TextWidget(
                          "Famous doctor, hygienist, folklore researcher and sanitary mentor, Charles Laugier, whose contribution to the development",
                          15,
                          Colors.black.withOpacity(.5),
                          FontWeight.normal,
                          letterSpace: 0,
                        ),
                      ],
                    ),
                  ),
                )),
            AnimatedPositioned(
                top: animate ? 465 : 560,
                right: 80,
                duration: const Duration(milliseconds: 400),
                child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: const TextWidget(
                      " Read more",
                      15,
                      Colors.blue,
                      FontWeight.bold,
                      letterSpace: 0,
                    ))),
            AnimatedPositioned(
                left: 20,
                right: 20,
                bottom: animate ? 80 : -20,
                duration: const Duration(milliseconds: 400),
                child: AnimatedOpacity(
                  opacity: opacity,
                  duration: const Duration(milliseconds: 400),
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 20),
                    height: 130,
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextWidget(
                            "Shedule", 25, Colors.black, FontWeight.bold),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextWidget(
                                      "19",
                                      15,
                                      Colors.black,
                                      FontWeight.bold,
                                      letterSpace: 0,
                                    ),
                                    TextWidget(
                                      "Thu",
                                      15,
                                      Colors.black,
                                      FontWeight.bold,
                                      letterSpace: 0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextWidget(
                                      "20",
                                      15,
                                      Colors.black,
                                      FontWeight.bold,
                                      letterSpace: 0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextWidget(
                                      "21",
                                      15,
                                      Colors.black,
                                      FontWeight.bold,
                                      letterSpace: 0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextWidget(
                                      "22",
                                      15,
                                      Colors.black,
                                      FontWeight.bold,
                                      letterSpace: 0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )),
            AnimatedPositioned(
                bottom: animate ? 15 : -80,
                left: 30,
                right: 30,
                duration: const Duration(milliseconds: 400),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: InkWell(
                    onTap: () async {
                      animator();
                      await Future.delayed(const Duration(milliseconds: 400));
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Oppointment(0)));
                      animator();
                    },
                    child: Container(
                      height: 65,
                      width: size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue.shade900,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const TextWidget(
                            "Make an appointment",
                            18,
                            Colors.white,
                            FontWeight.w500,
                            letterSpace: 1,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.white,
                            size: 18,
                          ),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.white.withOpacity(.5),
                            size: 18,
                          ),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.white.withOpacity(.2),
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
            AnimatedPositioned(
                top: animate ? 20 : 100,
                left: 20,
                duration: const Duration(milliseconds: 400),
                child: AnimatedOpacity(
                    opacity: opacity,
                    duration: const Duration(milliseconds: 400),
                    child: InkWell(
                      onTap: () {
                        animator();
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new_sharp,
                        color: Colors.black,
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}