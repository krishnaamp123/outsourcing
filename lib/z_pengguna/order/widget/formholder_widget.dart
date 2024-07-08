import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:outsourcing/components/text_widget.dart';
import 'package:outsourcing/z_pengguna/order/controller/placementuser_controller.dart';
import 'package:outsourcing/z_pengguna/order/view/karyawan_performance.dart';

class FormHolderWidget extends StatefulWidget {
  final String id;

  const FormHolderWidget({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  State<FormHolderWidget> createState() => FormHolderWidgetState();
}

class FormHolderWidgetState extends State<FormHolderWidget> {
  var placementuserCon = Get.put(PlacementUserController());
  bool isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadData();
    _refreshData();
  }

  // Fungsi untuk memuat data
  void _loadData() async {
    // await _refreshData();
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
                  'Formulir',
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
                                children: placementuser.forms!.map((form) {
                                  return formCard(
                                    form.id.toString(),
                                    form.date.toString(),
                                    form.fiiledDate?.toString(),
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

  Widget formCard(
    String formid,
    String date,
    String? filleddate,
  ) {
    DateTime parsedDate = DateTime.parse(date);
    String formattedDate = DateFormat('dd-MM-yyyy').format(parsedDate);
    DateTime? parsedfilledDate;
    String formattedfilledDate = "";

    if (filleddate != null) {
      parsedfilledDate = DateTime.parse(filleddate);
      formattedfilledDate = DateFormat('dd-MM-yyyy').format(parsedfilledDate);
    }
    // DateTime? parsedfilledDate;
    // if (filleddate != null) {
    //   parsedfilledDate = DateTime.parse(filleddate);
    // }
    // String formattedfilledDate = parsedfilledDate?.toString() ?? "";
    return InkWell(
      onTap: () {
        if (filleddate != null) {
          final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Info',
              message:
                  'Terimakasih telah mengisi form, kami akan meningkatkan pelayanan kami!',
              contentType: ContentType.help,
            ),
          );

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => KaryawanPerformance(
                id: widget.id,
                formid: formid,
              ),
            ),
          );
        }
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Formulir Penilaian $formid',
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
                  "Tanggal Pembuatan : $formattedDate",
                  15,
                  const Color.fromRGBO(193, 71, 233, 1),
                  FontWeight.normal,
                  letterSpace: 0,
                  textAlign: TextAlign.left,
                ),
                TextWidget(
                  "Tanggal Pengisian : $formattedfilledDate",
                  15,
                  const Color.fromRGBO(193, 71, 233, 1),
                  FontWeight.normal,
                  letterSpace: 0,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
