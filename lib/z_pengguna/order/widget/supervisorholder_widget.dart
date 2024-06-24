import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:outsourcing/components/text_widget.dart';
import 'package:outsourcing/z_pengguna/order/controller/placementuser_controller.dart';
import 'package:outsourcing/z_pengguna/order/view/detailsupervisor.dart';

class SupervisorHolderWidget extends StatefulWidget {
  final String id;

  const SupervisorHolderWidget({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  State<SupervisorHolderWidget> createState() => SupervisorHolderWidgetState();
}

class SupervisorHolderWidgetState extends State<SupervisorHolderWidget> {
  var placementuserCon = Get.put(PlacementUserController());
  bool isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Fungsi untuk memuat data
  void _loadData() async {
    await _refreshData();
    placementuserCon.setUserId(widget.id);
    setState(() {
      isDataLoaded = true;
    });
  }

  // Function to handle refreshing
  Future<void> _refreshData() async {
    placementuserCon.setUserId(widget.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: isDataLoaded
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextWidget(
                  'Supervisor',
                  18,
                  Color.fromRGBO(45, 3, 59, 1),
                  FontWeight.bold,
                  letterSpace: 0,
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 100,
                  width: 350,
                  // width: MediaQuery.of(context).size.width,
                  child: Obx(
                    () => placementuserCon.isLoading.value
                        ? const SpinKitWanderingCubes(
                            color: Colors.deepPurple,
                            size: 50.0,
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                placementuserCon.listPlacementUser.length,
                            padding: const EdgeInsets.only(bottom: 10),
                            itemBuilder: (BuildContext context, int index) {
                              var placementuser =
                                  placementuserCon.listPlacementUser[index];
                              return placementuserCard(
                                placementuser.supervisor!.fullname.toString(),
                                placementuser.supervisor!.fullAddress
                                    .toString(),
                                placementuser.supervisor!.birthPlace.toString(),
                                placementuser.supervisor!.birthDate.toString(),
                                placementuser.supervisor!.nik.toString(),
                                placementuser.supervisor!.npwp.toString(),
                                placementuser.supervisor!.gender.toString(),
                                placementuser.supervisor!.phone.toString(),
                              );
                            }),
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

  Widget placementuserCard(
    String fullname,
    String address,
    String birthplace,
    String birthdate,
    String nik,
    String npwp,
    String gender,
    String phone,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailSupervisor(
              fullname: fullname,
              address: address,
              birthplace: birthplace,
              birthdate: birthdate,
              nik: nik,
              npwp: npwp,
              gender: gender,
              phone: phone,
            ),
          ),
        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox(
          height: 90,
          width: double.infinity,
          child: Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              CircleAvatar(
                radius: 30,
                backgroundImage:
                    const AssetImage('lib/images/icon/ic_driver.png'),
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
                      fullname,
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
                      phone,
                      15,
                      const Color.fromRGBO(193, 71, 233, 1),
                      FontWeight.normal,
                      letterSpace: 0,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      address,
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
