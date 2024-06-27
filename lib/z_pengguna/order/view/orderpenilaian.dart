import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outsourcing/core.dart';
import 'package:outsourcing/z_pengguna/order/controller/order_controller.dart';
import 'package:outsourcing/z_pengguna/order/widget/buttonpenilaian_widget.dart';
import 'package:intl/intl.dart';
import 'package:outsourcing/z_pengguna/order/widget/karyawanholder_widget.dart';
import 'package:outsourcing/z_pengguna/order/widget/supervisorholder_widget.dart';

class OrderPenilaian extends StatefulWidget {
  final Function()? onTap;
  final int id;
  final String namapesanan;
  final String tanggal;
  final String tanggalorder;
  final String alamat;
  final String jumlahkaryawan;
  final String lamakontrak;
  final String status;
  final String harga;
  final String hargaterbayar;
  final String metodebayar;
  final String deadlinebayar;

  const OrderPenilaian({
    Key? key,
    required this.id,
    required this.namapesanan,
    required this.tanggal,
    required this.tanggalorder,
    required this.alamat,
    required this.jumlahkaryawan,
    required this.lamakontrak,
    required this.status,
    required this.harga,
    required this.hargaterbayar,
    required this.metodebayar,
    required this.deadlinebayar,
    // required this.colors,
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
  // final PlacementUserController placementuserController =
  //     Get.put(PlacementUserController());
  final OrderControllerApi orderController = Get.put(OrderControllerApi());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      animator();
      // placementuserController.getPlacementUser(widget.id);
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
    int hargaInt = int.parse(harga);
    String formattedHarga =
        NumberFormat.currency(locale: 'id', symbol: 'Rp.', decimalDigits: 0)
            .format(hargaInt);
    String hargaterbayar = widget.hargaterbayar;
    int hargaterbayarInt = int.parse(hargaterbayar);
    String formattedHargaTerbayar =
        NumberFormat.currency(locale: 'id', symbol: 'Rp.', decimalDigits: 0)
            .format(hargaterbayarInt);
    DateTime parsedDate = DateTime.parse(widget.tanggal);
    String formattedDate = DateFormat('dd-MM-yyyy').format(parsedDate);
    DateTime parsedOrderDate = DateTime.parse(widget.tanggalorder);
    String formattedOrderDate =
        DateFormat('dd-MM-yyyy').format(parsedOrderDate);
    DateTime parsedDeadlineDate = DateTime.parse(widget.deadlinebayar);
    String formattedDeadlineDate =
        DateFormat('dd-MM-yyyy').format(parsedDeadlineDate);
    String id = widget.id.toString();
    String alamat = widget.alamat;
    String status = widget.status;
    String namapesanan = widget.namapesanan;
    String jumlahkaryawan = widget.jumlahkaryawan;
    String lamakontrak = widget.lamakontrak;
    String metodebayar = widget.metodebayar;
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
                top: position ? 60 : 110,
                duration: const Duration(milliseconds: 400),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      height: 600,
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              'Order $id',
                              20,
                              const Color.fromRGBO(45, 3, 59, 1),
                              FontWeight.bold,
                              letterSpace: 0,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextWidget(
                                  "Status Pesanan :",
                                  15,
                                  Colors.black.withOpacity(.6),
                                  FontWeight.bold,
                                  letterSpace: 0,
                                ),
                                TextWidget(
                                  status,
                                  18,
                                  Colors.green,
                                  FontWeight.bold,
                                  letterSpace: 0,
                                ),
                              ],
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          formattedHarga,
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
                            Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: SizedBox(
                                height: 230,
                                width: 350,
                                // width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const TextWidget(
                                          'Rincian Pesanan',
                                          20,
                                          Color.fromRGBO(45, 3, 59, 1),
                                          FontWeight.bold,
                                          letterSpace: 0,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const TextWidget(
                                          "Atas Nama :",
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
                                          namapesanan,
                                          15,
                                          const Color.fromRGBO(45, 3, 59, 1),
                                          FontWeight.bold,
                                          letterSpace: 0,
                                          textAlign: TextAlign.left,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const TextWidget(
                                          "Alamat Anda :",
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
                                          15,
                                          const Color.fromRGBO(45, 3, 59, 1),
                                          FontWeight.bold,
                                          letterSpace: 0,
                                          textAlign: TextAlign.left,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                                              '$lamakontrak Hari',
                                              15,
                                              const Color.fromRGBO(
                                                  45, 3, 59, 1),
                                              FontWeight.bold,
                                              letterSpace: 0,
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const TextWidget(
                                              "Jumlah Karyawan : ",
                                              15,
                                              Color.fromRGBO(129, 12, 168, 1),
                                              FontWeight.normal,
                                              letterSpace: 0,
                                              textAlign: TextAlign.left,
                                            ),
                                            TextWidget(
                                              '$jumlahkaryawan Orang',
                                              15,
                                              const Color.fromRGBO(
                                                  45, 3, 59, 1),
                                              FontWeight.bold,
                                              letterSpace: 0,
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const TextWidget(
                                              "Tanggal Pemesanan : ",
                                              15,
                                              Color.fromRGBO(129, 12, 168, 1),
                                              FontWeight.normal,
                                              letterSpace: 0,
                                              textAlign: TextAlign.left,
                                            ),
                                            TextWidget(
                                              formattedDate,
                                              15,
                                              const Color.fromRGBO(
                                                  45, 3, 59, 1),
                                              FontWeight.bold,
                                              letterSpace: 0,
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const TextWidget(
                                              "Tanggal Dipesan : ",
                                              15,
                                              Color.fromRGBO(129, 12, 168, 1),
                                              FontWeight.normal,
                                              letterSpace: 0,
                                              textAlign: TextAlign.left,
                                            ),
                                            TextWidget(
                                              formattedOrderDate,
                                              15,
                                              const Color.fromRGBO(
                                                  45, 3, 59, 1),
                                              FontWeight.bold,
                                              letterSpace: 0,
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const TextWidget(
                                          "Deskripsi Layanan :",
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
                                          "description",
                                          15,
                                          Colors.black.withOpacity(.6),
                                          FontWeight.bold,
                                          letterSpace: 0,
                                          textAlign: TextAlign.left,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: SizedBox(
                                height: 125,
                                width: 350,
                                // width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const TextWidget(
                                          'Pembayaran',
                                          20,
                                          Color.fromRGBO(45, 3, 59, 1),
                                          FontWeight.bold,
                                          letterSpace: 0,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const TextWidget(
                                              "Metode Pembayaran : ",
                                              15,
                                              Color.fromRGBO(129, 12, 168, 1),
                                              FontWeight.normal,
                                              letterSpace: 0,
                                              textAlign: TextAlign.left,
                                            ),
                                            TextWidget(
                                              metodebayar,
                                              15,
                                              const Color.fromRGBO(
                                                  45, 3, 59, 1),
                                              FontWeight.bold,
                                              letterSpace: 0,
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const TextWidget(
                                              "Harga Terbayarkan : ",
                                              15,
                                              Color.fromRGBO(129, 12, 168, 1),
                                              FontWeight.normal,
                                              letterSpace: 0,
                                              textAlign: TextAlign.left,
                                            ),
                                            TextWidget(
                                              formattedHargaTerbayar,
                                              15,
                                              const Color.fromRGBO(
                                                  45, 3, 59, 1),
                                              FontWeight.bold,
                                              letterSpace: 0,
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const TextWidget(
                                              "Deadline Pembayaran : ",
                                              15,
                                              Color.fromRGBO(129, 12, 168, 1),
                                              FontWeight.normal,
                                              letterSpace: 0,
                                              textAlign: TextAlign.left,
                                            ),
                                            TextWidget(
                                              formattedDeadlineDate,
                                              15,
                                              const Color.fromRGBO(
                                                  45, 3, 59, 1),
                                              FontWeight.bold,
                                              letterSpace: 0,
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SupervisorHolderWidget(id: id),
                            KaryawanHolderWidget(id: id),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
            // AnimatedPositioned(
            //   duration: const Duration(milliseconds: 400),
            //   top: position ? 1200 : 330,
            //   left: 20,
            //   right: 20,
            //   child: AnimatedOpacity(
            //     duration: const Duration(milliseconds: 400),
            //     opacity: opacity,
            //     child: Card(
            //       elevation: 2,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(20),
            //       ),
            //       child: SizedBox(
            //         height: 230,
            //         width: MediaQuery.of(context).size.width,
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 25.0),
            //           child: SingleChildScrollView(
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 const SizedBox(
            //                   height: 10,
            //                 ),
            //                 const TextWidget(
            //                   'Rincian Pesanan',
            //                   20,
            //                   Color.fromRGBO(45, 3, 59, 1),
            //                   FontWeight.bold,
            //                   letterSpace: 0,
            //                 ),
            //                 const SizedBox(
            //                   height: 5,
            //                 ),
            //                 const TextWidget(
            //                   "Atas Nama :",
            //                   15,
            //                   Color.fromRGBO(129, 12, 168, 1),
            //                   FontWeight.normal,
            //                   letterSpace: 0,
            //                   textAlign: TextAlign.left,
            //                 ),
            //                 const SizedBox(
            //                   height: 5,
            //                 ),
            //                 TextWidget(
            //                   namapesanan,
            //                   15,
            //                   const Color.fromRGBO(45, 3, 59, 1),
            //                   FontWeight.bold,
            //                   letterSpace: 0,
            //                   textAlign: TextAlign.left,
            //                 ),
            //                 const SizedBox(
            //                   height: 5,
            //                 ),
            //                 const TextWidget(
            //                   "Alamat Anda :",
            //                   15,
            //                   Color.fromRGBO(129, 12, 168, 1),
            //                   FontWeight.normal,
            //                   letterSpace: 0,
            //                   textAlign: TextAlign.left,
            //                 ),
            //                 const SizedBox(
            //                   height: 5,
            //                 ),
            //                 TextWidget(
            //                   alamat,
            //                   15,
            //                   const Color.fromRGBO(45, 3, 59, 1),
            //                   FontWeight.bold,
            //                   letterSpace: 0,
            //                   textAlign: TextAlign.left,
            //                 ),
            //                 const SizedBox(
            //                   height: 5,
            //                 ),
            //                 Row(
            //                   mainAxisAlignment: MainAxisAlignment.start,
            //                   children: [
            //                     const TextWidget(
            //                       "Lama Kontrak : ",
            //                       15,
            //                       Color.fromRGBO(129, 12, 168, 1),
            //                       FontWeight.normal,
            //                       letterSpace: 0,
            //                       textAlign: TextAlign.left,
            //                     ),
            //                     TextWidget(
            //                       '$lamakontrak Hari',
            //                       15,
            //                       const Color.fromRGBO(45, 3, 59, 1),
            //                       FontWeight.bold,
            //                       letterSpace: 0,
            //                       textAlign: TextAlign.left,
            //                     ),
            //                   ],
            //                 ),
            //                 const SizedBox(
            //                   height: 5,
            //                 ),
            //                 Row(
            //                   mainAxisAlignment: MainAxisAlignment.start,
            //                   children: [
            //                     const TextWidget(
            //                       "Jumlah Karyawan : ",
            //                       15,
            //                       Color.fromRGBO(129, 12, 168, 1),
            //                       FontWeight.normal,
            //                       letterSpace: 0,
            //                       textAlign: TextAlign.left,
            //                     ),
            //                     TextWidget(
            //                       '$jumlahkaryawan Orang',
            //                       15,
            //                       const Color.fromRGBO(45, 3, 59, 1),
            //                       FontWeight.bold,
            //                       letterSpace: 0,
            //                       textAlign: TextAlign.left,
            //                     ),
            //                   ],
            //                 ),
            //                 const SizedBox(
            //                   height: 5,
            //                 ),
            //                 Row(
            //                   mainAxisAlignment: MainAxisAlignment.start,
            //                   children: [
            //                     const TextWidget(
            //                       "Tanggal Pemesanan : ",
            //                       15,
            //                       Color.fromRGBO(129, 12, 168, 1),
            //                       FontWeight.normal,
            //                       letterSpace: 0,
            //                       textAlign: TextAlign.left,
            //                     ),
            //                     TextWidget(
            //                       formattedDate,
            //                       15,
            //                       const Color.fromRGBO(45, 3, 59, 1),
            //                       FontWeight.bold,
            //                       letterSpace: 0,
            //                       textAlign: TextAlign.left,
            //                     ),
            //                   ],
            //                 ),
            //                 const SizedBox(
            //                   height: 5,
            //                 ),
            //                 Row(
            //                   mainAxisAlignment: MainAxisAlignment.start,
            //                   children: [
            //                     const TextWidget(
            //                       "Tanggal Dipesan : ",
            //                       15,
            //                       Color.fromRGBO(129, 12, 168, 1),
            //                       FontWeight.normal,
            //                       letterSpace: 0,
            //                       textAlign: TextAlign.left,
            //                     ),
            //                     TextWidget(
            //                       formattedOrderDate,
            //                       15,
            //                       const Color.fromRGBO(45, 3, 59, 1),
            //                       FontWeight.bold,
            //                       letterSpace: 0,
            //                       textAlign: TextAlign.left,
            //                     ),
            //                   ],
            //                 ),
            //                 const SizedBox(
            //                   height: 5,
            //                 ),
            //                 const TextWidget(
            //                   "Deskripsi Layanan :",
            //                   15,
            //                   Color.fromRGBO(129, 12, 168, 1),
            //                   FontWeight.normal,
            //                   letterSpace: 0,
            //                   textAlign: TextAlign.left,
            //                 ),
            //                 const SizedBox(
            //                   height: 5,
            //                 ),
            //                 TextWidget(
            //                   "description",
            //                   15,
            //                   Colors.black.withOpacity(.6),
            //                   FontWeight.bold,
            //                   letterSpace: 0,
            //                   textAlign: TextAlign.left,
            //                 ),
            //                 const SizedBox(
            //                   height: 10,
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // AnimatedPositioned(
            //   duration: const Duration(milliseconds: 400),
            //   top: position ? 1520 : 570,
            //   left: 20,
            //   right: 20,
            //   child: AnimatedOpacity(
            //     duration: const Duration(milliseconds: 400),
            //     opacity: opacity,
            //     child: Card(
            //       elevation: 2,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(20),
            //       ),
            //       child: SizedBox(
            //         height: 125,
            //         width: MediaQuery.of(context).size.width,
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 25.0),
            //           child: SingleChildScrollView(
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 const SizedBox(
            //                   height: 10,
            //                 ),
            //                 const TextWidget(
            //                   'Pembayaran',
            //                   20,
            //                   Color.fromRGBO(45, 3, 59, 1),
            //                   FontWeight.bold,
            //                   letterSpace: 0,
            //                 ),
            //                 const SizedBox(
            //                   height: 5,
            //                 ),
            //                 Row(
            //                   mainAxisAlignment: MainAxisAlignment.start,
            //                   children: [
            //                     const TextWidget(
            //                       "Metode Pembayaran : ",
            //                       15,
            //                       Color.fromRGBO(129, 12, 168, 1),
            //                       FontWeight.normal,
            //                       letterSpace: 0,
            //                       textAlign: TextAlign.left,
            //                     ),
            //                     TextWidget(
            //                       metodebayar,
            //                       15,
            //                       const Color.fromRGBO(45, 3, 59, 1),
            //                       FontWeight.bold,
            //                       letterSpace: 0,
            //                       textAlign: TextAlign.left,
            //                     ),
            //                   ],
            //                 ),
            //                 const SizedBox(
            //                   height: 5,
            //                 ),
            //                 Row(
            //                   mainAxisAlignment: MainAxisAlignment.start,
            //                   children: [
            //                     const TextWidget(
            //                       "Harga Terbayarkan : ",
            //                       15,
            //                       Color.fromRGBO(129, 12, 168, 1),
            //                       FontWeight.normal,
            //                       letterSpace: 0,
            //                       textAlign: TextAlign.left,
            //                     ),
            //                     TextWidget(
            //                       formattedHargaTerbayar,
            //                       15,
            //                       const Color.fromRGBO(45, 3, 59, 1),
            //                       FontWeight.bold,
            //                       letterSpace: 0,
            //                       textAlign: TextAlign.left,
            //                     ),
            //                   ],
            //                 ),
            //                 const SizedBox(
            //                   height: 5,
            //                 ),
            //                 Row(
            //                   mainAxisAlignment: MainAxisAlignment.start,
            //                   children: [
            //                     const TextWidget(
            //                       "Deadline Pembayaran : ",
            //                       15,
            //                       Color.fromRGBO(129, 12, 168, 1),
            //                       FontWeight.normal,
            //                       letterSpace: 0,
            //                       textAlign: TextAlign.left,
            //                     ),
            //                     TextWidget(
            //                       formattedDeadlineDate,
            //                       15,
            //                       const Color.fromRGBO(45, 3, 59, 1),
            //                       FontWeight.bold,
            //                       letterSpace: 0,
            //                       textAlign: TextAlign.left,
            //                     ),
            //                   ],
            //                 ),
            //                 const SizedBox(
            //                   height: 5,
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // AnimatedPositioned(
            //   top: position ? 1300 : 450,
            //   left: 20,
            //   right: 20,
            //   duration: const Duration(milliseconds: 500),
            //   child: AnimatedOpacity(
            //     duration: const Duration(milliseconds: 500),
            //     opacity: opacity,
            //     child: SupervisorHolderWidget(id: id),
            //   ),
            // ),
            // AnimatedPositioned(
            //   top: position ? 1450 : 450,
            //   left: 20,
            //   right: 20,
            //   duration: const Duration(milliseconds: 500),
            //   child: AnimatedOpacity(
            //     duration: const Duration(milliseconds: 500),
            //     opacity: opacity,
            //     child: KaryawanHolderWidget(id: id),
            //   ),
            // ),
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
