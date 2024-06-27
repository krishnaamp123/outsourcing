import 'dart:convert';

import 'package:get/get.dart';
import 'package:outsourcing/model/complaints_model.dart';
import 'package:outsourcing/service/complaint_service.dart';

class ComplaintBController extends GetxController implements GetxService {
  var listComplaint = <ComplaintModel>[].obs;
  final complaint = ComplaintService();
  var isLoading = false.obs;

  Future<void> getComplaint() async {
    isLoading.value = true;
    var response = await complaint.getComplaint();
    var responsedecode = jsonDecode(response.body);
    listComplaint.clear();
    for (var i = 0; i < responsedecode['datas'].length; i++) {
      ComplaintModel data = ComplaintModel.fromJson(responsedecode['datas'][i]);
      listComplaint.add(data);
    }
    isLoading.value = false;
  }
}
