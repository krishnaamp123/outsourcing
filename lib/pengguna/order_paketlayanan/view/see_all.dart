import 'dart:async';
import 'package:flutter/material.dart';
import 'package:outsourcing/core.dart';
import 'package:outsourcing/main.dart';

class SeeAll extends StatefulWidget {
  final String username;
  const SeeAll({super.key, required this.username});

  @override
  State<SeeAll> createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> {
  var opacity = 0.0;
  bool position = false;
  final _formKey = GlobalKey<FormState>();
  //text editing controllers
  final alamatController = TextEditingController();
  String? _alamatError;
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
      position = false;
    } else {
      opacity = 1;
      position = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
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
                child: upperRow(),
              ),
              AnimatedPositioned(
                  top: position ? 60 : 120,
                  right: 20,
                  left: 20,
                  duration: const Duration(milliseconds: 300),
                  child: info()),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                top: position ? 180 : 230,
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
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextFieldAlamat(
                              controller: alamatController,
                              upText: 'Alamat',
                              hintText: 'ex: Jl Udayana...',
                              obscureText: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Masukkan alamat';
                                }
                                return null;
                              },
                              onChanged: (_) {
                                setState(() {
                                  _alamatError = null;
                                });
                              },
                            ),
                            _alamatError != null
                                ? Container(
                                    alignment: Alignment.bottomLeft,
                                    padding: const EdgeInsets.only(left: 30.0),
                                    child: Text(
                                      _alamatError!,
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  )
                                : const SizedBox(),
                            const SizedBox(height: 10),
                          ]),
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                  top: position ? 310 : 360,
                  right: 20,
                  left: 20,
                  duration: const Duration(milliseconds: 400),
                  child: AnimatedOpacity(
                    opacity: opacity,
                    duration: const Duration(milliseconds: 400),
                    child: SizedBox(
                      width: size.width,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextWidget(
                            "Semua Paket Layanan",
                            20,
                            Color.fromRGBO(45, 3, 59, 1),
                            FontWeight.bold,
                            letterSpace: 0,
                          ),
                        ],
                      ),
                    ),
                  )),
              AnimatedPositioned(
                  top: position ? 340 : 370,
                  left: 20,
                  right: 20,
                  duration: const Duration(milliseconds: 500),
                  child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: opacity,
                      child: SizedBox(
                        height: 460,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          itemCount: 6,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () async {
                              // animator();
                              if (_formKey.currentState!.validate()) {
                                String alamat = alamatController.text;
                                if (alamat.isEmpty) {
                                  setState(() {
                                    _alamatError = 'Masukkan alamat';
                                  });
                                } else {
                                  await Future.delayed(
                                      const Duration(milliseconds: 400));
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PaketLayanan(
                                        alamat: alamat,
                                        image: images[index],
                                        name: names[index],
                                        desc: desc[index],
                                        harga: harga[index],
                                      ),
                                    ),
                                  );
                                }
                              } else {
                                setState(() {
                                  _alamatError = alamatController.text.isEmpty
                                      ? 'Masukkan alamat'
                                      : null;
                                });
                              }
                            },
                            child: Card(
                              elevation: 5,
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
                                      backgroundImage: images[index],
                                      backgroundColor:
                                          const Color.fromRGBO(193, 71, 233, 1),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                          harga[index],
                                          0,
                                          const Color.fromRGBO(45, 3, 59, 1),
                                          FontWeight.bold,
                                          letterSpace: 0,
                                          textAlign: TextAlign.left,
                                        ),
                                        TextWidget(
                                          names[index],
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
                                          desc[index],
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
                            ),
                          ),
                        ),
                      ))),
            ],
          ),
        ),
      ),
    );
  }

  Widget info() {
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
                    ])),
            child: const Row(
              children: [
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      "OutsourcingApp Info :",
                      18,
                      Colors.white,
                      FontWeight.bold,
                      letterSpace: 0,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextWidget(
                          "Temukan paket layanan yang anda cari disini,\ndapatkan harga lebih murah dengan paket layanan",
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
            )),
      ),
    );
  }

  Widget upperRow() {
    String username = widget.username;
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 400),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              animator();
              Timer(const Duration(milliseconds: 600), () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Start(username: username),
                    ));
              });
            },
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Color.fromRGBO(45, 3, 59, 1),
              size: 30,
            ),
          ),
          const Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                  "Layanan Kami",
                  25,
                  Color.fromRGBO(45, 3, 59, 1),
                  FontWeight.bold,
                  letterSpace: 0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
