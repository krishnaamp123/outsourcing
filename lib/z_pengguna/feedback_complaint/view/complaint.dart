import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:outsourcing/components/text_widget.dart';
import 'package:outsourcing/z_pengguna/feedback_complaint/controller/complaint_controller.dart';

class ComplaintBWidget extends StatefulWidget {
  const ComplaintBWidget({super.key});

  @override
  State<ComplaintBWidget> createState() => _ComplaintBWidgetState();
}

class _ComplaintBWidgetState extends State<ComplaintBWidget> {
  var animate = false;
  var opacity = 0.0;
  bool position = false;
  late Size size;
  var complaintCon = Get.put(ComplaintBController());
  bool isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      animator();
    });
    _loadData();
  }

  // Fungsi untuk memuat data
  void _loadData() async {
    await _refreshData();
    await complaintCon.getComplaint();
    setState(() {
      isDataLoaded = true;
    });
  }

  // Function to handle refreshing
  Future<void> _refreshData() async {
    await complaintCon.getComplaint();
    setState(() {});
  }

  animator() {
    if (opacity == 1) {
      opacity = 0;
      animate = true;
      position = false;
    } else {
      opacity = 1;
      animate = false;
      position = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: isDataLoaded
          ? Container(
              color: Colors.white,
              height: size.height,
              width: size.width,
              child: Stack(
                children: [
                  AnimatedPositioned(
                    top: position ? 1 : 50,
                    left: 0,
                    right: 0,
                    duration: const Duration(milliseconds: 400),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 400),
                      opacity: opacity,
                      child: SizedBox(
                          height: 550,
                          width: MediaQuery.of(context).size.width,
                          child: Obx(
                            () => complaintCon.isLoading.value
                                ? const SpinKitWanderingCubes(
                                    color: Colors.deepPurple,
                                    size: 50.0,
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        complaintCon.listComplaint.length,
                                    padding: const EdgeInsets.only(bottom: 10),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var complaint =
                                          complaintCon.listComplaint[index];
                                      return complaintlistCard(
                                        complaint.employee!.fullname.toString(),
                                        complaint.comment.toString(),
                                        complaint.replies!.isNotEmpty
                                            ? complaint.replies!.first.reply
                                                .toString()
                                            : '', // Check if reply list is not empty
                                      );
                                    },
                                  ),
                          )),
                    ),
                  ),
                ],
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

  Widget complaintlistCard(String namakaryawan, String comment, String reply) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextWidget(
                'Complaint',
                15,
                Color.fromRGBO(129, 12, 168, 1),
                FontWeight.normal,
                letterSpace: 0,
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 5,
              ),
              TextWidget(
                namakaryawan,
                15,
                const Color.fromRGBO(45, 3, 59, 1),
                FontWeight.bold,
                letterSpace: 0,
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 5,
              ),
              TextWidget(
                comment,
                16,
                const Color.fromRGBO(45, 3, 59, 1),
                FontWeight.normal,
                letterSpace: 0,
                textAlign: TextAlign.left,
              ),
              Divider(
                height: 10,
                thickness: 1,
                color: Colors.black.withOpacity(0.2),
              ),
              const TextWidget(
                'Response',
                15,
                Color.fromRGBO(129, 12, 168, 1),
                FontWeight.normal,
                letterSpace: 0,
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 5,
              ),
              TextWidget(
                reply.isNotEmpty ? reply : 'Mohon menunggu respon supervisor!',
                16,
                const Color.fromRGBO(45, 3, 59, 1),
                FontWeight.normal,
                letterSpace: 0,
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
