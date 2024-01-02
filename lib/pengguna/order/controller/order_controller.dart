// import 'package:flutter/material.dart';
// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:outsourcing/file/list.dart';
// import 'package:outsourcing/pengguna/order/view/orderbayar.dart';
// import 'package:outsourcing/pengguna/order/view/ordermou.dart';
// import 'package:outsourcing/pengguna/order/view/orderpenilaian.dart';

// class OrderController {
//   final List<OrderItem> orderList = [
//     OrderItem(names[0], tanggal[0], alamat[0], status[0], harga[0], colors[2]),
//     OrderItem(names[1], tanggal[1], alamat[1], status[1], harga[1], colors[3]),
//     OrderItem(names[2], tanggal[2], alamat[2], status[2], harga[2], colors[2]),
//     OrderItem(names[3], tanggal[3], alamat[3], status[3], harga[3], colors[1]),
//     OrderItem(names[4], tanggal[0], alamat[0], status[0], harga[4], colors[2]),
//     OrderItem(names[5], tanggal[1], alamat[1], status[1], harga[5], colors[3]),
//     OrderItem(names[5], tanggal[1], alamat[1], status[4], harga[5], colors[0]),
//     OrderItem(names[5], tanggal[1], alamat[1], status[5], harga[5], colors[3]),
//   ];

//   late List<OrderItem> filteredOrderList;
//   late String selectedStatus;

//   OrderController() {
//     filteredOrderList = List.from(orderList);
//     selectedStatus = 'Semua';
//   }

//   void filterOrdersByStatus(String selected) {
//     selectedStatus = selected;
//     if (selectedStatus == 'Semua') {
//       filteredOrderList = List.from(orderList);
//     } else {
//       filteredOrderList =
//           orderList.where((item) => item.status == selectedStatus).toList();
//     }
//   }

//   // void navigateToDetails(BuildContext context, String name, String tanggal,
//   //     String alamat, String status, String harga) {
//   //   if (status == "Lakukan Pembayaran") {
//   //     Navigator.push(
//   //       context,
//   //       MaterialPageRoute(
//   //         builder: (context) => OrderBayar(
//   //           name: name,
//   //           tanggal: tanggal,
//   //           alamat: alamat,
//   //           status: status,
//   //           harga: harga,
//   //         ),
//   //       ),
//   //     );
//   //   } else if (status == "Unggah MOU Pesanan") {
//   //     Navigator.push(
//   //       context,
//   //       MaterialPageRoute(
//   //         builder: (context) => OrderMOU(
//   //           name: name,
//   //           tanggal: tanggal,
//   //           alamat: alamat,
//   //           status: status,
//   //           harga: harga,
//   //         ),
//   //       ),
//   //     );
//   //   } else if (status == "Sedang Berjalan") {
//   //     Navigator.push(
//   //       context,
//   //       MaterialPageRoute(
//   //         builder: (context) => OrderPenilaian(
//   //           name: name,
//   //           tanggal: tanggal,
//   //           alamat: alamat,
//   //           status: status,
//   //           harga: harga,
//   //         ),
//   //       ),
//   //     );
//   //   } else if (status == "Sudah Berakhir") {
//   //     final snackBar = SnackBar(
//   //       elevation: 0,
//   //       behavior: SnackBarBehavior.floating,
//   //       backgroundColor: Colors.transparent,
//   //       content: AwesomeSnackbarContent(
//   //         title: 'Info',
//   //         message:
//   //             'Terimakasih sudah memesan layanan kami, kontrak pemesanan anda sudah berakhir',
//   //         contentType: ContentType.help,
//   //       ),
//   //     );

//   //     ScaffoldMessenger.of(context)
//   //       ..hideCurrentSnackBar()
//   //       ..showSnackBar(snackBar);
//   //   } else {
//   //     // Navigator.push(
//   //     //   context,
//   //     //   MaterialPageRoute(
//   //     //     builder: (context) => OrderPenilaian(
//   //     //       name: name,
//   //     //       tanggal: tanggal,
//   //     //       alamat: alamat,
//   //     //       status: status,
//   //     //       harga: harga,
//   //     //     ),
//   //     //   ),
//   //     // );

//   //     // Navigator.push(
//   //     //   context,
//   //     //   MaterialPageRoute(
//   //     //     builder: (context) => OrderMOU(
//   //     //       name: name,
//   //     //       tanggal: tanggal,
//   //     //       alamat: alamat,
//   //     //       status: status,
//   //     //       harga: harga,
//   //     //     ),
//   //     //   ),
//   //     // );

//   //     // Navigator.push(
//   //     //   context,
//   //     //   MaterialPageRoute(
//   //     //     builder: (context) => OrderBayar(
//   //     //       name: name,
//   //     //       tanggal: tanggal,
//   //     //       alamat: alamat,
//   //     //       status: status,
//   //     //       harga: harga,
//   //     //     ),
//   //     //   ),
//   //     // );

//   //     final snackBar = SnackBar(
//   //       elevation: 0,
//   //       behavior: SnackBarBehavior.floating,
//   //       backgroundColor: Colors.transparent,
//   //       content: AwesomeSnackbarContent(
//   //         title: 'Info',
//   //         message:
//   //             'Mohon untuk menunggu, verifikasi data sedang dilakukan oleh admin!',
//   //         contentType: ContentType.warning,
//   //       ),
//   //     );

//   //     ScaffoldMessenger.of(context)
//   //       ..hideCurrentSnackBar()
//   //       ..showSnackBar(snackBar);
//   //   }
//   // }
// }

// class OrderItem {
//   final String name;
//   final String tanggal;
//   final String alamat;
//   final String status;
//   final String harga;
//   final Color colors;

//   OrderItem(this.name, this.tanggal, this.alamat, this.status, this.harga,
//       this.colors);
// }
