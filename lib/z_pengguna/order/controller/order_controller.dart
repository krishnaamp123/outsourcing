import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outsourcing/core.dart';
import 'package:outsourcing/model/order_model.dart';
import 'package:outsourcing/z_pengguna/order/view/ordermou.dart';
import 'package:outsourcing/z_pengguna/order/view/orderpenilaian.dart';
import 'package:outsourcing/service/order_service.dart';

class OrderControllerApi extends GetxController implements GetxService {
  var listOrder = <OrderModel>[].obs;
  final service = OrderService();
  var isLoading = false.obs;

  Future<void> getOrder() async {
    isLoading.value = true;
    var response = await service.getOrder();
    var responsedecode = jsonDecode(response.body);

    if (responsedecode['payload'] != null &&
        responsedecode['payload']['datas'] != null) {
      listOrder.clear();
      for (var i = 0; i < responsedecode['payload']['datas'].length; i++) {
        OrderModel data =
            OrderModel.fromJson(responsedecode['payload']['datas'][i]);
        listOrder.add(data);
      }
    }

    isLoading.value = false;
  }

  RxList<OrderModel> filteredOrderList = <OrderModel>[].obs;

  void filterOrdersByStatus(String status) {
    if (status == 'Semua') {
      filteredOrderList.assignAll(listOrder);
    } else {
      filteredOrderList.assignAll(
          listOrder.where((order) => order.status == status).toList());
    }
  }

  void navigateToDetails(BuildContext context, String name, String tanggal,
      String alamat, String status, String harga) {
    if (status == 'waiting_mou') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderMOU(
            name: name,
            tanggal: tanggal,
            alamat: alamat,
            status: status,
            harga: harga,
          ),
        ),
      );
    } else if (status == 'waiting_for_payment') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderBayar(
            name: name,
            tanggal: tanggal,
            alamat: alamat,
            status: status,
            harga: harga,
          ),
        ),
      );
    } else if (status == "ongoing") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderPenilaian(
            name: name,
            tanggal: tanggal,
            alamat: alamat,
            status: status,
            harga: harga,
          ),
        ),
      );
    } else if (status == "completed") {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Info',
          message:
              'Terimakasih sudah memesan layanan kami, kontrak pemesanan anda sudah berakhir',
          contentType: ContentType.help,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    } else if (status == "cancelled") {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Info',
          message:
              'Terimakasih sudah memesan layanan kami, kontrak pemesanan anda harus kami batalkan',
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Info',
          message:
              'Mohon untuk menunggu, verifikasi data sedang dilakukan oleh admin!',
          contentType: ContentType.warning,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }
}

  // void filterOrdersByStatus(BuildContext context, String status) {
  //   if (status == 'Semua') {
  //     filteredOrderList.assignAll(listOrder);
  //   } else if (status == 'waiting_for_confirmation') {
  //     var selectedOrder =
  //         listOrder.firstWhere((order) => order.status == status);
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => OrderBayar(
  //           name: selectedOrder.id.toString(),
  //           harga: selectedOrder.totalPrice.toString(),
  //           alamat: selectedOrder.address.toString(),
  //           tanggal: selectedOrder.date.toString(),
  //           status: selectedOrder.status.toString(),
  //         ),
  //       ),
  //     );
  //   }
  //   // else if (status == 'waiting_mou') {
  //   //   // Navigasi ke halaman yang sesuai
  //   //   Get.to(NamaHalaman2());
  //   // }
  //   // else {
  //   //   final snackBar = SnackBar(
  //   //     elevation: 0,
  //   //     behavior: SnackBarBehavior.floating,
  //   //     backgroundColor: Colors.transparent,
  //   //     content: AwesomeSnackbarContent(
  //   //       title: 'Info',
  //   //       message:
  //   //           'Terimakasih sudah memesan layanan kami, kontrak pemesanan anda sudah berakhir',
  //   //       contentType: ContentType.help,
  //   //     ),
  //   //   );

  //   //   ScaffoldMessenger.of(context)
  //   //     ..hideCurrentSnackBar()
  //   //     ..showSnackBar(snackBar);
  //   // }
  // }