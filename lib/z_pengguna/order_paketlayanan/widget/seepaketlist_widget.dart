import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:outsourcing/global.dart';
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
              height: 320,
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
    int hargaInt = int.parse(totalprice);
    String formattedTotalprice =
        NumberFormat.currency(locale: 'id', symbol: 'Rp.', decimalDigits: 0)
            .format(hargaInt);
    final imageURL = '$baseURL/resource/packages/$idpaket/main_image/';
    print('Image URL: $imageURL');
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
        color: Colors.white,
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
                backgroundImage: NetworkImage(
                  imageURL,
                ),
                onBackgroundImageError: (error, stackTrace) {
                  print('Error loading image: $error');
                },
                backgroundColor: const Color.fromRGBO(193, 71, 233, 1),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(45, 3, 59, 1),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0,
                      ),
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    TextWidget(
                      formattedTotalprice,
                      15,
                      const Color.fromRGBO(193, 71, 233, 1),
                      FontWeight.normal,
                      letterSpace: 0,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black.withOpacity(.6),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
