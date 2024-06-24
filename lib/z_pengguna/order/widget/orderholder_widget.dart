import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:outsourcing/components/text_widget.dart';
import 'package:outsourcing/z_pengguna/order/widget/statusdropdown_widget.dart';

import '../controller/order_controller.dart';

class OrderHolderWidget extends StatefulWidget {
  const OrderHolderWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderHolderWidget> createState() => _OrderHolderWidgetState();
}

class _OrderHolderWidgetState extends State<OrderHolderWidget> {
  // final OrderController orderController = OrderController();
  var orderCon = Get.put(OrderControllerApi());
  bool isDataLoaded = false;
  // bool _isLoading = true; // Tambahkan variabel isLoading

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Fungsi untuk memuat data
  void _loadData() async {
    await _refreshData();
    orderCon.filterOrdersByStatus('Semua');
    await orderCon.getOrderLayanan(); // Tunggu hingga data selesai dimuat
    setState(() {
      isDataLoaded = true; // Setelah data dimuat, ubah status menjadi true
    });
  }

  // Function to handle refreshing
  Future<void> _refreshData() async {
    orderCon.filterOrdersByStatus('Semua');
    await orderCon.getOrderLayanan();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: isDataLoaded
          ? Column(
              children: [
                StatusDropdown(
                  statusList: const [
                    'Semua',
                    'waiting_for_confirmation',
                    'waiting_for_mou',
                    'waiting_for_mou_confirmation',
                    'waiting_for_initial_payment',
                    'waiting_for_placement',
                    'confirmed',
                    'ongoing',
                    'waiting_for_further_payment',
                    'suspended',
                    'done',
                  ],
                  onFilterChanged: (selected) {
                    setState(() {
                      orderCon.filterOrdersByStatus(selected);
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
                  child: Obx(
                    () => orderCon.isLoading.value
                        ? const SpinKitWanderingCubes(
                            color: Colors.deepPurple,
                            size: 50.0,
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: orderCon.filteredOrderList.length,
                            itemBuilder: (BuildContext context, int index) {
                              // final order = orderController.filteredOrderList[index];
                              var order = orderCon.filteredOrderList[index];
                              return orderlist(
                                order.id.toString(),
                                order.companyName.toString(),
                                order.startDate.toString(),
                                order.orderDate.toString(),
                                order.address.toString(),
                                order.details!.first.totalEmployee.toString(),
                                order.contractDuration.toString(),
                                order.status.toString(),
                                order.totalPrice.toString(),
                                order.totalPaid.toString(),
                                order.paymentMethod.toString(),
                                order.nextPaymentDeadline.toString(),
                              );
                            },
                          ),
                  ),
                ),
              ],
            )
          : const Center(
              child: SpinKitWanderingCubes(
              color: Colors.deepPurple,
              size: 50.0,
            ) // Tampilkan loading indicator jika data masih dimuat
              ),
    );
  }

  Widget orderlist(
    String id,
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
    // Parse tanggal menjadi objek DateTime
    DateTime parsedDate = DateTime.parse(tanggal);

    // Format tanggal sesuai keinginan (hanya hari, bulan, dan tahun)
    String formattedDate = DateFormat('dd-MM-yyyy').format(parsedDate);

    // Tentukan warna untuk setiap status
    Color statusColor = _getStatusColor(status);
    return GestureDetector(
      onTap: () {
        orderCon.navigateToDetails(
            context,
            id,
            namapesanan,
            tanggal,
            tanggalorder,
            alamat,
            jumlahkaryawan,
            lamakontrak,
            status,
            harga,
            hargaterbayar,
            metodebayar,
            deadlinebayar);
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
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      'Order $id',
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
                      formattedDate,
                      15,
                      Colors.black.withOpacity(.6),
                      FontWeight.bold,
                      letterSpace: 0,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      alamat,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black.withOpacity(.6),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0,
                      ),
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    TextWidget(
                      status,
                      15,
                      statusColor,
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

  Color _getStatusColor(String status) {
    switch (status) {
      case 'waiting_for_mou':
        return Colors.orange;
      case 'waiting_for_initial_payment':
        return Colors.orange;
      case 'waiting_for_further_payment':
        return Colors.orange;
      case 'waiting_for_confirmation':
        return Colors.orange;
      case 'waiting_for_mou_confirmation':
        return Colors.orange;
      case 'ongoing':
        return Colors.green;
      case 'done':
        return Colors.blue;
      case 'confirmed':
        return Colors.blue;
      case 'suspended':
        return Colors.red;
      default:
        return const Color.fromRGBO(45, 3, 59, 1);
    }
  }
}
