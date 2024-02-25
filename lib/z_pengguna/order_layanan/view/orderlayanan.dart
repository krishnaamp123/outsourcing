import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:outsourcing/model/service_model.dart';
import 'package:outsourcing/core.dart';
import 'package:outsourcing/z_pengguna/order_layanan/controller/orderlayanan_controller.dart';
import 'package:intl/intl.dart';

class OrderLayanan extends StatefulWidget {
  final String image;
  final String name;
  final List<ServiceItems> serviceItems;
  final String baseprice;

  const OrderLayanan(
      {Key? key,
      required this.image,
      required this.name,
      required this.serviceItems,
      required this.baseprice})
      : super(key: key);

  @override
  State<OrderLayanan> createState() => _OrderLayananState();
}

class _OrderLayananState extends State<OrderLayanan> {
  final _formKey = GlobalKey<FormState>();
  //text editing controllers
  final OrderLayananController orderlayananController =
      OrderLayananController();
  // int? jumlahCleaner = 1;
  var animate = false;
  var opacity = 0.0;
  bool position = false;
  late Size size;
  int jumlahCleaner = 1;
  List<ServiceItems> serviceItems = [];
  List<bool> checkedItems = [];
  List<int> hargaitem = [];
  List<int> idservice = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      animator();
      checkedItems = List<bool>.filled(widget.serviceItems.length, false);
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
    String name = widget.name;
    String image = widget.image;
    String baseprice = widget.baseprice;
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
                  labelText: 'Pesan $name',
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
                              controller:
                                  orderlayananController.alamatController,
                              upText: 'Alamat',
                              hintText: 'ex: Jl Udayana...',
                              obscureText: false,
                              validator: orderlayananController.validateAlamat,
                              onChanged: (_) {
                                setState(() {
                                  orderlayananController.alamatError = null;
                                });
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFieldLayanan(
                              controller: orderlayananController.hariController,
                              upText: 'Lama Kontrak',
                              hintText: 'ex: 9 Hari',
                              obscureText: false,
                              validator: orderlayananController.validateHari,
                              onChanged: (_) {
                                setState(() {
                                  orderlayananController.hariError = null;
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
                              itemCount: widget.serviceItems.length,
                              padding: const EdgeInsets.only(bottom: 10),
                              itemExtent: 50,
                              itemBuilder: (context, index) {
                                final item = widget.serviceItems[index];
                                return CheckboxListTile(
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        item.itemName!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16,
                                          color: Color.fromRGBO(45, 3, 59, 1),
                                        ),
                                      ),
                                      Text(
                                        '${item.partialServiceId}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // subtitle: Text(
                                  //   'Rp. ${item.pricePerItem.toString()}',
                                  //   style: const TextStyle(
                                  //     fontWeight: FontWeight.normal,
                                  //     fontSize: 14,
                                  //     color: Color.fromRGBO(45, 3, 59, 1),
                                  //   ),
                                  // ),
                                  subtitle: Text(
                                    'Rp. ${NumberFormat.currency(locale: 'id', symbol: '', decimalDigits: 0).format(item.pricePerItem)}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
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
                          child: TextWidget(
                            "Jumlah $name",
                            15,
                            const Color.fromRGBO(129, 12, 168, 1),
                            FontWeight.normal,
                            letterSpace: 0,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const SizedBox(height: 5),
                        InputQty.int(
                          initVal: jumlahCleaner,
                          minVal: 1,
                          maxVal: 50,
                          steps: 1,
                          onQtyChanged: (value) {
                            setState(() {
                              jumlahCleaner = value ?? 1;
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
                          List<String> selectedItems = [];
                          hargaitem = [];
                          idservice = [];
                          if (_formKey.currentState!.validate()) {
                            for (int i = 0; i < checkedItems.length; i++) {
                              if (checkedItems[i]) {
                                selectedItems
                                    .add(widget.serviceItems[i].itemName!);
                                hargaitem
                                    .add(widget.serviceItems[i].pricePerItem!);
                                idservice.add(
                                    widget.serviceItems[i].partialServiceId!);
                              }
                            }
                            orderlayananController.handleOrderLayanan(
                                context,
                                selectedItems.isNotEmpty ? selectedItems : null,
                                hargaitem,
                                idservice,
                                jumlahCleaner,
                                name,
                                image,
                                baseprice);
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
