import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:outsourcing/components/text_widget.dart';
import 'package:outsourcing/global.dart';
import 'package:outsourcing/model/placementuser_model.dart';
import 'package:outsourcing/z_pengguna/order/controller/placementuser_controller.dart';
import 'package:outsourcing/z_pengguna/order/controller/question_controller.dart';
import 'package:outsourcing/z_pengguna/order/widget/questionholder_widget.dart';

class FormKaryawanHolderWidget extends StatefulWidget {
  final String id;
  final String formid;

  const FormKaryawanHolderWidget({
    required this.id,
    required this.formid,
    Key? key,
  }) : super(key: key);

  @override
  State<FormKaryawanHolderWidget> createState() =>
      FormKaryawanHolderWidgetState();
}

class FormKaryawanHolderWidgetState extends State<FormKaryawanHolderWidget> {
  var placementuserCon = Get.put(PlacementUserController());
  var questionCon = Get.put(QuestionController());
  bool isDataLoaded = false;
  Map<int, Map<int, String>> submittedAnswers = {};

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

  Future<void> _submitAllAnswers() async {
    for (var employeeId in submittedAnswers.keys) {
      var answers = submittedAnswers[employeeId]!;
      await _submitAnswers(widget.formid, employeeId.toString(), answers);
    }
  }

  Future<void> _submitAnswers(String performanceFormId, String employeeId,
      Map<int, String> answers) async {
    questionCon.isLoading.value = true;
    List<Map<String, dynamic>> details = [];
    questionCon.listQuestion.asMap().forEach((index, question) {
      details.add({
        "placement_detail_employee_id": int.parse(employeeId),
        "question": question.question,
        "answer": answers[index],
      });
    });

    var response = await questionCon.questionService
        .postPerformance(int.parse(performanceFormId), details);
    questionCon.isLoading.value = false;

    if (response.statusCode == 201) {
      // Show success snackbar
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Info',
          message:
              'Feedback berhasil dikirimkan, terima kasih atas masukannya!',
          contentType: ContentType.success,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);

      // Navigate to Start page after delay
      await Future.delayed(const Duration(seconds: 2));
      Navigator.pop(context);
    } else if (response.statusCode == 422) {
      // Show error snackbar
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Info',
          message: 'Mohon pilih satu jawaban di setiap pertanyaan.',
          contentType: ContentType.warning,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    } else {
      // Show failure snackbar
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Info',
          message: 'Mohon pilih satu jawaban di setiap pertanyaan.',
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
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
                  height: 450,
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
                                    details.service!.categoryId.toString(),
                                    details.employees!.toList(),
                                  );
                                }).toList(),
                              );
                            },
                          ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (submittedAnswers.length <
                        placementuserCon.listPlacementUser.length) {
                      final snackBar = SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Info',
                          message:
                              'Mohon isi semua jawaban sebelum submit penilaian',
                          contentType: ContentType.warning,
                        ),
                      );
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                      return;
                    }
                    _submitAllAnswers(); // Submit all answers
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Radius tombol
                      ),
                      backgroundColor: const Color.fromRGBO(193, 71, 233, 1)),
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0,
                    ), // Ukuran teks diperkecil
                  ),
                ),
              ],
            )
          : const Center(
              child: SpinKitWanderingCubes(
              color: Colors.deepPurple,
              size: 50.0,
            )),
    );
  }

  Widget placementuserCard(
    String categoryid,
    List<Employees> employees,
  ) {
    return Column(
      children: employees.map((employee) {
        final fullname = employee.employee!.fullname!;
        final address = employee.employee!.fullAddress!;
        final phone = employee.employee!.phone!;
        final userid = employee.employee!.userId!.toString();
        final employeedetailid = employee.id!.toString();

        final imageURL = '$baseURL/resource/users/$userid/profile/';
        print('Image URL: $imageURL');

        return GestureDetector(
          onTap: () {
            if (submittedAnswers.containsKey(int.parse(employeedetailid))) {
              final snackBar = SnackBar(
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Info',
                  message: 'Jawaban sudah dikirim.',
                  contentType: ContentType.help,
                ),
              );
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(snackBar);
              return;
            }
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    "Performances Karyawan",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(193, 71, 233, 1),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  content: QuestionHolderWidget(
                    categoryid: categoryid,
                    performanceFormId: int.parse(employeedetailid),
                    employeeId: int.parse(widget.formid),
                    onAnswersSubmit: (answers) {
                      Navigator.of(context).pop();
                      setState(() {
                        submittedAnswers[int.parse(employeedetailid)] = answers;
                      });
                    },
                  ),
                );
              },
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
                  if (submittedAnswers.containsKey(int.parse(employeedetailid)))
                    const Icon(
                      Icons.check,
                      color: Colors.green,
                      size: 35,
                    ),
                  const SizedBox(
                    width: 10,
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
