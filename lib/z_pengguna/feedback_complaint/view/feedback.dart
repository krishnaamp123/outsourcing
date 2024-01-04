import 'package:flutter/material.dart';
import 'package:outsourcing/z_pengguna/feedback_complaint/controller/feedback_controller.dart';
import 'package:outsourcing/z_pengguna/feedback_complaint/widget/buttonkirimfc.dart';
import 'package:outsourcing/z_pengguna/feedback_complaint/widget/dropdownfc_widget.dart';
import 'package:outsourcing/z_pengguna/feedback_complaint/widget/textfieldfc_widget.dart';

class FeedbackWidget extends StatefulWidget {
  const FeedbackWidget({super.key});

  @override
  State<FeedbackWidget> createState() => _FeedbackWidgetState();
}

class _FeedbackWidgetState extends State<FeedbackWidget> {
  final _formKey = GlobalKey<FormState>();
  //text editing controllers
  final feedbackController = FeedbackController();
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
                      TextFieldFC(
                        controller: feedbackController.feedbacktextController,
                        upText: 'Feedback',
                        hintText: 'ex: Layanan bagus...',
                        obscureText: false,
                        validator: feedbackController.validateFeedback,
                        onChanged: (_) {
                          setState(() {
                            feedbackController.feedbackError = null;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      ButtonKirim(onTap: () {
                        if (_formKey.currentState!.validate()) {
                          feedbackController.onKirimPressed(context);
                        } else {
                          setState(() {
                            feedbackController.feedbackError =
                                feedbackController
                                        .feedbacktextController.text.isEmpty
                                    ? 'Masukkan feedback'
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
