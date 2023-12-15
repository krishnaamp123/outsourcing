import 'package:flutter/material.dart';
import 'package:outsourcing/components/text_widget.dart';
import 'package:outsourcing/file/list.dart';
import 'package:outsourcing/pengguna/order/view/orderdetail.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:outsourcing/pengguna/order/widget/statusdropdown_widget.dart';

class OrderHolderWidget extends StatefulWidget {
  const OrderHolderWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderHolderWidget> createState() => _OrderHolderWidgetState();
}

class _OrderHolderWidgetState extends State<OrderHolderWidget> {
  List<OrderItem> orderList = [
    OrderItem(names[0], tanggal[0], alamat[0], status[0], harga[0], colors[2]),
    OrderItem(names[1], tanggal[1], alamat[1], status[1], harga[1], colors[3]),
    OrderItem(names[2], tanggal[2], alamat[2], status[2], harga[2], colors[2]),
    OrderItem(names[3], tanggal[3], alamat[3], status[3], harga[3], colors[1]),
    OrderItem(names[4], tanggal[0], alamat[0], status[0], harga[4], colors[2]),
    OrderItem(names[5], tanggal[1], alamat[1], status[1], harga[5], colors[3]),
    OrderItem(names[5], tanggal[1], alamat[1], status[4], harga[5], colors[0]),
    OrderItem(names[5], tanggal[1], alamat[1], status[1], harga[5], colors[3]),
  ];

  List<OrderItem> filteredOrderList = [];
  String selectedStatus = 'Semua';
  @override
  void initState() {
    super.initState();
    filteredOrderList = List.from(orderList);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      StatusDropdown(
        statusList: const [
          'Semua',
          'Menunggu Verifikasi MOU',
          'Lakukan Pembayaran',
          'Menunggu Verifikasi Pembayaran',
          'Sedang Berjalan',
          'Sudah Berakhir'
        ],
        onFilterChanged: (selected) {
          setState(() {
            selectedStatus = selected;
            filterOrdersByStatus();
          });
        },
      ),
      Divider(
        height: 15,
        thickness: 2,
        color: Colors.black.withOpacity(0.2),
      ),
      SizedBox(
        height: 520,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: filteredOrderList.length,
          itemBuilder: (BuildContext context, int index) {
            return orderlist(
              filteredOrderList[index].name,
              filteredOrderList[index].tanggal,
              filteredOrderList[index].alamat,
              filteredOrderList[index].status,
              filteredOrderList[index].harga,
              filteredOrderList[index].colors,
            );
          },
        ),
      ),
    ]);
  }

  void filterOrdersByStatus() {
    if (selectedStatus == 'Semua') {
      filteredOrderList = List.from(orderList);
    } else {
      filteredOrderList =
          orderList.where((item) => item.status == selectedStatus).toList();
    }
  }

  Widget orderlist(String name, String tanggal, String alamat, String status,
      String harga, Color colors) {
    return GestureDetector(
      onTap: () {
        _navigateToDetails(
            context, name, tanggal, alamat, status, harga, colors);
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox(
          height: 100,
          width: double.infinity,
          child: Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    name,
                    18,
                    const Color.fromRGBO(45, 3, 59, 1),
                    FontWeight.bold,
                    letterSpace: 0,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextWidget(
                    tanggal,
                    15,
                    Colors.black.withOpacity(.6),
                    FontWeight.bold,
                    letterSpace: 0,
                    textAlign: TextAlign.left,
                  ),
                  TextWidget(
                    alamat,
                    15,
                    Colors.black.withOpacity(.6),
                    FontWeight.bold,
                    letterSpace: 0,
                    textAlign: TextAlign.left,
                  ),
                  TextWidget(
                    status,
                    15,
                    colors,
                    FontWeight.bold,
                    letterSpace: 0,
                    textAlign: TextAlign.left,
                  ),
                  TextWidget(
                    harga,
                    0,
                    const Color.fromRGBO(45, 3, 59, 1),
                    FontWeight.bold,
                    letterSpace: 0,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToDetails(BuildContext context, String name, String tanggal,
      String alamat, String status, String harga, Color colors) {
    if (status == "Lakukan Pembayaran") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderDetail(
              name: name,
              tanggal: tanggal,
              alamat: alamat,
              status: status,
              harga: harga,
              colors: colors),
        ),
      );
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
