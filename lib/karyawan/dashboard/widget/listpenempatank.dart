import 'package:flutter/material.dart';
import 'package:outsourcing/components/text_widget.dart';
import 'package:outsourcing/karyawan/dashboard/controller/penempatank_controller.dart';

class ListPenempatanKWidget extends StatefulWidget {
  const ListPenempatanKWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ListPenempatanKWidget> createState() => _ListPenempatanKWidgetState();
}

class _ListPenempatanKWidgetState extends State<ListPenempatanKWidget> {
  final PenempatanKController penempatankController = PenempatanKController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 520,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: penempatankController.orderList.length,
        itemBuilder: (BuildContext context, int index) {
          final order = penempatankController.orderList[index];
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
    );
  }

  Widget orderlist(String name, String tanggal, String alamat, String status,
      String harga, Color colors) {
    return GestureDetector(
      onTap: () {
        penempatankController.navigateToDetails(
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
