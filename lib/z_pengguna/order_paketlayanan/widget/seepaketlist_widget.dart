import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:outsourcing/z_pengguna/dashboard/controller/paket_controller.dart';
import 'package:outsourcing/z_pengguna/order_paketlayanan/controller/see_all_controller.dart';

import '../../../core.dart';

class SeePackageList extends StatefulWidget {
  final TextEditingController alamatController;
  final TextEditingController namapesananController;
  final GlobalKey<FormState> formKey;

  const SeePackageList({
    Key? key,
    required this.alamatController,
    required this.namapesananController,
    required this.formKey,
  }) : super(key: key);

  @override
  State<SeePackageList> createState() => _PackageListState();
}

class _PackageListState extends State<SeePackageList> {
  final SeeAllController seeallController = SeeAllController();
  var paketCon = Get.put(PaketController());
  bool isDataLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshData();
    _loadData();
  }

  // Fungsi untuk memuat data
  void _loadData() async {
    await paketCon.getPaket();
    setState(() {
      isDataLoaded = true;
    });
  }

  // Function to handle refreshing
  Future<void> _refreshData() async {
    await paketCon.getPaket();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: isDataLoaded
          ? SizedBox(
              height: 380,
              width: MediaQuery.of(context).size.width,
              child: Obx(
                () => paketCon.isLoading.value
                    ? const SpinKitWanderingCubes(
                        color: Colors.deepPurple,
                        size: 50.0,
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: paketCon.listPaket.length,
                        padding: const EdgeInsets.only(bottom: 10),
                        itemExtent: 100,
                        itemBuilder: (BuildContext context, int index) {
                          var paket = paketCon.listPaket[index];
                          return paketCard(
                              paket.id.toString(),
                              paket.packageName.toString(),
                              paket.mainImage.toString(),
                              paket.description.toString(),
                              paket.includes.toString(),
                              paket.totalPrice.toString(),
                              paket.minContract.toString(),
                              paket.services!.first.totalEmployee.toString());
                        },
                      ),
              ),
            )
          : const Center(
              child: SpinKitWanderingCubes(
              color: Colors.deepPurple,
              size: 50.0,
            ) // Tampilkan loading indicator jika data masih dimuat
              ),
    );
  }

  Widget paketCard(
      String idpaket,
      String name,
      String image,
      String description,
      String includes,
      String totalprice,
      String mincontract,
      String totalemployee) {
    return InkWell(
      onTap: () {
        if (widget.formKey.currentState!.validate()) {
          String alamat = widget.alamatController.text;
          String? alamatError = seeallController.validateAlamat(alamat);
          String namapesanan = widget.namapesananController.text;
          String? namapesananError =
              seeallController.validateNamaPesanan(namapesanan);
          if (alamatError != null) {
            seeallController.alamatError = alamatError;
          } else if (namapesananError != null) {
            seeallController.namapesananError = namapesananError;
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaketLayanan(
                  namapesanan: namapesanan,
                  alamat: alamat,
                  idpaket: idpaket,
                  image: image,
                  name: name,
                  description: description,
                  includes: includes,
                  totalprice: totalprice,
                  mincontract: mincontract,
                  totalemployee: totalemployee,
                ),
              ),
            );
          }
        }
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox(
          height: 100,
          width: double.infinity,
          child: Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              CircleAvatar(
                radius: 30,
                backgroundImage: mainImageWidget(image),
                backgroundColor: const Color.fromRGBO(193, 71, 233, 1),
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    name,
                    18,
                    const Color.fromRGBO(45, 3, 59, 1),
                    FontWeight.bold,
                    letterSpace: 0,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextWidget(
                    description,
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
    );
  }

  ImageProvider mainImageWidget(String imageUrl) {
    if (imageUrl.isEmpty) {
      return const AssetImage('lib/images/icon/ic_user.png');
    } else {
      return NetworkImage(
        imageUrl,
      );
    }
  }
}
