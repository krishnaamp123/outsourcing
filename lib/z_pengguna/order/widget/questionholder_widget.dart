import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:outsourcing/z_pengguna/order/controller/question_controller.dart';

class QuestionHolderWidget extends StatefulWidget {
  final String categoryid;
  final int performanceFormId;
  final int employeeId;
  final Function(Map<int, String>) onAnswersSubmit;

  const QuestionHolderWidget({
    required this.categoryid,
    required this.performanceFormId,
    required this.employeeId,
    required this.onAnswersSubmit,
    Key? key,
  }) : super(key: key);

  @override
  State<QuestionHolderWidget> createState() => QuestionHolderWidgetState();
}

class QuestionHolderWidgetState extends State<QuestionHolderWidget> {
  var questionCon = Get.put(QuestionController());
  bool isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    _resetAnswers();
    _loadData();
    _refreshData();
  }

  void _resetAnswers() {
    questionCon.selectedAnswers.clear();
  }

  // Fungsi untuk memuat data
  void _loadData() async {
    // await _refreshData();
    questionCon.setCategoryId(widget.categoryid);
    setState(() {
      isDataLoaded = true;
    });
  }

  // Function to handle refreshing
  Future<void> _refreshData() async {
    questionCon.setCategoryId(widget.categoryid);
    setState(() {});
  }

  // void _submitAnswers() {
  //   if (questionCon.selectedAnswers.length < questionCon.listQuestion.length) {
  //     final snackBar = SnackBar(
  //       elevation: 0,
  //       behavior: SnackBarBehavior.floating,
  //       backgroundColor: Colors.transparent,
  //       content: AwesomeSnackbarContent(
  //         title: 'Info',
  //         message:
  //             'Feedback berhasil dikirimkan, terima kasih atas masukannya!',
  //         contentType: ContentType.failure,
  //       ),
  //     );
  //     ScaffoldMessenger.of(context)
  //       ..hideCurrentSnackBar()
  //       ..showSnackBar(snackBar);
  //     return;
  //   }
  //   questionCon.submitAnswers(
  //       widget.performanceFormId, widget.employeeId, context);
  // }

  void _sendAnswersToParent() {
    widget.onAnswersSubmit(questionCon.selectedAnswers);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: isDataLoaded
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 560,
                  // width: 350,
                  width: MediaQuery.of(context).size.width,
                  child: Obx(
                    () => questionCon.isLoading.value
                        ? const SpinKitWanderingCubes(
                            color: Colors.deepPurple,
                            size: 50.0,
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: questionCon.listQuestion.length,
                            padding: const EdgeInsets.only(bottom: 10),
                            itemBuilder: (BuildContext context, int index) {
                              var question = questionCon.listQuestion[index];
                              return questionCard(
                                  question.question.toString(), index);
                            },
                          ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    _sendAnswersToParent(); // Mengirim feedback
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Radius tombol
                      ),
                      backgroundColor: const Color.fromRGBO(193, 71, 233, 1)),
                  child: const Text(
                    "Simpan",
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
            ) // Tampilkan loading indicator jika data masih dimuat
              ),
    );
  }

  Widget questionCard(String question, int index) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              question,
              style: const TextStyle(
                fontSize: 15,
                color: Color.fromRGBO(45, 3, 59, 1),
                fontWeight: FontWeight.normal,
                letterSpacing: 0,
              ),
              textAlign: TextAlign.left,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
            _buildAnswerOptions(index),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerOptions(int questionIndex) {
    List<String> answerOptions = [
      'Sangat Baik',
      'Baik',
      'Cukup',
      'Kurang Baik',
      'Buruk'
    ];
    List<String> answerKeys = ['A', 'B', 'C', 'D', 'E'];
    return Column(
      children: List.generate(answerOptions.length, (index) {
        return RadioListTile<String>(
          title: Text(
            answerOptions[index],
            style: const TextStyle(
              fontSize: 15,
              color: Color.fromRGBO(45, 3, 59, 1),
              fontWeight: FontWeight.normal,
              letterSpacing: 0,
            ),
          ),
          value: answerKeys[index],
          groupValue: questionCon.selectedAnswers[questionIndex],
          onChanged: (value) {
            setState(() {
              questionCon.selectedAnswers[questionIndex] = value!;
            });
          },
          visualDensity: const VisualDensity(
              horizontal: -4.0,
              vertical: -4.0), // Menambahkan visualDensity yang lebih rapat
          contentPadding: const EdgeInsets.symmetric(vertical: -4.0),
        );
      }),
    );
  }
}
