import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outsourcing/z_pengguna/order_layanan/view/orderlayanandetail.dart';

class OrderLayananController extends GetxController implements GetxService {
  final TextEditingController namapesananController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController hariController = TextEditingController();
  var isLoading = false.obs;

  String? namapesananError;
  String? alamatError;
  String? hariError;

  String? validateNamaPesanan(String? value) {
    if (value == null || value.isEmpty) {
      return 'Masukkan nama pemesanan';
    }
    return null;
  }

  String? validateAlamat(String? value) {
    if (value == null || value.isEmpty) {
      return 'Masukkan alamat';
    }
    return null;
  }

  String? validateHari(String? value) {
    if (value == null || value.isEmpty) {
      return 'Masukkan jumlah hari';
    } else {
      final parsedValue = int.tryParse(value);
      if (parsedValue == null || parsedValue <= 0) {
        return 'Masukkan angka untuk jumlah hari';
      }
      return null;
    }
  }

  bool validateForm() {
    if (namapesananController.text.isEmpty) {
      namapesananError = 'Masukan nama pemesanan';
      alamatError = null;
      hariError = null;
      return false;
    } else if (alamatController.text.isEmpty) {
      namapesananError = null;
      alamatError = 'Masukkan alamat';
      hariError = null;
      return false;
    } else if (hariController.text.isEmpty) {
      namapesananError = null;
      hariError = 'Masukkan jumlah hari';
      alamatError = null;
      return false;
    }
    return true;
  }

  void handleOrderLayanan(
    BuildContext context,
    List<String>? selectedItems,
    List<int>? hargaitem,
    List<int>? idlayanan,
    int jumlahKaryawan,
    String idserviceril,
    String name,
    String image,
    String baseprice,
    String description,
  ) {
    if (validateForm()) {
      navigateToOrderLayananDetail(context, selectedItems, hargaitem, idlayanan,
          jumlahKaryawan, idserviceril, name, image, baseprice, description);
    }
  }

  void navigateToOrderLayananDetail(
    BuildContext context,
    List<String>? selectedItems,
    List<int>? hargaitem,
    List<int>? idlayanan,
    int jumlahKaryawan,
    String idserviceril,
    String name,
    String image,
    String baseprice,
    String description,
  ) {
    String namapesanan = namapesananController.text;
    String alamat = alamatController.text;
    String hari = hariController.text;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderLayananDetail(
          namapesanan: namapesanan,
          alamat: alamat,
          hari: hari,
          idserviceril: idserviceril,
          name: name,
          image: image,
          baseprice: baseprice,
          description: description,
          selectedItems: selectedItems ?? [],
          jumlahKaryawan: jumlahKaryawan,
          hargaitem: hargaitem ?? [],
          idlayanan: idlayanan ?? [],
        ),
      ),
    );
  }
}
