import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outsourcing/model/order_model.dart';
import 'package:outsourcing/model/orderlayanan_model.dart';
import 'package:outsourcing/service/order_service.dart';
import 'package:outsourcing/service/orderlayanan_service.dart';

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
    required List<int> idservice,
  }) async {
    isLoading.value = true;
    postOrder.value.address = alamat;
    postOrder.value.contractDuration = int.tryParse(hari);
    postOrder.value.startDate = selectedDate.toUtc().toIso8601String();
    postOrder.value.paymentType = selectedPayment;

    List<OrderDetails> details = [];

    // OrderDetails orderDetail1 = OrderDetails(
    //   partialServiceId: postOrder.value.serviceUserId,
    //   orderDetailItems: [
    //     OrderDetailItems(partialServiceItemId: 1, value: 1),
    //   ],
    // );
    for (int id in idservice) {
      OrderDetails orderDetail2 = OrderDetails(
        partialServiceId: id,
      );
      details.add(orderDetail2);
    }

    // details.add(orderDetail1);

    postOrder.value.orderDetails = details;

    var response = await service.postOrder(postOrder.value);

    if (response != null) {
      var responsedecode = jsonDecode(response.body);
      if (response.statusCode == 201) {
        Get.snackbar(
          'Info',
          'Mohon maaf pemesanan gagal, cek kembali data yang belum Anda inputkan!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.transparent,
          colorText: Colors.black,
          duration: const Duration(seconds: 3),
          borderRadius: 0,
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          messageText: const Text(
            'Mohon maaf pemesanan gagal, cek kembali data yang belum Anda inputkan!',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        );
      } else {
        Get.snackbar(
          'Info',
          'Mohon maaf pemesanan gagal, cek kembali data yang belum Anda inputkan!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.transparent,
          colorText: Colors.black,
          duration: const Duration(seconds: 3),
          borderRadius: 0,
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          messageText: const Text(
            'Mohon maaf pemesanan gagal, cek kembali data yang belum Anda inputkan!',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        );
      }
    } else {
      Get.snackbar(
        'Info',
        'Mohon maaf pemesanan gagal, cek kembali data yang belum Anda inputkan!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.transparent,
        colorText: Colors.black,
        duration: Duration(seconds: 3),
        borderRadius: 0,
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        messageText: Text(
          'Mohon maaf pemesanan gagal, cek kembali data yang belum Anda inputkan!',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      );
    }
    isLoading.value = false;

    // Get.back();
  }
}

// class OrderLayananDetailController extends GetxController
//     implements GetxService {
//   var postOrder = Layanan().obs;
//   final service = OrderService();
//   var isLoading = false.obs;

//   Future<void> PostOrder({
//     required String alamat,
//     required String hari,
//     required DateTime selectedDate,
//     required String selectedPayment,
//     required List<int> idservice,
//   }) async {
//     isLoading.value = true;

//     postOrder.value.address = alamat;
//     postOrder.value.contractDuration = int.tryParse(hari);
//     postOrder.value.startDate = selectedDate.toUtc().toIso8601String();
//     postOrder.value.paymentType = selectedPayment;

//     List<OrderDetails> details = [];

//     // OrderDetails orderDetail1 = OrderDetails(
//     //   partialServiceId: postOrder.value.serviceUserId,
//     //   orderDetailItems: [
//     //     OrderDetailItems(partialServiceItemId: 1, value: 1),
//     //   ],
//     // );
//     for (int id in idservice) {
//       OrderDetails orderDetail2 = OrderDetails(
//         partialServiceId: id,
//       );
//       details.add(orderDetail2);
//     }

//     // details.add(orderDetail1);

//     postOrder.value.orderDetails = details;

//     var response = await service.postOrder(postOrder.value);

//     if (response != null) {
//       var responsedecode = jsonDecode(response.body);
//       if (response.statusCode == 201) {
//         Get.snackbar(
//           'Info',
//           'Mohon maaf pemesanan gagal, cek kembali data yang belum Anda inputkan!',
//           snackPosition: SnackPosition.TOP,
//           backgroundColor: Colors.transparent,
//           colorText: Colors.black,
//           duration: const Duration(seconds: 3),
//           borderRadius: 0,
//           margin: EdgeInsets.zero,
//           padding: EdgeInsets.zero,
//           messageText: const Text(
//             'Mohon maaf pemesanan gagal, cek kembali data yang belum Anda inputkan!',
//             style: TextStyle(
//               color: Colors.black,
//             ),
//           ),
//         );
//       } else {
//         Get.snackbar(
//           'Info',
//           'Mohon maaf pemesanan gagal, cek kembali data yang belum Anda inputkan!',
//           snackPosition: SnackPosition.TOP,
//           backgroundColor: Colors.transparent,
//           colorText: Colors.black,
//           duration: const Duration(seconds: 3),
//           borderRadius: 0,
//           margin: EdgeInsets.zero,
//           padding: EdgeInsets.zero,
//           messageText: const Text(
//             'Mohon maaf pemesanan gagal, cek kembali data yang belum Anda inputkan!',
//             style: TextStyle(
//               color: Colors.black,
//             ),
//           ),
//         );
//       }
//     } else {
//       Get.snackbar(
//         'Info',
//         'Mohon maaf pemesanan gagal, cek kembali data yang belum Anda inputkan!',
//         snackPosition: SnackPosition.TOP,
//         backgroundColor: Colors.transparent,
//         colorText: Colors.black,
//         duration: Duration(seconds: 3),
//         borderRadius: 0,
//         margin: EdgeInsets.zero,
//         padding: EdgeInsets.zero,
//         messageText: Text(
//           'Mohon maaf pemesanan gagal, cek kembali data yang belum Anda inputkan!',
//           style: TextStyle(
//             color: Colors.black,
//           ),
//         ),
//       );
//     }
//     isLoading.value = false;

//     // Get.back();
//   }
// }
