import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outsourcing/components/text_widget.dart';
import 'package:outsourcing/pengguna/order/controller/order_controller.dart';
import 'package:outsourcing/pengguna/order/widget/statusdropdown_widget.dart';

import '../controller/order_controllerAPI.dart';

class OrderHolderWidget extends StatefulWidget {
  const OrderHolderWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderHolderWidget> createState() => _OrderHolderWidgetState();
}

class _OrderHolderWidgetState extends State<OrderHolderWidget> {
  final OrderController orderController = OrderController();
  var orderCon = Get.put(OrderControllerApi());
  @override
  void initState() {
    // TODO: implement initState
    orderCon.getOrder();
    super.initState();
  }

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
            itemCount: orderCon.listOrder.length,
            itemBuilder: (BuildContext context, int index) {
              // final order = orderController.filteredOrderList[index];
              var order = orderCon.listOrder[index];
              return orderlist(
                order.id.toString(),
                // order.serviceUser!.fullname.toString(),
                order.date.toString(),
                order.address.toString(),
                order.status.toString(),
                order.totalPrice.toString(),
                // order.colors,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget orderlist(
      String name, String tanggal, String alamat, String status, String harga) {
    return GestureDetector(
        onTap: () {
          orderController.navigateToDetails(
              context, name, tanggal, alamat, status, harga);
        },
        child: Obx(
          () => orderCon.isLoading.value
              ? LinearProgressIndicator(
                  backgroundColor: Colors.grey[300],
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                  minHeight: 1,
                )
              : Card(
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
                              const Color.fromRGBO(45, 3, 59, 1),
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
        ));
  }
}
