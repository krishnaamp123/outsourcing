import 'package:flutter/material.dart';
import 'package:outsourcing/view/order_paketlayanan/widget/paketlayanan_widget.dart';

class ServiceListWidget extends StatelessWidget {
  final bool position;
  final double opacity;
  final List<String> names;
  final List<String> desc;

  const ServiceListWidget({
    Key? key,
    required this.position,
    required this.opacity,
    required this.names,
    required this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      top: position ? 380 : 480,
      left: 20,
      right: 20,
      duration: const Duration(milliseconds: 400),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 400),
        opacity: opacity,
        child: SizedBox(
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                PaketLayananWidget(
                  name: names[1],
                  desc: desc[1],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
