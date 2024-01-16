import 'package:flutter/material.dart';
import 'package:outsourcing/file/list.dart';
import 'package:outsourcing/z_karyawan/dashboard/view/detail_penempatank.dart';

class PenempatanKController {
  final List<OrderItem> orderList = [
    OrderItem(karsuv[0], tanggal[0], alamat[0], status[0], harga[0], colors[2]),
    OrderItem(karsuv[1], tanggal[1], alamat[1], status[1], harga[1], colors[3]),
    OrderItem(karsuv[2], tanggal[2], alamat[2], status[2], harga[2], colors[2]),
    OrderItem(karsuv[3], tanggal[3], alamat[3], status[3], harga[3], colors[1]),
    OrderItem(karsuv[4], tanggal[0], alamat[0], status[0], harga[4], colors[2]),
    OrderItem(karsuv[5], tanggal[1], alamat[1], status[1], harga[5], colors[3]),
    OrderItem(karsuv[5], tanggal[1], alamat[1], status[4], harga[5], colors[0]),
    OrderItem(karsuv[5], tanggal[1], alamat[1], status[1], harga[5], colors[3]),
  ];

  late String selectedStatus;

  PenempatanKController() {
    selectedStatus = 'Semua';
  }

  void navigateToDetails(BuildContext context, String karsuv, String tanggal,
      String alamat, String status, String harga, Color colors) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPenempatanK(
            karsuv: karsuv,
            tanggal: tanggal,
            alamat: alamat,
            status: status,
            harga: harga,
            colors: colors),
      ),
    );
  }
}

class OrderItem {
  final String karsuv;
  final String tanggal;
  final String alamat;
  final String status;
  final String harga;
  final Color colors;

  OrderItem(this.karsuv, this.tanggal, this.alamat, this.status, this.harga,
      this.colors);
}
