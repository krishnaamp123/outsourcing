import 'package:flutter/material.dart';
import 'package:outsourcing/z_pengguna/order_paketlayanan/controller/see_all_controller.dart';

import '../../../core.dart';

class PackageList extends StatefulWidget {
  final List images;
  final List<String> names;
  final List<String> desc;
  final List<String> harga;
  final TextEditingController alamatController;
  final GlobalKey<FormState> formKey;

  const PackageList({
    Key? key,
    required this.images,
    required this.names,
    required this.desc,
    required this.harga,
    required this.alamatController,
    required this.formKey,
  }) : super(key: key);

  @override
  State<PackageList> createState() => _PackageListState();
}

class _PackageListState extends State<PackageList> {
  final SeeAllController seeallController = SeeAllController();
  @override
  Widget build(BuildContext context) {
    double opacity = 1.0;
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: opacity,
      child: SizedBox(
        height: 380,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: images.length,
          padding: const EdgeInsets.only(bottom: 10),
          itemExtent: 100,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              if (widget.formKey.currentState!.validate()) {
                String alamat = widget.alamatController.text;
                String? alamatError = seeallController.validateAlamat(alamat);
                if (alamatError != null) {
                  seeallController.alamatError = alamatError;
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaketLayanan(
                        alamat: alamat,
                        image: widget.images[index],
                        name: widget.names[index],
                        desc: widget.desc[index],
                        harga: widget.harga[index],
                      ),
                    ),
                  );
                }
              }
            },
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SizedBox(
                height: 100,
                width: double.infinity,
                child: Row(
                  children: [
                    const SizedBox(width: 15),
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: widget.images[index],
                      backgroundColor: const Color.fromRGBO(193, 71, 233, 1),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          widget.harga[index],
                          0,
                          const Color.fromRGBO(45, 3, 59, 1),
                          FontWeight.bold,
                          letterSpace: 0,
                          textAlign: TextAlign.left,
                        ),
                        TextWidget(
                          widget.names[index],
                          18,
                          const Color.fromRGBO(45, 3, 59, 1),
                          FontWeight.bold,
                          letterSpace: 0,
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 5),
                        TextWidget(
                          widget.desc[index],
                          15,
                          Colors.black.withOpacity(.6),
                          FontWeight.bold,
                          letterSpace: 0,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
