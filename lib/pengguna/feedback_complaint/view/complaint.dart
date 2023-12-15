import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:outsourcing/pengguna/feedback_complaint/widget/buttonkirimfc.dart';
import 'package:outsourcing/pengguna/feedback_complaint/widget/dropdownfc_widget.dart';
import 'package:outsourcing/pengguna/feedback_complaint/widget/dropdownkfc.dart';
import 'package:outsourcing/pengguna/feedback_complaint/widget/textfieldfc_widget.dart';

class ComplaintWidget extends StatefulWidget {
  const ComplaintWidget({super.key});

  @override
  State<ComplaintWidget> createState() => _ComplaintWidgetState();
}

class _ComplaintWidgetState extends State<ComplaintWidget> {
  final _formKey = GlobalKey<FormState>();
  //text editing controllers
  final complaintController = TextEditingController();
  String? _complaintError;
  // int? jumlahCleaner = 1;
  var animate = false;
  var opacity = 0.0;
  bool position = false;
  late Size size;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      animator();
    });
  }

  animator() {
    if (opacity == 1) {
      opacity = 0;
      animate = true;
      position = false;
    } else {
      opacity = 1;
      animate = false;
      position = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          color: Colors.white,
          height: size.height,
          width: size.width,
          child: Stack(children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              top: position ? 50 : 100,
              left: 20,
              right: 20,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: opacity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const DropdownFC(
                        items: [
                          'Order 1',
                          'Order 2',
                          'Order 3'
                        ], // Sesuaikan dengan list item yang sesuai di sini
                      ),
                      const SizedBox(height: 10),
                      const DropdownKFC(
                        items: [
                          'Karyawan 1',
                          'Karyawan 2',
                          'Karyawan 3'
                        ], // Sesuaikan dengan list item yang sesuai di sini
                      ),
                      const SizedBox(height: 10),
                      TextFieldFC(
                        controller: complaintController,
                        upText: 'Complaint',
                        hintText: 'ex: Karyawan menghilang...',
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Masukkan feedback';
                          }
                          return null;
                        },
                        onChanged: (_) {
                          setState(() {
                            _complaintError = null;
                          });
                        },
                      ),
                      _complaintError != null
                          ? Container(
                              alignment: Alignment.bottomLeft,
                              padding: const EdgeInsets.only(left: 30.0),
                              child: Text(
                                _complaintError!,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(height: 20),
                      ButtonKirim(onTap: () {
                        if (_formKey.currentState!.validate()) {
                          String complaint = complaintController.text;
                          if (complaint.isEmpty) {
                            setState(() {
                              _complaintError = 'Masukkan complaint';
                            });
                          } else {
                            final snackBar = SnackBar(
                              elevation: 0,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              content: AwesomeSnackbarContent(
                                title: 'Info',
                                message:
                                    'Mohon maaf atas ketidaknyamanannya, admin akan merespon sesegera mungkin',
                                contentType: ContentType.help,
                              ),
                            );
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(snackBar);
                          }
                        } else {
                          setState(() {
                            _complaintError = complaintController.text.isEmpty
                                ? 'Masukkan complaint'
                                : null;
                          });
                        }
                      }),
                    ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
