import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:outsourcing/components/text_widget.dart';
import 'package:outsourcing/global.dart';
import 'package:outsourcing/model/placementuser_model.dart';
import 'package:outsourcing/z_pengguna/order/controller/placementuser_controller.dart';
import 'package:outsourcing/z_pengguna/order/view/detailkaryawan.dart';

class KaryawanHolderWidget extends StatefulWidget {
  final String id;

  const KaryawanHolderWidget({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  State<KaryawanHolderWidget> createState() => KaryawanHolderWidgetState();
}

class KaryawanHolderWidgetState extends State<KaryawanHolderWidget> {
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
                  'Karyawan',
                  18,
                  Color.fromRGBO(45, 3, 59, 1),
                  FontWeight.bold,
                  letterSpace: 0,
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 200,
                  // width: 350,
                  width: MediaQuery.of(context).size.width,
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
                              return Column(
                                children: placementuser.details!.map((details) {
                                  return placementuserCard(
                                    details.employees!.toList(),
                                  );
                                }).toList(),
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

  Widget placementuserCard(
    List<Employees> employees,
  ) {
    return Column(
      children: employees.map((employee) {
        final fullname = employee.employee!.fullname!;
        final address = employee.employee!.fullAddress!;
        final birthplace = employee.employee!.birthPlace!;
        final birthdate = employee.employee!.birthDate!;
        final nik = employee.employee!.nik!;
        final npwp = employee.employee!.npwp!;
        final gender = employee.employee!.gender!;
        final phone = employee.employee!.phone!;
        final education = employee.employee!.lastEducation!;
        final userid = employee.employee!.userId!.toString();
        final salarytotal = employee.expectedSalaryTotal!.toString();
        final salary = employee.expectedSalary!.toString();
        final id = employee.id!.toInt();
        final imageURL = '$baseURL/resource/users/$userid/profile/';
        print('Image URL: $imageURL');
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailKaryawan(
                  fullname: fullname,
                  address: address,
                  birthplace: birthplace,
                  birthdate: birthdate,
                  nik: nik,
                  npwp: npwp,
                  gender: gender,
                  phone: phone,
                  education: education,
                  userid: userid,
                  salarytotal: salarytotal,
                  salary: salary,
                  id: id,
                ),
              ),
            );
          },
          child: Card(
            color: Colors.white,
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
      }).toList(),
    );
  }
}
