import 'dart:async';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:outsourcing/z_autentikasi/view/login_page.dart';
import 'package:outsourcing/components/text_widget.dart';
import 'package:outsourcing/file/list.dart';
import 'package:outsourcing/z_pengguna/dashboard/widget/categorylist_widget.dart';
import 'package:outsourcing/z_pengguna/order_paketlayanan/view/see_all.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  // final String username;
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String name = '';
  var opacity = 0.0;
  bool position = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      animator();
    });
    _loadUserData();
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

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userData = localStorage.getString('user');
    if (userData != null) {
      var user = jsonDecode(userData);
      if (user != null && user['fullname'] != null) {
        String fullName = user['fullname'];
        List<String> nameParts =
            fullName.split(' '); // Memisahkan berdasarkan spasi
        String firstName = '';

        if (nameParts.length >= 2) {
          // Pastikan ada minimal 2 kata dalam nama
          firstName =
              '${nameParts[0]} ${nameParts[1]}'; // Mengambil dua kata pertama
        } else {
          firstName =
              fullName; // Jika hanya ada satu kata, gunakan seluruh nama
        }

        setState(() {
          name = firstName;
        });
      }
    }
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
                top: position ? 1 : 1,
                right: 20,
                left: 20,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
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
                              TextWidget(
                                  "Halo",
                                  15,
                                  Colors.black.withOpacity(.7),
                                  FontWeight.bold),
                              TextWidget(
                                  '${name}', 20, Colors.black, FontWeight.bold),
                            ],
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          _showLogoutConfirmationDialog(context);
                        },
                        child: const Icon(
                          Icons.logout_outlined,
                          color: Color.fromRGBO(45, 3, 59, 1),
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
//Slider
              AnimatedPositioned(
                top: position ? 60 : 60,
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
              AnimatedPositioned(
                top: position ? 250 : 250,
                left: 20,
                right: 20,
                duration: const Duration(milliseconds: 500),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: opacity,
                  child: const CategoryList(),
                ),
              ),
              // categoryRow(context),
              AnimatedPositioned(
                  top: position ? 350 : 350,
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
      top: position ? 380 : 480,
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
                paketLayanan(names[0], desc[0], images[0], item[0], jumlah[0],
                    hari[0], harga[0]),
                paketLayanan(names[1], desc[1], images[1], item[1], jumlah[1],
                    hari[1], harga[1]),
                paketLayanan(names[2], desc[2], images[2], item[2], jumlah[2],
                    hari[2], harga[2]),
                paketLayanan(names[3], desc[3], images[3], item[3], jumlah[3],
                    hari[3], harga[3]),
                paketLayanan(names[4], desc[4], images[4], item[4], jumlah[4],
                    hari[4], harga[4]),
                paketLayanan(names[5], desc[5], images[5], item[5], jumlah[5],
                    hari[5], harga[5]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget paketLayanan(String name, String desc, AssetImage image, String item,
      String jumlah, String hari, String harga) {
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
                  harga,
                  0,
                  const Color.fromRGBO(45, 3, 59, 1),
                  FontWeight.bold,
                  letterSpace: 0,
                  textAlign: TextAlign.left,
                ),
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
                  Colors.black.withOpacity(.6),
                  FontWeight.bold,
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
}

Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Konfirmasi'),
        content: const Text('Anda yakin ingin logout?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pop(); // Tutup dialog tanpa melakukan logout
            },
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pop(); // Tutup dialog sebelum melakukan logout
              logout(context); // Panggil fungsi logout setelah menutup dialog
            },
            child: const Text('Logout'),
          ),
        ],
      );
    },
  );
}

Future<void> logout(BuildContext context) async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  localStorage.remove('token');
  localStorage.remove('user');
  print('Token setelah logout: ${localStorage.getString('token')}');
  print('User setelah logout: ${localStorage.getString('user')}');

  // Navigasi ke halaman login atau halaman awal aplikasi setelah logout
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => LoginPage(),
    ),
  );
}
