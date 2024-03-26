import 'package:flutter/material.dart';
import 'package:outsourcing/components/text_widget.dart';
import 'package:outsourcing/file/coba.dart';

class ResponseWidget extends StatefulWidget {
  const ResponseWidget({super.key});

  @override
  State<ResponseWidget> createState() => _ResponseWidgetState();
}

class _ResponseWidgetState extends State<ResponseWidget> {
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
    return Container(
      color: Colors.white,
      height: size.height,
      width: size.width,
      child: Stack(
        children: [
          AnimatedPositioned(
            top: position ? 1 : 50,
            left: 20,
            right: 20,
            duration: const Duration(milliseconds: 400),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              opacity: opacity,
              child: SizedBox(
                height: 530,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      complaintResponse(complaint[0], response[0]),
                      complaintResponse(complaint[1], response[1]),
                      complaintResponse(complaint[2], response[2]),
                      complaintResponse(complaint[2], response[2]),
                      complaintResponse(complaint[2], response[2]),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget complaintResponse(String complaint, String response) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextWidget(
                'Complaint',
                15,
                Color.fromRGBO(129, 12, 168, 1),
                FontWeight.normal,
                letterSpace: 0,
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 5,
              ),
              TextWidget(
                complaint,
                15,
                const Color.fromRGBO(45, 3, 59, 1),
                FontWeight.bold,
                letterSpace: 0,
                textAlign: TextAlign.left,
              ),
              Divider(
                height: 10,
                thickness: 1,
                color: Colors.black.withOpacity(0.2),
              ),
              const TextWidget(
                'Response',
                15,
                Color.fromRGBO(129, 12, 168, 1),
                FontWeight.normal,
                letterSpace: 0,
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 5,
              ),
              TextWidget(
                response,
                15,
                const Color.fromRGBO(45, 3, 59, 1),
                FontWeight.bold,
                letterSpace: 0,
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
