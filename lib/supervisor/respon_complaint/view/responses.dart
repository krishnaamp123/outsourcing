import 'package:flutter/material.dart';
import 'package:outsourcing/supervisor/respon_complaint/controller/responses_controller.dart';
import 'package:outsourcing/supervisor/respon_complaint/widget/buttonkirimrc.dart';
import 'package:outsourcing/supervisor/respon_complaint/widget/dropdowncrc.dart';
import 'package:outsourcing/supervisor/respon_complaint/widget/dropdownrc_widget.dart';
import 'package:outsourcing/supervisor/respon_complaint/widget/textfieldrc_widget.dart';

class ResponseSWidget extends StatefulWidget {
  const ResponseSWidget({super.key});

  @override
  State<ResponseSWidget> createState() => _ResponseSWidgetState();
}

class _ResponseSWidgetState extends State<ResponseSWidget> {
  final _formKey = GlobalKey<FormState>();
  //text editing controllers
  final responsesController = ResponseSController();
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
                      const DropdownRC(
                        items: [
                          'Order 1',
                          'Order 2',
                          'Order 3'
                        ], // Sesuaikan dengan list item yang sesuai di sini
                      ),
                      const SizedBox(height: 10),
                      const DropdownCRC(
                        items: [
                          'Complaint 1',
                          'Complaint 2',
                          'Complaint 3'
                        ], // Sesuaikan dengan list item yang sesuai di sini
                      ),
                      const SizedBox(height: 10),
                      TextFieldRC(
                        controller: responsesController.responsetextController,
                        upText: 'Response',
                        hintText: 'ex: Mohon Maaf...',
                        obscureText: false,
                        validator: responsesController.validateResponse,
                        onChanged: (_) {
                          setState(() {
                            responsesController.responsesError = null;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      ButtonKirimRC(onTap: () {
                        if (_formKey.currentState!.validate()) {
                          responsesController.onKirimPressed(context);
                        } else {
                          setState(() {
                            responsesController.responsesError =
                                responsesController
                                        .responsetextController.text.isEmpty
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
