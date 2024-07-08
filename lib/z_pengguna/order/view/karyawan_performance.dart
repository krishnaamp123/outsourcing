import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outsourcing/core.dart';
import 'package:outsourcing/z_pengguna/order/controller/order_controller.dart';
import 'package:outsourcing/z_pengguna/order/widget/formkaryawanholder_widget.dart';
import 'package:outsourcing/z_pengguna/order/widget/infoform_widget.dart';

class KaryawanPerformance extends StatefulWidget {
  final Function()? onTap;
  final String id;
  final String formid;

  const KaryawanPerformance({
    Key? key,
    required this.id,
    required this.formid,
    this.onTap,
  }) : super(key: key);

  @override
  State<KaryawanPerformance> createState() => _KaryawanPerformanceState();
}

class _KaryawanPerformanceState extends State<KaryawanPerformance> {
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
    String id = widget.id;
    String formid = widget.formid;
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
                  labelText: 'Penilaian Karyawan',
                ),
              ),
            ),
            AnimatedPositioned(
              top: position ? 60 : 60,
              right: 20,
              left: 20,
              duration: const Duration(milliseconds: 300),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: opacity,
                child: InfoFormWidget(
                  animator: animator,
                  context: context,
                  judul: 'Karyawan Info',
                  isinya:
                      'Pastikan telah mengisi formulir seluruh karyawan,\nsilahkan submit file penilaian karyawan anda',
                ),
              ),
            ),
            AnimatedPositioned(
                top: position ? 180 : 230,
                duration: const Duration(milliseconds: 400),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: SizedBox(
                    height: 600,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormKaryawanHolderWidget(
                            id: id,
                            formid: formid,
                          )
                        ],
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
