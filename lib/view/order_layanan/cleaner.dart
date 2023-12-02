// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:outsourcing/components/text_widget.dart';
import 'package:outsourcing/view/order_layanan/widget/backbutton_widget.dart';
import 'package:outsourcing/view/order_layanan/widget/textfieldalamat_widget.dart';

class CleanerPage extends StatefulWidget {
  const CleanerPage({Key? key}) : super(key: key);

  @override
  State<CleanerPage> createState() => _CleanerPageState();
}

class _CleanerPageState extends State<CleanerPage> {
  final _formKey = GlobalKey<FormState>();
  //text editing controllers
  final alamatController = TextEditingController();
  String? _alamatError;
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
                labelText: 'Pesan Cleaner',
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
                    child: Column(children: [
                      TextFieldAlamat(
                        controller: alamatController,
                        hinttext: 'Alamat',
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
                              alignment: Alignment.centerLeft,
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
                          : SizedBox(),
                      const SizedBox(height: 10),
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
                        child: const TextWidget(
                          "Jumlah Cleaner",
                          15,
                          Color.fromRGBO(129, 12, 168, 1),
                          FontWeight.normal,
                          letterSpace: 0,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const SizedBox(height: 5),
                      InputQty.int(
                        initVal: 0,
                        minVal: 0,
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
                              "Reach my limit",
                              style: TextStyle(color: Colors.red),
                              textAlign: TextAlign.center,
                            );
                          } else {
                            return Text("Jumlah : $value",
                                textAlign: TextAlign.center);
                          }
                        },
                      ),
                    ]),
                  ]),
            ),
          ),
        ]),
      ),
    );
  }
}
