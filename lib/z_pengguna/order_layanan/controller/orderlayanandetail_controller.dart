import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outsourcing/model/order_model.dart';
import 'package:outsourcing/service/orderl_service.dart';

class OrderLayananDetailController extends GetxController
    implements GetxService {
  var postOrderLayanan = OrderModel().obs;
  final service = OrderService();
  var isLoading = false.obs;

  Future<void> PostOrderLayanan({
    required int? serviceuserid,
    required String billingname,
    required int? idregency,
    required String billingaddress,
    required String namapesanan,
    required String alamat,
    required String hari,
    required DateTime selectedDate,
    required String selectedPayment,
    required List<int> idlayanan,
    required String idserviceril,
  }) async {
    isLoading.value = true;

    postOrderLayanan.value.serviceUserId = serviceuserid;
    postOrderLayanan.value.billingName = billingname;
    postOrderLayanan.value.regencyId = idregency;
    postOrderLayanan.value.billingAddress = billingaddress;
    postOrderLayanan.value.companyName = namapesanan;
    postOrderLayanan.value.address = alamat;
    postOrderLayanan.value.contractDuration = int.tryParse(hari);
    postOrderLayanan.value.startDate = selectedDate.toUtc().toIso8601String();
    postOrderLayanan.value.paymentMethod = selectedPayment;

    List<Etcs> etcsList = idlayanan.map((id) {
      return Etcs(additionalItemServiceId: id, qty: 10); // Adjust qty as needed
    }).toList();

    Details details = Details(
      serviceId: int.tryParse(idserviceril),
      totalEmployee: 10, // Adjust total_employee as needed
      etcs: etcsList,
    );

    postOrderLayanan.value.details = [details];

    try {
      var response = await service.postOrder(postOrderLayanan.value);

      if (response != null) {
        var responsedecode = jsonDecode(response.body);
        if (response.statusCode == 201) {
          Get.snackbar(
            'Info',
            'Pemesanan berhasil!',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.transparent,
            colorText: Colors.black,
            duration: const Duration(seconds: 3),
            borderRadius: 0,
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            messageText: const Text(
              'Pemesanan berhasil!',
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
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.transparent,
        colorText: Colors.black,
        duration: Duration(seconds: 3),
        borderRadius: 0,
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        messageText: Text(
          'Terjadi kesalahan: ${e.toString()}',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }
}




// class OrderLayananDetailController extends GetxController
//     implements GetxService {
//   var postOrderLayanan = OrderLayananModel().obs;
//   final service = OrderLayananService();
//   var isLoading = false.obs;

//   Future<void> PostOrderLayanan({
//     required String serviceuserid,
//     required String billingname,
//     required String idregency,
//     required String billingaddress,
//     required String alamat,
//     required String hari,
//     required DateTime selectedDate,
//     required String selectedPayment,
//     required List<int> idservice,
//     required String idserviceril,
//   }) async {
//     isLoading.value = true;
//     postOrderLayanan.value.serviceUserId = int.tryParse(serviceuserid);
//     postOrderLayanan.value.billingName = billingname;
//     postOrderLayanan.value.regencyId = int.tryParse(idregency);
//     postOrderLayanan.value.billingAddress = billingaddress;
//     postOrderLayanan.value.address = alamat;
//     postOrderLayanan.value.contractDuration = int.tryParse(hari);
//     postOrderLayanan.value.startDate = selectedDate.toUtc().toIso8601String();
//     postOrderLayanan.value.paymentMethod = selectedPayment;

//     List<Details> details = [];

//     // OrderDetails orderDetail1 = OrderDetails(
//     //   partialServiceId: postOrder.value.serviceUserId,
//     //   orderDetailItems: [
//     //     OrderDetailItems(partialServiceItemId: 1, value: 1),
//     //   ],
//     // );
//     for (int id in idservice) {
//       Details orderDetail2 = Details(
//         serviceId: id,
//       );
//       details.add(orderDetail2);
//     }

//     // details.add(orderDetail1);

//     postOrderLayanan.value.details = details;

//     var response = await service.postOrderLayanan(postOrderLayanan.value);

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
