import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outsourcing/core.dart';
import 'package:outsourcing/z_pengguna/order/controller/order_controller.dart';
import 'package:outsourcing/z_pengguna/order/widget/formholder_widget.dart';
import 'package:outsourcing/z_pengguna/order/widget/infoform_widget.dart';

class FormPerformance extends StatefulWidget {
  final Function()? onTap;
  final String id;

  const FormPerformance({
    Key? key,
    required this.id,
    this.onTap,
  }) : super(key: key);

  @override
  State<FormPerformance> createState() => _FormPerformanceState();
}

class _FormPerformanceState extends State<FormPerformance> {
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
                  labelText: 'Formulir Penilaian',
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
                  judul: 'Formulir Info',
                  isinya:
                      'Pengisian formulir dilakukan secara berkala,\nterimakasih telah berpartisipasi',
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
                          FormHolderWidget(id: id),
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
