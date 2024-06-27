import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:outsourcing/components/text_widget.dart';
import 'package:outsourcing/z_supervisor/respon_complaint/controller/responses_controller.dart';
import 'package:outsourcing/z_supervisor/respon_complaint/widget/titlerc_widget.dart';

class ResponseComplaint extends StatefulWidget {
  // final String username;
  const ResponseComplaint({Key? key}) : super(key: key);

  @override
  State<ResponseComplaint> createState() => _ResponseComplaintState();
}

class _ResponseComplaintState extends State<ResponseComplaint> {
  var animate = false;
  var opacity = 0.0;
  bool position = false;
  late Size size;
  var responseCon = Get.put(ResponseBController());
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
    await responseCon.getComplaint();
    setState(() {
      isDataLoaded = true;
    });
  }

  // Function to handle refreshing
  Future<void> _refreshData() async {
    await responseCon.getComplaint();
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
          ? Scaffold(
              body: SafeArea(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(top: 30, left: 0, right: 0),
                  height: size.height,
                  width: size.width,
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 400),
                        top: position ? 1 : 50,
                        left: 20,
                        right: 20,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 400),
                          opacity: opacity,
                          child: TitleRCWidget(
                            animator: animator,
                            context: context,
                            labelText: 'Response & Complaint',
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 400),
                        top: position ? 50 : 100,
                        left: 20,
                        right: 20,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 400),
                          opacity: opacity,
                          child: Divider(
                            height: 15,
                            thickness: 2,
                            color: Colors.black.withOpacity(0.2),
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        top: position ? 60 : 100,
                        left: 20,
                        right: 20,
                        duration: const Duration(milliseconds: 400),
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 400),
                          opacity: opacity,
                          child: SizedBox(
                              height: 610,
                              width: MediaQuery.of(context).size.width,
                              child: Obx(
                                () => responseCon.isLoading.value
                                    ? const SpinKitWanderingCubes(
                                        color: Colors.deepPurple,
                                        size: 50.0,
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:
                                            responseCon.listComplaint.length,
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          var complaint =
                                              responseCon.listComplaint[index];
                                          return complaintlistCard(
                                            complaint.id!.toInt(),
                                            complaint.serviceUser!.fullname
                                                .toString(),
                                            complaint.employee!.fullname
                                                .toString(),
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

  Widget complaintlistCard(int id, String namapemesan, String namakaryawan,
      String comment, String reply) {
    return GestureDetector(
      onTap: () {
        responseCon.navigateToDetails(
          context,
          id,
          namapemesan,
          namakaryawan,
          comment,
          reply,
        );
      },
      child: Card(
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
                TextWidget(
                  'Pemesan : $namapemesan',
                  15,
                  const Color.fromRGBO(45, 3, 59, 1),
                  FontWeight.bold,
                  letterSpace: 0,
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 5,
                ),
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
                  reply.isNotEmpty
                      ? reply
                      : 'Mohon menunggu respon supervisor!',
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
      ),
    );
  }
}
