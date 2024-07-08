import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:outsourcing/global.dart';
import 'package:outsourcing/model/layanan_model.dart';
import 'package:outsourcing/z_pengguna/dashboard/controller/layanan_controller.dart';
import 'package:outsourcing/z_pengguna/order_layanan/view/orderlayanan.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  var layananCon = Get.put(LayananController());
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
    await layananCon.getLayanan(); // Tunggu hingga data selesai dimuat
    setState(() {
      isDataLoaded = true; // Setelah data dimuat, ubah status menjadi true
    });
  }

  // Function to handle refreshing
  Future<void> _refreshData() async {
    await layananCon.getLayanan();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: isDataLoaded
          ? SizedBox(
              height: 90,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemExtent: 90,
                itemCount: layananCon.listLayanan.length,
                itemBuilder: (BuildContext context, int index) {
                  var layanan = layananCon.listLayanan[index];
                  return layananCard(
                    layanan.id.toString(),
                    layanan.serviceName.toString(),
                    layanan.mainImage.toString(),
                    layanan.additionalItems!.toList(),
                    layanan.requiredItems!.toList(),
                    layanan.totalPrice.toString(),
                    layanan.description.toString(),
                  );
                },
              ),
            )
          : const Center(
              child: SpinKitThreeBounce(
              color: Colors.deepPurple,
              size: 30.0,
            ) // Tampilkan loading indicator jika data masih dimuat
              ),
    );
  }

  Widget layananCard(
    String idserviceril,
    String name,
    String image,
    List<AdditionalItems> additionalItems,
    List<RequiredItems> requiredItems,
    String baseprice,
    String description,
  ) {
    // String displayName =
    //     name.length > 12 ? '${name.substring(0, 12)}...' : name;
    final imageURL = '$baseURL/resource/services/$idserviceril/main_image/';

    print('Image URL: $imageURL');

    return GestureDetector(
      onTap: () {
        // Aksi saat card diklik
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderLayanan(
                idserviceril: idserviceril,
                name: name,
                image: image,
                additionalItems: additionalItems,
                requiredItems: requiredItems,
                baseprice: baseprice,
                description: description),
          ),
        );
      },
      child: Obx(
        () => layananCon.isLoading.value
            ? const SpinKitPulse(
                color: Colors.grey,
                size: 10.0,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    color: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.network(
                        imageURL,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          print('Error loading image: $error');
                          return Image.asset(
                            'lib/images/icon/ic_user.png',
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color.fromRGBO(45, 3, 59, 1),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0,
                    ),
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
      ),
    );
  }
}
