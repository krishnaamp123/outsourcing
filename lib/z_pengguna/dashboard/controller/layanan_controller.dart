import 'dart:convert';

import 'package:get/get.dart';
import 'package:outsourcing/model/layanan_model.dart';
import 'package:outsourcing/service/layanan_service.dart';

class LayananController extends GetxController implements GetxService {
  var listLayanan = <LayananModel>[].obs;
  final layanan = LayananService();
  var isLoading = false.obs;

  Future<void> getLayanan() async {
    isLoading.value = true;
    var response = await layanan.getLayanan();
    var responsedecode = jsonDecode(response.body);
    listLayanan.clear();
    for (var i = 0; i < responsedecode['datas'].length; i++) {
      LayananModel data = LayananModel.fromJson(responsedecode['datas'][i]);
      listLayanan.add(data);
    }
    isLoading.value = false;
  }
}
