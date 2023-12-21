import 'dart:convert';
import 'package:get/get.dart';
import 'package:outsourcing/model/master_model.dart';
import 'package:outsourcing/service/master_service.dart';

class BalitaController extends GetxController implements GetxService {
  var listBalita = <MasterModel>[].obs;
  final service = MasterService();
  var isLoading = false.obs;

  Future<void> ShowMaster() async {
    isLoading.value = true;
    var response = await service.showMyMasters();
    var responsedecode = jsonDecode(response.body);
    listBalita.clear();
    for (var i = 0; i < responsedecode['payload']['datas'].length; i++) {
      MasterModel data = MasterModel.fromJson(responsedecode['data'][i]);
      listBalita.add(data);
    }
    isLoading.value = false;
  }
}
