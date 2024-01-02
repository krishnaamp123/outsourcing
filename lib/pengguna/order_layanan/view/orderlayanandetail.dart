import 'dart:async';
import 'package:flutter/material.dart';
import 'package:outsourcing/core.dart';

class OrderLayananDetail extends StatefulWidget {
  final Function()? onTap;
  // const OrderLayananDetail({super.key, this.onTap});
  final String alamat;
  final String hari;
  final List<String> selectedItems;
  final List<int> hargaitem;
  final int jumlahCleaner;
  final String image;
  final String name;
  final String baseprice;
  // final int? jumlahCleaner;
  const OrderLayananDetail(
      {Key? key,
      required this.alamat,
      required this.hari,
      required this.selectedItems,
      required this.hargaitem,
      required this.jumlahCleaner,
      required this.image,
      required this.name,
      required this.baseprice,
      // required this.jumlahCleaner,
      this.onTap})
      : super(key: key);

  @override
  State<OrderLayananDetail> createState() => _OrderLayananDetailState();
}

class _OrderLayananDetailState extends State<OrderLayananDetail> {
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
    String alamat = widget.alamat;
    String hari = widget.hari;
    String name = widget.name;
    String image = widget.image;
    String baseprice = widget.baseprice;
    List<String> selectedItems = widget.selectedItems;
    List<int> hargaitem = widget.hargaitem;
    int jumlahCleaner = widget.jumlahCleaner;
    // int? jumlahCleaner = widget.jumlahCleaner;
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
                  labelText: 'Pesan $name',
                ),
              ),
            ),
            AnimatedPositioned(
                top: 60,
                right: animate ? -120 : -220,
                duration: const Duration(milliseconds: 400),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: Container(
                    height: size.height / 4,
                    width: size.width,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('lib/images/icon/ic_user.png'),
                            fit: BoxFit.cover)),
                  ),
                )),
            AnimatedPositioned(
                left: animate ? 60 : 10,
                duration: const Duration(milliseconds: 400),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: Container(
                    padding: const EdgeInsets.only(top: 60, left: 20),
                    height: size.height,
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          "Custom $name",
                          20,
                          const Color.fromRGBO(45, 3, 59, 1),
                          FontWeight.bold,
                          letterSpace: 0,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextWidget(
                          "Pastikan Kembali Pesanan\nSesuai Customisasi Anda",
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
                                      "Harga Dasar",
                                      15,
                                      Colors.black.withOpacity(.6),
                                      FontWeight.bold,
                                      letterSpace: 0,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextWidget(
                                      "Rp.$baseprice",
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
                            width: 180,
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
                                  "Unduh MOU",
                                  18,
                                  Color.fromRGBO(45, 3, 59, 1),
                                  FontWeight.bold,
                                  letterSpace: 0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
            AnimatedPositioned(
                top: 200,
                right: animate ? 80 : -30,
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
                    height: 120,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const TextWidget(
                                "Lama Kontrak : ",
                                15,
                                Color.fromRGBO(129, 12, 168, 1),
                                FontWeight.normal,
                                letterSpace: 0,
                                textAlign: TextAlign.left,
                              ),
                              TextWidget(
                                '$hari Hari',
                                15,
                                const Color.fromRGBO(45, 3, 59, 1),
                                FontWeight.bold,
                                letterSpace: 0,
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextWidget(
                                "Jumlah $name : ",
                                15,
                                const Color.fromRGBO(129, 12, 168, 1),
                                FontWeight.normal,
                                letterSpace: 0,
                                textAlign: TextAlign.left,
                              ),
                              TextWidget(
                                '$jumlahCleaner Orang',
                                15,
                                const Color.fromRGBO(45, 3, 59, 1),
                                FontWeight.bold,
                                letterSpace: 0,
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              top: position ? 410 : 460,
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
                    height: 140,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextWidget(
                            'Item Tambahan',
                            15,
                            Color.fromRGBO(129, 12, 168, 1),
                            FontWeight.normal,
                            letterSpace: 0,
                            textAlign: TextAlign.left,
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: selectedItems.length,
                              padding: const EdgeInsets.only(bottom: 10),
                              itemExtent: 50,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(selectedItems[index]),
                                  subtitle: Text('Rp. ${hargaitem[index]}'),
                                  titleTextStyle: const TextStyle(
                                      color: Color.fromRGBO(45, 3, 59, 1),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  subtitleTextStyle: const TextStyle(
                                      color: Color.fromRGBO(45, 3, 59, 1),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              top: position ? 570 : 620,
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
                      TextWidget(
                        "Tanggal Pemesanan",
                        18,
                        Color.fromRGBO(45, 3, 59, 1),
                        FontWeight.bold,
                        letterSpace: 0,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ButtonTanggal(),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              top: position ? 660 : 710,
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
                      ButtonPesanan(),
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