import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:outsourcing/components/text_widget.dart';
import 'package:outsourcing/list.dart';
import 'package:outsourcing/pages/see_all.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var opacity = 0.0;
  bool position = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      animator();

      setState(() {});
    });
  }

  animator() {
    if (opacity == 1) {
      opacity = 0;
      position = false;
    } else {
      opacity = 1;
      position = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 30, left: 0, right: 0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
//Top Bar
              AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                top: position ? 1 : 100,
                right: 20,
                left: 20,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'lib/images/logotok.png',
                        height: 40,
                        width: 40,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget("Halo", 15, Colors.black.withOpacity(.7),
                              FontWeight.bold),
                          const TextWidget(
                              "Krishna", 20, Colors.black, FontWeight.bold),
                        ],
                      ),
                      const Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.notifications,
                              size: 35, // Ukuran ikon
                              color: Color.fromRGBO(45, 3, 59, 1), // Warna ikon
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
//Slider
              AnimatedPositioned(
                top: position ? 60 : 120,
                right: 20,
                left: 20,
                duration: const Duration(milliseconds: 400),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      height: 180,
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
                      child: CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 2.0,
                          viewportFraction: 0.8,
                          enlargeCenterPage: true,
                        ),
                        items: [
                          'lib/images/cleaningservice.jpg',
                          'lib/images/housekeeping.jpg',
                          'lib/images/satpam.jpeg',
                        ].map((item) {
                          return Container(
                            margin: const EdgeInsets.all(2.0),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                              child: Image.asset(
                                item,
                                fit: BoxFit.cover,
                                width: 1000.0,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
              categoryRow(),
              AnimatedPositioned(
                  top: position ? 350 : 430,
                  left: 20,
                  right: 20,
                  duration: const Duration(milliseconds: 400),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: opacity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextWidget(
                          "Paket Layanan",
                          20,
                          Color.fromRGBO(45, 3, 59, 1),
                          FontWeight.bold,
                          letterSpace: 0,
                        ),
                        InkWell(
                            onTap: () async {
                              animator();
                              setState(() {});
                              // Timer(Duration(seconds: 1),() {
                              //   Navigator.push(context, MaterialPageRoute(builder: (context) => SeeAll(),));
                              //   animator();
                              // },);
                              await Future.delayed(
                                  const Duration(milliseconds: 500));
                              // ignore: use_build_context_synchronously
                              await Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return const SeeAll();
                                },
                              ));

                              setState(() {
                                animator();
                              });
                            },
                            child: const TextWidget(
                              "Lihat Semua",
                              15,
                              Color.fromRGBO(193, 71, 233, 1),
                              FontWeight.bold,
                              letterSpace: 0,
                            )),
                      ],
                    ),
                  )),
              serviceList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget serviceList() {
    return AnimatedPositioned(
      top: position ? 380 : 470,
      left: 20,
      right: 20,
      duration: const Duration(milliseconds: 400),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 400),
        opacity: opacity,
        child: SizedBox(
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                paketLayanan(names[0], desc[0], images[0]),
                paketLayanan(names[1], desc[1], images[1]),
                paketLayanan(names[2], desc[2], images[2]),
                paketLayanan(names[2], desc[2], images[2]),
                paketLayanan(names[2], desc[2], images[2]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget paketLayanan(String name, String desc, AssetImage image) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        height: 100,
        width: double.infinity,
        child: Row(
          children: [
            const SizedBox(
              width: 15,
            ),
            CircleAvatar(
              radius: 30,
              backgroundImage: image,
              backgroundColor: const Color.fromRGBO(193, 71, 233, 1),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  name,
                  18,
                  const Color.fromRGBO(45, 3, 59, 1),
                  FontWeight.bold,
                  letterSpace: 0,
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextWidget(
                  desc,
                  15,
                  const Color.fromRGBO(193, 71, 233, 1),
                  FontWeight.normal,
                  letterSpace: 0,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryRow() {
    return AnimatedPositioned(
        top: position ? 250 : 420,
        left: 25,
        right: 25,
        duration: const Duration(milliseconds: 400),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 400),
          opacity: opacity,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                category("lib/images/icon/ic_cleaner.png", "Cleaner", 5),
                category("lib/images/icon/ic_driver.png", "Driver", 5),
                category(
                    "lib/images/icon/ic_housekeeper.png", "Housekeeper", 5),
                category("lib/images/icon/ic_policeman.png", "Security", 5),
              ],
            ),
          ),
        ));
  }

  Widget category(String asset, String txt, double padding) {
    return Column(
      children: [
        InkWell(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              padding: EdgeInsets.all(padding),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Image(
                  image: AssetImage(asset),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextWidget(
          txt,
          12,
          Colors.black,
          FontWeight.bold,
          letterSpace: 1,
        ),
      ],
    );
  }
}
