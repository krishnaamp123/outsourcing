import 'dart:async';
import 'package:flutter/material.dart';
import 'package:outsourcing/core.dart';
import 'package:outsourcing/z_pengguna/order_paketlayanan/controller/see_all_controller.dart';
import 'package:outsourcing/z_pengguna/order_paketlayanan/widget/info_widget.dart';
import 'package:outsourcing/z_pengguna/order_paketlayanan/widget/seepaketlist_widget.dart';
import 'package:outsourcing/z_pengguna/order_paketlayanan/widget/upperrow_widget.dart';

class SeeAll extends StatefulWidget {
  const SeeAll({super.key});

  @override
  State<SeeAll> createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> {
  var opacity = 0.0;
  bool position = false;
  final _formKey = GlobalKey<FormState>();
  //text editing controllers
  final SeeAllController seeallController = SeeAllController();
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
      position = false;
    } else {
      opacity = 1;
      position = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
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
                  child: UpperRowWidget(
                    context: context,
                    animator: animator,
                  ),
                ),
              ),
              AnimatedPositioned(
                top: position ? 60 : 120,
                right: 20,
                left: 20,
                duration: const Duration(milliseconds: 300),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: InfoWidget(
                    animator: animator,
                    context: context,
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                top: position ? 180 : 230,
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
                      height: 175,
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextFieldAlamat(
                                controller:
                                    seeallController.namapesananController,
                                upText: 'Atas Nama Pemesanan',
                                hintText: 'ex: PT Udayana...',
                                obscureText: false,
                                validator: seeallController.validateNamaPesanan,
                                onChanged: (_) {
                                  setState(() {
                                    seeallController.namapesananError = null;
                                  });
                                },
                              ),
                              const SizedBox(height: 5),
                              TextFieldAlamat(
                                controller: seeallController.alamatController,
                                upText: 'Alamat',
                                hintText: 'ex: Jl Udayana...',
                                obscureText: false,
                                validator: seeallController.validateAlamat,
                                onChanged: (_) {
                                  setState(() {
                                    seeallController.alamatError = null;
                                  });
                                },
                              ),
                            ]),
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                  top: position ? 370 : 420,
                  right: 20,
                  left: 20,
                  duration: const Duration(milliseconds: 400),
                  child: AnimatedOpacity(
                    opacity: opacity,
                    duration: const Duration(milliseconds: 400),
                    child: SizedBox(
                      width: size.width,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextWidget(
                            "Semua Paket Layanan",
                            20,
                            Color.fromRGBO(45, 3, 59, 1),
                            FontWeight.bold,
                            letterSpace: 0,
                          ),
                        ],
                      ),
                    ),
                  )),
              AnimatedPositioned(
                top: position ? 400 : 450,
                left: 20,
                right: 20,
                duration: const Duration(milliseconds: 500),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: opacity,
                  child: SeePackageList(
                    alamatController: seeallController.alamatController,
                    namapesananController:
                        seeallController.namapesananController,
                    formKey: _formKey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
