import 'dart:convert';

import 'package:get/get.dart';
import 'package:outsourcing/buangan/service_model.dart';
import 'package:outsourcing/buangan/service_service.dart';

class ServiceController extends GetxController implements GetxService {
  var listService = <ServiceModel>[].obs;
  final service = ServiceService();
  var isLoading = false.obs;

  Future<void> getService() async {
    isLoading.value = true;
    var response = await service.getService();
    var responsedecode = jsonDecode(response.body);
    listService.clear();
    for (var i = 0; i < responsedecode['payload']['datas'].length; i++) {
      ServiceModel data =
          ServiceModel.fromJson(responsedecode['payload']['datas'][i]);
      listService.add(data);
    }
    isLoading.value = false;
  }
}
