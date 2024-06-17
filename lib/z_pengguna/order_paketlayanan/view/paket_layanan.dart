import 'dart:async';
import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:outsourcing/core.dart';
import 'package:outsourcing/global.dart';
import 'package:outsourcing/z_autentikasi/view/start.dart';
import 'package:outsourcing/z_pengguna/order/widget/downloadpdf_widget.dart';
import 'package:outsourcing/z_pengguna/order_paketlayanan/controller/paketlayanan_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaketLayanan extends StatefulWidget {
  final String idpaket;
  final String alamat;
  final String namapesanan;
  final String image;
  final String name;
  final String description;
  final String includes;
  final String totalprice;
  final String mincontract;
  final String totalemployee;
  final Function()? onTap;
  const PaketLayanan(
      {super.key,
      required this.idpaket,
      required this.alamat,
      required this.namapesanan,
      required this.image,
      required this.name,
      required this.description,
      required this.includes,
      required this.totalprice,
      required this.mincontract,
      required this.totalemployee,
      this.onTap});

  @override
  State<PaketLayanan> createState() => _PaketLayananState();
}

class _PaketLayananState extends State<PaketLayanan> {
  var animate = false;
  var opacity = 0.0;
  bool position = false;
  late Size size;
  late String selectedPayment;
  List<String> paymentOptions = ['full', 'dp', '3_termin'];
  DateTime selectedDate = DateTime.now();
  int? serviceuserid;
  String billingname = '';
  int? idregency;
  String billingaddress = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setPaymentOptions();
    selectedPayment = paymentOptions.first;
    _loadIdData();
    _loadNameData();
    _loadRegencyData();
    _loadFullAddressData();
    Future.delayed(Duration.zero, () {
      animator();
    });
  }

  void setPaymentOptions() {
    int days = int.parse(widget.mincontract);
    if (days < 30) {
      paymentOptions = ['full'];
    } else {
      paymentOptions = ['full', 'dp', '3_termin'];
    }
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

  _loadIdData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var idData = localStorage.getString('user');
    if (idData != null) {
      var id = jsonDecode(idData);
      if (id != null && id['id'] is int) {
        setState(() {
          serviceuserid = id['id'];
        });
      } else {
        print("id is not an integer");
      }
    }
  }

  _loadNameData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var nameData = localStorage.getString('user');
    if (nameData != null) {
      var name = jsonDecode(nameData);
      if (name != null && name['fullname'] != null) {
        String fullName = name['fullname'];
        setState(() {
          billingname = fullName;
        });
      }
    }
  }

  _loadRegencyData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var regencyData = localStorage.getString('user');
    if (regencyData != null) {
      var regency = jsonDecode(regencyData);
      if (regency != null && regency['regency_id'] is int) {
        setState(() {
          idregency = regency['regency_id'];
        });
      } else {
        print("regency_id is not an integer");
      }
    }
  }

  _loadFullAddressData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var fulladdressData = localStorage.getString('user');
    if (fulladdressData != null) {
      var fulladdress = jsonDecode(fulladdressData);
      if (fulladdress != null && fulladdress['full_address'] != null) {
        String addressfull = fulladdress['full_address'];
        setState(() {
          billingaddress = addressfull;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final OrderPaketController orderpaketController = OrderPaketController();
    size = MediaQuery.of(context).size;
    String idpaket = widget.idpaket;
    String namapesanan = widget.namapesanan;
    String alamat = widget.alamat;
    String hari = widget.mincontract;
    String jumlah = widget.totalemployee;
    String totalprice = widget.totalprice;
    int hargaInt = int.parse(totalprice);
    String formattedTotalPrice =
        NumberFormat.currency(locale: 'id', symbol: 'Rp.', decimalDigits: 0)
            .format(hargaInt);
    final imageURL = '$baseURL/resource/packages/$idpaket/main_image/';
    print('Image URL: $imageURL');
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
                child: BackButtonWidget2(
                  animator: animator,
                  context: context,
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
                child: Stack(
                  children: [
                    Container(
                      height: size.height / 4,
                      width: size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(imageURL),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Image.network(
                        imageURL,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          print('Error loading image: $error');
                          return Image.asset(
                            'lib/images/icon/ic_user.png',
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
                          widget.name,
                          20,
                          const Color.fromRGBO(45, 3, 59, 1),
                          FontWeight.bold,
                          letterSpace: 0,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextWidget(
                          "Pastikan Lagi Pesanan\nSesuai Keinginan Anda",
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
                                      formattedTotalPrice,
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
                        const DownloadPdfCard(),
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
                    height: 110,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              top: position ? 400 : 450,
              right: 30,
              left: 30,
              duration: const Duration(milliseconds: 400),
              child: AnimatedOpacity(
                opacity: opacity,
                duration: const Duration(milliseconds: 400),
                child: SizedBox(
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const TextWidget(
                            "Tanggal Pemesanan",
                            15,
                            Color.fromRGBO(129, 12, 168, 1),
                            FontWeight.normal,
                            letterSpace: 0,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          GestureDetector(
                            onTap: () async {
                              final DateTime? dateTime = await showDatePicker(
                                context: context,
                                initialDate: selectedDate,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2025),
                              );
                              if (dateTime != null) {
                                setState(() {
                                  selectedDate = dateTime;
                                });
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 32, right: 32, top: 12, bottom: 12),
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(45, 3, 59, 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "${selectedDate.year} - ${selectedDate.month} - ${selectedDate.day}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const TextWidget(
                              "Tipe Pembayaran",
                              15,
                              Color.fromRGBO(129, 12, 168, 1),
                              FontWeight.normal,
                              letterSpace: 0,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Card(
                              elevation: 5, // Atur elevation di sini
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  value: selectedPayment,
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedPayment = newValue!;
                                    });
                                  },
                                  items: paymentOptions.map((String option) {
                                    return DropdownMenuItem<String>(
                                      value: option,
                                      child: Text(
                                        option,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Color.fromRGBO(45, 3, 59, 1),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    );
                                  }).toList(),
                                  buttonStyleData: const ButtonStyleData(
                                    // padding: EdgeInsets.symmetric(horizontal: 5),
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    height: 40,
                                    width: 150,
                                  ),
                                  iconStyleData: const IconStyleData(
                                    icon: Icon(
                                      Icons.arrow_drop_down_outlined,
                                    ),
                                    iconSize: 25,
                                    iconEnabledColor: Colors.grey,
                                  ),
                                  dropdownStyleData: const DropdownStyleData(
                                    maxHeight: 200,
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 50,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              top: position ? 480 : 530,
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
                    height: 160,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
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
                                const TextWidget(
                                  "Jumlah Karyawan : ",
                                  15,
                                  Color.fromRGBO(129, 12, 168, 1),
                                  FontWeight.normal,
                                  letterSpace: 0,
                                  textAlign: TextAlign.left,
                                ),
                                TextWidget(
                                  '$jumlah Orang',
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
                            const TextWidget(
                              "Termasuk Paket Layanan : ",
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
                              widget.includes,
                              15,
                              Colors.black.withOpacity(.6),
                              FontWeight.bold,
                              letterSpace: 0,
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const TextWidget(
                              "Deskripsi Paket Layanan : ",
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
                              widget.description,
                              15,
                              Colors.black.withOpacity(.6),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                padding:
                                    const EdgeInsets.fromLTRB(80, 16, 80, 16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const TextWidget(
                                      "Konfirmasi Pesanan",
                                      20,
                                      Color.fromRGBO(45, 3, 59, 1),
                                      FontWeight.bold,
                                      letterSpace: 0,
                                      textAlign: TextAlign.left,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextWidget(
                                      "Cek kembali data pesanan anda\nPastikan sudah mengunduh MOU",
                                      15,
                                      Colors.black.withOpacity(0.6),
                                      FontWeight.bold,
                                      letterSpace: 0,
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        final snackBar = SnackBar(
                                          elevation: 0,
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor: Colors.transparent,
                                          content: AwesomeSnackbarContent(
                                            title: 'Info',
                                            message:
                                                'Terimakasih telah membuat pesanan, harap mengumpulkan berkas yang diperlukan',
                                            contentType: ContentType.success,
                                          ),
                                        );

                                        ScaffoldMessenger.of(context)
                                          ..hideCurrentSnackBar()
                                          ..showSnackBar(snackBar);

                                        Navigator.pop(context);

                                        orderpaketController.PostOrderPaket(
                                          serviceuserid: serviceuserid,
                                          billingname: billingname,
                                          idregency: idregency,
                                          billingaddress: billingaddress,
                                          namapesanan: widget.namapesanan,
                                          alamat: widget.alamat,
                                          hari: widget.mincontract,
                                          selectedDate: selectedDate,
                                          selectedPayment: selectedPayment,
                                          idpaket: widget.idpaket,
                                        );

                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const Start(),
                                          ),
                                        );
                                      },
                                      label: const Text('Buat Pesanan',
                                          style: TextStyle(
                                            color:
                                                Color.fromRGBO(193, 71, 233, 1),
                                          )),
                                      icon: const Icon(
                                        Icons.upload_file,
                                        color: Color.fromRGBO(193, 71, 233, 1),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shadowColor:
                                            Colors.purple, // Warna teks
                                        minimumSize: const Size(240, 40),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(240, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor:
                              const Color.fromRGBO(193, 71, 233, 1),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(horizontal: 70),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: TextWidget(
                              "Buat Pesanan",
                              16,
                              Colors.white,
                              FontWeight.bold,
                              letterSpace: 0,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
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
