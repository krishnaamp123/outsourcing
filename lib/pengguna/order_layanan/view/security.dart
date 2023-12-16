import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:outsourcing/pengguna/order_layanan/controller/security_controller.dart';
import 'package:outsourcing/core.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({Key? key}) : super(key: key);

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  final _formKey = GlobalKey<FormState>();
  //text editing controllers
  final SecurityController securityController = SecurityController();
  // int? jumlahCleaner = 1;
  var animate = false;
  var opacity = 0.0;
  bool position = false;
  late Size size;

  @override
  void initState() {
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
                  labelText: 'Pesan Security',
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
                              controller: securityController.alamatController,
                              upText: 'Alamat',
                              hintText: 'ex: Jl Udayana...',
                              obscureText: false,
                              validator: securityController.validateAlamat,
                              onChanged: (_) {
                                setState(() {
                                  securityController.alamatError = null;
                                });
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFieldLayanan(
                              controller: securityController.hariController,
                              upText: 'Lama Kontrak',
                              hintText: 'ex: 9 Hari',
                              obscureText: false,
                              validator: securityController.validateHari,
                              onChanged: (_) {
                                setState(() {
                                  securityController.hariError = null;
                                });
                              },
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
                            "Jumlah Security",
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
                            securityController.handleSecurity(context);
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
