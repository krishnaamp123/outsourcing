import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outsourcing/model/order_model.dart';
import 'package:outsourcing/service/order_service.dart';

class OrderPaketController extends GetxController implements GetxService {
  var postOrderPaket = OrderModel().obs;
  final service = OrderService();
  var isLoading = false.obs;

  Future<void> PostOrderPaket({
    required int? serviceuserid,
    required String billingname,
    required int? idregency,
    required String billingaddress,
    required String namapesanan,
    required String alamat,
    required String hari,
    required DateTime selectedDate,
    required String selectedPayment,
    required String idpaket,
  }) async {
    isLoading.value = true;

    postOrderPaket.value.serviceUserId = serviceuserid;
    postOrderPaket.value.billingName = billingname;
    postOrderPaket.value.regencyId = idregency;
    postOrderPaket.value.billingAddress = billingaddress;
    postOrderPaket.value.companyName = namapesanan;
    postOrderPaket.value.address = alamat;
    postOrderPaket.value.contractDuration = int.tryParse(hari);
    postOrderPaket.value.startDate = selectedDate.toUtc().toIso8601String();
    postOrderPaket.value.paymentMethod = selectedPayment;
    postOrderPaket.value.packageId = int.tryParse(idpaket);

    try {
      var response = await service.postOrder(postOrderPaket.value);

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
