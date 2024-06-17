import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:outsourcing/components/text_widget.dart';
import 'package:outsourcing/global.dart';
import 'package:outsourcing/z_pengguna/dashboard/controller/paket_controller.dart';
import 'package:outsourcing/z_pengguna/order_paketlayanan/view/see_all.dart';

class PaketListWidget extends StatefulWidget {
  const PaketListWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<PaketListWidget> createState() => _PaketListWidgetState();
}

class _PaketListWidgetState extends State<PaketListWidget> {
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
          ? Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextWidget(
                      "Paket Layanan",
                      20,
                      Color.fromRGBO(45, 3, 59, 1),
                      FontWeight.bold,
                      letterSpace: 0,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const SeeAll();
                            },
                          ));
                        },
                        child: const TextWidget(
                          "Lihat Semua",
                          15,
                          Color.fromRGBO(193, 71, 233, 1),
                          FontWeight.bold,
                          letterSpace: 0,
                        )),
                  ],
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 300,
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
                                paket.minContract.toString(),
                              );
                            },
                          ),
                  ),
                ),
              ],
            )
          : const Center(
              child: SpinKitWanderingCubes(
              color: Colors.deepPurple,
              size: 50.0,
            ) // Tampilkan loading indicator jika data masih dimuat
              ),
    );
  }

  Widget paketCard(String idpaket, String name, String image,
      String description, String contract) {
    final imageURL = '$baseURL/resource/packages/$idpaket/main_image/';
    print('Image URL: $imageURL');
    return Card(
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
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black.withOpacity(.6),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0,
                    ),
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
