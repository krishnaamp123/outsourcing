import 'package:flutter/material.dart';
import 'package:outsourcing/pengguna/feedback_complaint/view/complaint.dart';
import 'package:outsourcing/pengguna/feedback_complaint/view/feedback.dart';
import 'package:outsourcing/pengguna/feedback_complaint/view/response.dart';
import 'package:outsourcing/pengguna/feedback_complaint/widget/titlefc_widget.dart';

class FeedbackComplaint extends StatefulWidget {
  final String username;
  const FeedbackComplaint({Key? key, required this.username}) : super(key: key);

  @override
  State<FeedbackComplaint> createState() => _FeedbackComplaintState();
}

class _FeedbackComplaintState extends State<FeedbackComplaint> {
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 30, left: 0, right: 0),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                top: position ? 1 : 50,
                left: 20,
                right: 20,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: TitleFCWidget(
                    animator: animator,
                    context: context,
                    labelText: 'Feedback & Complaint',
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                top: position ? 50 : 100,
                left: 20,
                right: 20,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: SizedBox(
                    height: 620,
                    width: MediaQuery.of(context).size.width,
                    child: const Column(
                      children: [
                        TabBar(
                          tabs: [
                            Tab(
                              icon: Icon(Icons.feedback_rounded,
                                  color: Color.fromRGBO(45, 3, 59, 1),
                                  size: 28),
                              text: "Feedback",
                            ),
                            Tab(
                              icon: Icon(Icons.warning,
                                  color: Color.fromRGBO(45, 3, 59, 1),
                                  size: 28),
                              text: "Complaint",
                            ),
                            Tab(
                              icon: Icon(Icons.question_answer_outlined,
                                  color: Color.fromRGBO(45, 3, 59, 1),
                                  size: 28),
                              text: "Response",
                            ),
                          ],
                          labelColor: Color.fromRGBO(45, 3, 59, 1),
                          unselectedLabelColor: Color.fromRGBO(45, 3, 59, 1),
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          unselectedLabelStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              FeedbackWidget(),
                              ComplaintWidget(),
                              ResponseWidget(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
