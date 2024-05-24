import 'dart:async';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:outsourcing/z_autentikasi/view/login_page.dart';
import 'package:outsourcing/components/text_widget.dart';
import 'package:outsourcing/z_pengguna/dashboard/widget/categorylist_widget.dart';
import 'package:outsourcing/z_pengguna/dashboard/widget/paketlist_widget.dart';
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
                  child: const PaketListWidget(),
                ),
              ),
            ],
          ),
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
