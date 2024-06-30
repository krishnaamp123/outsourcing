import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outsourcing/core.dart';
import 'package:outsourcing/model/order_model.dart';
import 'package:outsourcing/service/order_service.dart';
import 'package:outsourcing/z_pengguna/order/view/ordermou.dart';
import 'package:outsourcing/z_pengguna/order/view/orderpenilaian.dart';
import 'package:outsourcing/z_pengguna/order/widget/feedbackdialog_widget.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;

class OrderControllerApi extends GetxController implements GetxService {
  var listOrder = <OrderModel>[].obs;
  final service = OrderService();
  var isLoading = false.obs;

  Future<void> getOrderLayanan() async {
    isLoading.value = true;
    // await dot_env.dotenv.load(fileName: ".env");
    var response = await service.getOrder();
    var responsedecode = jsonDecode(response.body);
    listOrder.clear();
    for (var i = 0; i < responsedecode['datas'].length; i++) {
      OrderModel data = OrderModel.fromJson(responsedecode['datas'][i]);
      listOrder.add(data);
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

  void navigateToDetails(
    BuildContext context,
    int id,
    String namapesanan,
    String tanggal,
    String tanggalorder,
    String alamat,
    String jumlahkaryawan,
    String lamakontrak,
    String status,
    String harga,
    String hargaterbayar,
    String metodebayar,
    String deadlinebayar,
  ) {
    if (status == 'waiting_for_mou') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderMOU(
            id: id,
            namapesanan: namapesanan,
            tanggal: tanggal,
            tanggalorder: tanggalorder,
            alamat: alamat,
            jumlahkaryawan: jumlahkaryawan,
            lamakontrak: lamakontrak,
            status: status,
            harga: harga,
            hargaterbayar: hargaterbayar,
            metodebayar: metodebayar,
            deadlinebayar: deadlinebayar,
          ),
        ),
      );
    } else if (status == 'waiting_for_initial_payment') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderBayar(
            id: id,
            namapesanan: namapesanan,
            tanggal: tanggal,
            tanggalorder: tanggalorder,
            alamat: alamat,
            jumlahkaryawan: jumlahkaryawan,
            lamakontrak: lamakontrak,
            status: status,
            harga: harga,
            hargaterbayar: hargaterbayar,
            metodebayar: metodebayar,
            deadlinebayar: deadlinebayar,
          ),
        ),
      );
    } else if (status == 'waiting_for_further_payment') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderBayar(
            id: id,
            namapesanan: namapesanan,
            tanggal: tanggal,
            tanggalorder: tanggalorder,
            alamat: alamat,
            jumlahkaryawan: jumlahkaryawan,
            lamakontrak: lamakontrak,
            status: status,
            harga: harga,
            hargaterbayar: hargaterbayar,
            metodebayar: metodebayar,
            deadlinebayar: deadlinebayar,
          ),
        ),
      );
    } else if (status == "ongoing") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderPenilaian(
            id: id,
            namapesanan: namapesanan,
            tanggal: tanggal,
            tanggalorder: tanggalorder,
            alamat: alamat,
            jumlahkaryawan: jumlahkaryawan,
            lamakontrak: lamakontrak,
            status: status,
            harga: harga,
            hargaterbayar: hargaterbayar,
            metodebayar: metodebayar,
            deadlinebayar: deadlinebayar,
          ),
        ),
      );
      // } else if (status == "done") {
      //   final snackBar = SnackBar(
      //     elevation: 0,
      //     behavior: SnackBarBehavior.floating,
      //     backgroundColor: Colors.transparent,
      //     content: AwesomeSnackbarContent(
      //       title: 'Info',
      //       message:
      //           'Terimakasih sudah memesan layanan kami, kontrak pemesanan anda sudah berakhir',
      //       contentType: ContentType.help,
      //     ),
      //   );

      //   ScaffoldMessenger.of(context)
      //     ..hideCurrentSnackBar()
      //     ..showSnackBar(snackBar);
    } else if (status == "done") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return FeedbackDialogWidget(
            id: id,
          );
        },
      );
    } else if (status == "suspended") {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Info',
          message:
              'Terimakasih sudah memesan layanan kami, kontrak pemesanan kami batalkan',
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
