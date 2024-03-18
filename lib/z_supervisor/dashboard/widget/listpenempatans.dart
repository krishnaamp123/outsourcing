import 'package:flutter/material.dart';
import 'package:outsourcing/components/text_widget.dart';
import 'package:outsourcing/z_supervisor/dashboard/controller/penempatans_controller.dart';

class ListPenempatanSWidget extends StatefulWidget {
  const ListPenempatanSWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ListPenempatanSWidget> createState() => _ListPenempatanSWidgetState();
}

class _ListPenempatanSWidgetState extends State<ListPenempatanSWidget> {
  final PenempatanSController penempatansController = PenempatanSController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 520,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.only(bottom: 10),
        itemExtent: 100,
        itemCount: penempatansController.orderList.length,
        itemBuilder: (BuildContext context, int index) {
          final order = penempatansController.orderList[index];
          return orderlist(
            order.karsuv,
            order.tanggal,
            order.alamat,
            order.status,
            order.harga,
            order.colors,
          );
        },
      ),
    );
  }

  Widget orderlist(String karsuv, String tanggal, String alamat, String status,
      String harga, Color colors) {
    return GestureDetector(
      onTap: () {
        penempatansController.navigateToDetails(
            context, karsuv, tanggal, alamat, status, harga, colors);
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
                    karsuv,
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
                    0,
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
