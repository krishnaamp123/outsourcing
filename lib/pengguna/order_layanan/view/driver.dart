// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:outsourcing/components/text_widget.dart';
import 'package:outsourcing/pengguna/order_layanan/view/driverdetail.dart';
import 'package:outsourcing/pengguna/order_layanan/widget/backbutton_widget.dart';
import 'package:outsourcing/pengguna/order_layanan/widget/buttonlanjut.dart';
import 'package:outsourcing/pengguna/order_layanan/widget/dropdown_widget.dart';
import 'package:outsourcing/pengguna/order_layanan/widget/textfieldlayanan_widget.dart';

class DriverPage extends StatefulWidget {
  const DriverPage({Key? key}) : super(key: key);

  @override
  State<DriverPage> createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {
  final _formKey = GlobalKey<FormState>();
  //text editing controllers
  final alamatController = TextEditingController();
  String? _alamatError;
  final hariController = TextEditingController();
  String? _hariError;
  // int? jumlahCleaner = 1;
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
      body: Form(
        key: _formKey,
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 60),
          height: size.height,
          width: size.width,
          child: Stack(children: [
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
                  labelText: 'Pesan Driver',
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              top: position ? 50 : 100,
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
                    height: 550,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextFieldLayanan(
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
                            TextFieldLayanan(
                              controller: hariController,
                              upText: 'Lama Kontrak',
                              hintText: 'ex: 9 Hari',
                              obscureText: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Masukkan jumlah hari';
                                }
                                return null;
                              },
                              onChanged: (_) {
                                setState(() {
                                  _hariError = null;
                                });
                              },
                            ),
                            _hariError != null
                                ? Container(
                                    alignment: Alignment.bottomLeft,
                                    padding: const EdgeInsets.only(left: 30.0),
                                    child: Text(
                                      _hariError!,
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
                            const CustomDropdown(
                              items: [
                                'Item 1',
                                'Item 2',
                                'Item 3'
                              ], // Sesuaikan dengan list item yang sesuai di sini
                            ),
                            const SizedBox(height: 10),
                            const CustomDropdown(
                              items: [
                                'Item 1',
                                'Item 2',
                                'Item 3'
                              ], // Sesuaikan dengan list item yang sesuai di sini
                            ),
                            const SizedBox(height: 10),
                            const CustomDropdown(
                              items: [
                                'Item 1',
                                'Item 2',
                                'Item 3'
                              ], // Sesuaikan dengan list item yang sesuai di sini
                            ),
                            const SizedBox(height: 10),
                            const CustomDropdown(
                              items: [
                                'Item 1',
                                'Item 2',
                                'Item 3'
                              ], // Sesuaikan dengan list item yang sesuai di sini
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              top: position ? 630 : 450,
              left: 20,
              right: 20,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: opacity,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.symmetric(horizontal: 25),
                          child: const TextWidget(
                            "Jumlah Driver",
                            15,
                            Color.fromRGBO(129, 12, 168, 1),
                            FontWeight.normal,
                            letterSpace: 0,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const SizedBox(height: 5),
                        InputQty.int(
                          initVal: 1,
                          minVal: 1,
                          maxVal: 50,
                          steps: 1,
                          messageBuilder: (minVal, maxVal, value) {
                            if (value == null || value == 0) {
                              return const Text(
                                "Required field",
                                style: TextStyle(color: Colors.red),
                                textAlign: TextAlign.center,
                              );
                            } else if (value > 20) {
                              return const Text(
                                "Reach limit",
                                style: TextStyle(color: Colors.red),
                                textAlign: TextAlign.center,
                              );
                            } else {
                              // setState(() {
                              //   jumlahCleaner = value as int?;
                              // });
                              return Text("Jumlah : $value",
                                  textAlign: TextAlign.center);
                            }
                          },
                        ),
                      ]),
                      ButtonLanjut(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            String alamat = alamatController.text;
                            String hari = hariController.text;
                            if (alamat.isEmpty) {
                              setState(() {
                                _alamatError = 'Masukkan alamat';
                                _hariError = null;
                              });
                            } else if (hari.isEmpty) {
                              setState(() {
                                _hariError = 'Masukkan jumlah hari';
                                _alamatError = null;
                              });
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DriverDetail(
                                    alamat: alamat,
                                    hari: hari,
                                    // jumlahCleaner: jumlahCleaner,
                                  ),
                                ),
                              );
                            }
                          } else {
                            setState(() {
                              _alamatError = alamatController.text.isEmpty
                                  ? 'Masukkan alamat'
                                  : null;
                              _hariError = hariController.text.isEmpty
                                  ? 'Masukkan jumlah hari'
                                  : null;
                            });
                          }
                        },
                      )
                    ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
