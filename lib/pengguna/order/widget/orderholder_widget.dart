import 'package:flutter/material.dart';
import 'package:outsourcing/components/text_widget.dart';
import 'package:outsourcing/pengguna/order/controller/order_controller.dart';
import 'package:outsourcing/pengguna/order/widget/statusdropdown_widget.dart';

class OrderHolderWidget extends StatefulWidget {
  const OrderHolderWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderHolderWidget> createState() => _OrderHolderWidgetState();
}

class _OrderHolderWidgetState extends State<OrderHolderWidget> {
  final OrderController orderController = OrderController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StatusDropdown(
          statusList: const [
            'Semua',
            'Unggah MOU Pesanan',
            'Menunggu Verifikasi MOU',
            'Lakukan Pembayaran',
            'Menunggu Verifikasi Pembayaran',
            'Sedang Berjalan',
            'Sudah Berakhir'
          ],
          onFilterChanged: (selected) {
            setState(() {
              orderController.filterOrdersByStatus(selected);
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
            itemCount: orderController.filteredOrderList.length,
            itemBuilder: (BuildContext context, int index) {
              final order = orderController.filteredOrderList[index];
              return orderlist(
                order.name,
                order.tanggal,
                order.alamat,
                order.status,
                order.harga,
                order.colors,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget orderlist(String name, String tanggal, String alamat, String status,
      String harga, Color colors) {
    return GestureDetector(
      onTap: () {
        orderController.navigateToDetails(
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
}
