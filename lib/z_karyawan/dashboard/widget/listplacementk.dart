import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:outsourcing/components/text_widget.dart';
import 'package:outsourcing/model/placement_model.dart';
import 'package:outsourcing/z_karyawan/dashboard/controller/placementk_controller.dart';

class ListPlacementKWidget extends StatefulWidget {
  const ListPlacementKWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ListPlacementKWidget> createState() => _ListPlacementKWidgetState();
}

class _ListPlacementKWidgetState extends State<ListPlacementKWidget> {
  var placementCon = Get.put(PlacementKController());
  bool isDataLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }

  // Fungsi untuk memuat data
  void _loadData() async {
    await _refreshData();
    await placementCon.getPlacement();
    setState(() {
      isDataLoaded = true;
    });
  }

  // Function to handle refreshing
  Future<void> _refreshData() async {
    await placementCon.getPlacement();
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
                () => placementCon.isLoading.value
                    ? const SpinKitWanderingCubes(
                        color: Colors.deepPurple,
                        size: 50.0,
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: placementCon.listPlacement.length,
                        itemBuilder: (BuildContext context, int index) {
                          var placement = placementCon.listPlacement[index];
                          return placementCard(
                            placement.id.toString(),
                            placement.startDate.toString(),
                            placement.endDate.toString(),
                            placement.status.toString(),
                            placement.note.toString(),
                            placement.duration.toString(),
                            placement.totalEmployee.toString(),
                            placement.name.toString(),
                            placement.address.toString(),
                            placement.supervisor!.fullname.toString(),
                            placement.supervisor!.fullAddress.toString(),
                            placement.supervisor!.phone.toString(),
                            placement.details!.first.employees!.toList(),
                          );
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

  Widget placementCard(
    String id,
    String startDate,
    String endDate,
    String status,
    String note,
    String duration,
    String totalEmployee,
    String namaPemesan,
    String alamat,
    String namaSupervisor,
    String alamatSupervisor,
    String telponSupervisor,
    List<Employees> employees,
  ) {
    // int hargaInt = int.parse(salaryKaryawan);
    // String formattedSalaryKaryawan =
    //     NumberFormat.currency(locale: 'id', symbol: 'Rp.', decimalDigits: 0)
    //         .format(hargaInt);
    DateTime parsedstartDate = DateTime.parse(startDate);
    String formattedstartDate =
        DateFormat('dd-MM-yyyy').format(parsedstartDate);
    Color statusColor = _getStatusColor(status);
    // final imageURL = '$baseURL/resource/packages/$idpaket/main_image/';
    // print('Image URL: $imageURL');
    return GestureDetector(
      onTap: () {
        var placementKController = PlacementKController();
        placementKController.navigateToDetails(
          context,
          id,
          startDate,
          endDate,
          status,
          note,
          duration,
          totalEmployee,
          namaPemesan,
          alamat,
          namaSupervisor,
          alamatSupervisor,
          telponSupervisor,
          employees,
        );
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
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      'Order $id',
                      18,
                      const Color.fromRGBO(45, 3, 59, 1),
                      FontWeight.bold,
                      letterSpace: 0,
                      textAlign: TextAlign.left,
                    ),
                    TextWidget(
                      formattedstartDate,
                      15,
                      Colors.black.withOpacity(.6),
                      FontWeight.bold,
                      letterSpace: 0,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      alamat,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black.withOpacity(.6),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0,
                      ),
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    TextWidget(
                      status,
                      15,
                      statusColor,
                      FontWeight.bold,
                      letterSpace: 0,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'waiting_for_mou':
        return Colors.orange;
      case 'waiting_for_initial_payment':
        return Colors.orange;
      case 'waiting_for_further_payment':
        return Colors.orange;
      case 'waiting_for_confirmation':
        return Colors.orange;
      case 'waiting_for_mou_confirmation':
        return Colors.orange;
      case 'ongoing':
        return Colors.green;
      case 'done':
        return Colors.blue;
      case 'confirmed':
        return Colors.blue;
      case 'suspended':
        return Colors.red;
      default:
        return const Color.fromRGBO(45, 3, 59, 1);
    }
  }
}
