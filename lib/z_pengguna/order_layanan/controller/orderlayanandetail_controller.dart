import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outsourcing/model/order_model.dart';
import 'package:outsourcing/service/order_service.dart';

class OrderLayananDetailController extends GetxController
    implements GetxService {
  var postOrder = OrderModel().obs;
  final service = OrderService();
  var isLoading = false.obs;

  Future<void> PostOrder({
    required String alamat,
    required String hari,
    required DateTime selectedDate,
    required String selectedPayment,
  }) async {
    isLoading.value = true;

    postOrder.value.address = alamat;
    postOrder.value.contractDuration = hari as int?;
    postOrder.value.startDate = selectedDate.toIso8601String();
    postOrder.value.paymentType = selectedPayment;

    List<OrderDetails> details = [];

    OrderDetails orderDetail1 = OrderDetails(
      partialServiceId: 1,
      orderDetailItems: [
        OrderDetailItems(partialServiceItemId: 1, value: 1),
      ],
    );

    OrderDetails orderDetail2 = OrderDetails(partialServiceId: 2);

    details.add(orderDetail1);
    details.add(orderDetail2);

    postOrder.value.orderDetails = details;

    var response = await service.postOrder(postOrder.value);
    var responsedecode = jsonDecode(response.body);

    if (response.statusCode == 200) {
      Get.back();
      Get.snackbar(
        'Create Berhasil',
        "Data berhasil ditambah",
        colorText: Colors.white,
        backgroundColor: Colors.lightBlue,
      );
      // resetForm();
    } else {
      Get.snackbar(
        'Create Gagal',
        "Data gagal ditambah, mohon periksa kembali",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
    isLoading.value = false;

    // Get.back();
  }
}
