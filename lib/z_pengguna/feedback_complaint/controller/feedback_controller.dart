import 'dart:convert';

import 'package:get/get.dart';
import 'package:outsourcing/model/feedbacks_model.dart';
import 'package:outsourcing/service/feedback_service.dart';

class FeedbackBController extends GetxController implements GetxService {
  var listFeedback = <FeedbackModel>[].obs;
  final feedback = FeedbackService();
  var isLoading = false.obs;

  Future<void> getFeedback() async {
    isLoading.value = true;
    var response = await feedback.getFeedback();
    var responsedecode = jsonDecode(response.body);
    listFeedback.clear();
    for (var i = 0; i < responsedecode['datas'].length; i++) {
      FeedbackModel data = FeedbackModel.fromJson(responsedecode['datas'][i]);
      listFeedback.add(data);
    }
    isLoading.value = false;
  }
}
