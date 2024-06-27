import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outsourcing/model/complaints_model.dart';
import 'package:outsourcing/service/complaint_service.dart';
import 'package:outsourcing/z_supervisor/respon_complaint/widget/responsedialog_widget.dart';

class ResponseBController extends GetxController implements GetxService {
  var listComplaint = <ComplaintModel>[].obs;
  final complaint = ComplaintService();
  var isLoading = false.obs;

  Future<void> getComplaint() async {
    isLoading.value = true;
    var response = await complaint.getComplaint();
    var responsedecode = jsonDecode(response.body);
    listComplaint.clear();
    for (var i = 0; i < responsedecode['datas'].length; i++) {
      ComplaintModel data = ComplaintModel.fromJson(responsedecode['datas'][i]);
      listComplaint.add(data);
    }
    isLoading.value = false;
  }

  void navigateToDetails(
    BuildContext context,
    int id,
    String namapemesan,
    String namakaryawan,
    String comment,
    String reply,
  ) {
    if (reply == "") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ResponseDialogWidget(
            id: id,
            namapemesan: namapemesan,
            namakaryawan: namakaryawan,
            comment: comment,
            reply: reply,
          );
        },
      );
    } else {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Info',
          message:
              'Terimakasih atas responnya, terus berikan pelayanan terbaik untuk pengguna!',
          contentType: ContentType.help,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }
}
