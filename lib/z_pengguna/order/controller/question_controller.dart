import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outsourcing/model/question_model.dart';
import 'package:outsourcing/service/question_service.dart';

class QuestionController extends GetxController implements GetxService {
  var listQuestion = <QuestionModel>[].obs;
  final questionService = QuestionService();
  var isLoading = false.obs;
  var selectedAnswers = <int, String>{}.obs;
  late String categoryId;

  void setCategoryId(String categoryid) {
    categoryId = categoryid;
    getQuestion();
  }

  Future<void> getQuestion() async {
    isLoading.value = true;
    var response = await questionService.getQuestion(categoryId);
    var responsedecode = jsonDecode(response.body);
    listQuestion.clear();
    for (var i = 0; i < responsedecode['datas'].length; i++) {
      QuestionModel data = QuestionModel.fromJson(responsedecode['datas'][i]);
      listQuestion.add(data);
    }
    isLoading.value = false;
  }

  Future<void> submitAnswers(
      int performanceFormId, int employeeId, BuildContext context) async {
    isLoading.value = true;
    List<Map<String, dynamic>> details = [];
    listQuestion.asMap().forEach((index, question) {
      details.add({
        "placement_detail_employee_id": employeeId,
        "question": question.question,
        "answer": selectedAnswers[index],
      });
    });

    var response =
        await questionService.postPerformance(performanceFormId, details);
    isLoading.value = false;

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
          title: 'Error',
          message: 'Feedback sudah terisi, tidak bisa mengirim ulang.',
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    } else {
      // Show generic error snackbar for other statuses
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Error',
          message: 'Terjadi kesalahan, silakan coba lagi.',
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }
}
