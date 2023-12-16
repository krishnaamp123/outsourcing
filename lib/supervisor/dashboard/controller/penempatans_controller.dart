import 'package:flutter/material.dart';
import 'package:outsourcing/file/list.dart';
import 'package:outsourcing/supervisor/dashboard/view/detail_penempatans.dart';

class PenempatanSController {
  final List<OrderItem> orderList = [
    OrderItem(names[0], tanggal[0], alamat[0], status[0], harga[0], colors[2]),
    OrderItem(names[1], tanggal[1], alamat[1], status[1], harga[1], colors[3]),
    OrderItem(names[2], tanggal[2], alamat[2], status[2], harga[2], colors[2]),
    OrderItem(names[3], tanggal[3], alamat[3], status[3], harga[3], colors[1]),
    OrderItem(names[4], tanggal[0], alamat[0], status[0], harga[4], colors[2]),
    OrderItem(names[5], tanggal[1], alamat[1], status[1], harga[5], colors[3]),
    OrderItem(names[5], tanggal[1], alamat[1], status[4], harga[5], colors[0]),
    OrderItem(names[5], tanggal[1], alamat[1], status[1], harga[5], colors[3]),
  ];

  late String selectedStatus;

  PenempatanSController() {
    selectedStatus = 'Semua';
  }

  void navigateToDetails(BuildContext context, String name, String tanggal,
      String alamat, String status, String harga, Color colors) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPenempatanS(
            name: name,
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
  final String name;
  final String tanggal;
  final String alamat;
  final String status;
  final String harga;
  final Color colors;

  OrderItem(this.name, this.tanggal, this.alamat, this.status, this.harga,
      this.colors);
}
