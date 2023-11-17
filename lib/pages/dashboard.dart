import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
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
                          TextWidget(
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
                top: position ? 60 : 220,
                right: 20,
                left: 20,
                duration: const Duration(milliseconds: 400),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: Card(
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
                  top: position ? 420 : 500,
                  left: 20,
                  right: 20,
                  duration: const Duration(milliseconds: 400),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: opacity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          "Our Doctors",
                          25,
                          Colors.black.withOpacity(.8),
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
                                  return SeeAll();
                                },
                              ));

                              setState(() {
                                animator();
                              });
                            },
                            child: TextWidget(
                              "See all",
                              15,
                              Colors.blue.shade600.withOpacity(.8),
                              FontWeight.bold,
                              letterSpace: 0,
                            )),
                      ],
                    ),
                  )),
              doctorList(),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: CurvedNavigationBar(
                        backgroundColor: Colors.white,
                        items: const [
                          Icon(
                            Icons.home_filled,
                            color: Color.fromRGBO(129, 12, 168, 1),
                            size: 30,
                          ),
                          Icon(
                            Icons.calendar_month_rounded,
                            color: Color.fromRGBO(45, 3, 59, 1),
                            size: 30,
                          ),
                          Icon(
                            Icons.whatshot_outlined,
                            color: Color.fromRGBO(45, 3, 59, 1),
                            size: 30,
                          ),
                          Icon(
                            Icons.account_circle_outlined,
                            color: Color.fromRGBO(45, 3, 59, 1),
                            size: 30,
                          ),
                        ]),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget doctorList() {
    return AnimatedPositioned(
        top: position ? 460 : 550,
        left: 20,
        right: 20,
        duration: const Duration(milliseconds: 400),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 400),
          opacity: opacity,
          child: AnimatedOpacity(
            opacity: opacity,
            duration: const Duration(milliseconds: 300),
            child: SizedBox(
              height: 270,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    doctorCard(names[0], spacilality[0], images[0]),
                    doctorCard(names[1], spacilality[1], images[1]),
                    doctorCard(names[2], spacilality[2], images[2]),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget doctorCard(String name, String specialist, AssetImage image) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        height: 120,
        width: double.infinity,
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            CircleAvatar(
              radius: 30,
              backgroundImage: image,
              backgroundColor: Colors.blue,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                  name,
                  20,
                  Colors.black,
                  FontWeight.bold,
                  letterSpace: 0,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextWidget(
                  specialist,
                  17,
                  Colors.black,
                  FontWeight.bold,
                  letterSpace: 0,
                ),
                const SizedBox(
                  height: 5,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.orangeAccent,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.orangeAccent,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.orangeAccent,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.orangeAccent,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.orangeAccent,
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            const Icon(
              Icons.navigation_sharp,
              color: Colors.blue,
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryRow() {
    return AnimatedPositioned(
        top: position ? 320 : 420,
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
                category("lib/images/capsule.png", "Drug", 5),
                category("lib/images/virus.png", "Virus", 10),
                category("lib/images/heart.png", "Physo", 10),
                category("lib/images/app.png", "Other", 12),
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
          16,
          Colors.black,
          FontWeight.bold,
          letterSpace: 1,
        ),
      ],
    );
  }
}
