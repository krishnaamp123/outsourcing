import 'dart:convert';

import 'package:get/get.dart';
import 'package:outsourcing/model/order_model.dart';
import 'package:outsourcing/service/order_service.dart';

class OrderControllerApi extends GetxController implements GetxService {
  var listOrder = <OrderModel>[].obs;
  final service = OrderService();
  var isLoading = false.obs;

  Future<void> getOrder() async {
    isLoading.value = true;
    var response = await service.getOrder();
    var responsedecode = jsonDecode(response.body);
    listOrder.clear();
    for (var i = 0; i < responsedecode['payload']['datas'].length; i++) {
      OrderModel data =
          OrderModel.fromJson(responsedecode['payload']['datas'][i]);
      listOrder.add(data);
    }
    isLoading.value = false;
  }
}
