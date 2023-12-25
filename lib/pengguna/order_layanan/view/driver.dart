import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:outsourcing/core.dart';
import 'package:outsourcing/pengguna/order_layanan/controller/driver_controller.dart';

class DriverPage extends StatefulWidget {
  const DriverPage({Key? key}) : super(key: key);

  @override
  State<DriverPage> createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {
  final _formKey = GlobalKey<FormState>();
  //text editing controllers
  final DriverController driverController = DriverController();
  // int? jumlahDriver = 1;
  var animate = false;
  var opacity = 0.0;
  bool position = false;
  late Size size;
  int jumlahDriver = 1;
  List<String> items = [
    "Bantal Mobil",
    "Pengharum Mobil",
  ];

  List<bool> checkedItems = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      animator();
      checkedItems = List<bool>.filled(items.length, false);
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
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextFieldLayanan(
                              controller: driverController.alamatController,
                              upText: 'Alamat',
                              hintText: 'ex: Jl Udayana...',
                              obscureText: false,
                              validator: driverController.validateAlamat,
                              onChanged: (_) {
                                setState(() {
                                  driverController.alamatError = null;
                                });
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFieldLayanan(
                              controller: driverController.hariController,
                              upText: 'Lama Kontrak',
                              hintText: 'ex: 9 Hari',
                              obscureText: false,
                              validator: driverController.validateHari,
                              onChanged: (_) {
                                setState(() {
                                  driverController.hariError = null;
                                });
                              },
                            ),
                            const SizedBox(height: 10),
                          ]),
                    ),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              top: position ? 270 : 320,
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
                    height: 330,
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
                              itemCount: items.length,
                              padding: const EdgeInsets.only(bottom: 10),
                              itemExtent: 50,
                              itemBuilder: (context, index) {
                                return CheckboxListTile(
                                  title: Text(
                                    items[index],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16,
                                      color: Color.fromRGBO(45, 3, 59, 1),
                                    ),
                                  ),
                                  value: checkedItems[index],
                                  onChanged: (newValue) {
                                    setState(() {
                                      checkedItems[index] = newValue!;
                                    });
                                  },
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
              duration: const Duration(milliseconds: 400),
              top: position ? 630 : 680,
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
                          initVal: jumlahDriver,
                          minVal: 1,
                          maxVal: 50,
                          steps: 1,
                          onQtyChanged: (value) {
                            setState(() {
                              jumlahDriver = value ?? 1;
                            });
                          },
                          messageBuilder: (minVal, maxVal, value) {
                            if (value == null || value == 0) {
                              return const Text(
                                "Minimal 1",
                                style: TextStyle(color: Colors.red),
                                textAlign: TextAlign.center,
                              );
                            } else if (value > 30) {
                              return const Text(
                                "Maksimal 30",
                                style: TextStyle(color: Colors.red),
                                textAlign: TextAlign.center,
                              );
                            } else {
                              // setState(() {
                              //   jumlahDriver = value as int?;
                              // });
                              return Text("Jumlah : $value",
                                  textAlign: TextAlign.center);
                            }
                          },
                        ),
                      ]),
                      ButtonLanjut(
                        onTap: () {
                          List<String> selectedItems = [];
                          if (_formKey.currentState!.validate()) {
                            for (int i = 0; i < checkedItems.length; i++) {
                              if (checkedItems[i]) {
                                selectedItems.add(items[i]);
                              }
                            }
                            driverController.handleDriver(
                                context,
                                selectedItems.isNotEmpty ? selectedItems : null,
                                jumlahDriver);
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
