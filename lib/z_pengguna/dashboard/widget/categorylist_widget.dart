import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:outsourcing/model/service_model.dart';
import 'package:outsourcing/z_pengguna/dashboard/controller/service_controller.dart';
import 'package:outsourcing/z_pengguna/order_layanan/view/orderlayanan.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  var serviceCon = Get.put(ServiceController());
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
    await serviceCon.getService(); // Tunggu hingga data selesai dimuat
    setState(() {
      isDataLoaded = true; // Setelah data dimuat, ubah status menjadi true
    });
  }

  // Function to handle refreshing
  Future<void> _refreshData() async {
    await serviceCon.getService();
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
                itemCount: serviceCon.listService.length,
                itemBuilder: (BuildContext context, int index) {
                  var service = serviceCon.listService[index];
                  return serviceCard(
                    service.serviceName.toString(),
                    service.image.toString(),
                    service.serviceItems!.toList(),
                    service.basePrice.toString(),
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

  Widget serviceCard(String name, String image, List<ServiceItems> serviceItems,
      String baseprice) {
    return GestureDetector(
      onTap: () {
        // Aksi saat card diklik
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderLayanan(
                name: name,
                image: image,
                serviceItems: serviceItems,
                baseprice: baseprice),
          ),
        );
      },
      child: Obx(
        () => serviceCon.isLoading.value
            ? const SpinKitPulse(
                color: Colors.grey,
                size: 10.0,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
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
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('lib/images/icon/ic_user.png'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
