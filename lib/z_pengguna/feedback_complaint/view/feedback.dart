import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:outsourcing/components/text_widget.dart';
import 'package:outsourcing/z_pengguna/feedback_complaint/controller/feedback_controller.dart';

class FeedbackBWidget extends StatefulWidget {
  const FeedbackBWidget({super.key});

  @override
  State<FeedbackBWidget> createState() => _FeedbackBWidgetState();
}

class _FeedbackBWidgetState extends State<FeedbackBWidget> {
  var animate = false;
  var opacity = 0.0;
  bool position = false;
  late Size size;
  var feedbackCon = Get.put(FeedbackBController());
  bool isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      animator();
    });
    _loadData();
  }

  // Fungsi untuk memuat data
  void _loadData() async {
    await _refreshData();
    await feedbackCon.getFeedback();
    setState(() {
      isDataLoaded = true;
    });
  }

  // Function to handle refreshing
  Future<void> _refreshData() async {
    await feedbackCon.getFeedback();
    setState(() {});
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
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: isDataLoaded
          ? Container(
              color: Colors.white,
              height: size.height,
              width: size.width,
              child: Stack(
                children: [
                  AnimatedPositioned(
                    top: position ? 1 : 50,
                    left: 0,
                    right: 0,
                    duration: const Duration(milliseconds: 400),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 400),
                      opacity: opacity,
                      child: SizedBox(
                          height: 550,
                          width: MediaQuery.of(context).size.width,
                          child: Obx(
                            () => feedbackCon.isLoading.value
                                ? const SpinKitWanderingCubes(
                                    color: Colors.deepPurple,
                                    size: 50.0,
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: feedbackCon.listFeedback.length,
                                    padding: const EdgeInsets.only(bottom: 10),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var feedback =
                                          feedbackCon.listFeedback[index];
                                      return feedbacklistCard(
                                        feedback.transactionId!.toInt(),
                                        feedback.review!.toInt(),
                                        feedback.comment.toString(),
                                      );
                                    },
                                  ),
                          )),
                    ),
                  ),
                ],
              ),
            )
          : const Center(
              child: SpinKitWanderingCubes(
              color: Colors.deepPurple,
              size: 50.0,
            ) // Tampilkan loading indicator jika data masih dimuat
              ),
    );
  }

  Widget feedbacklistCard(int orderid, int review, String comment) {
    return Card(
      color: Colors.white,
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
                'Feedback',
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
                'Order $orderid',
                15,
                const Color.fromRGBO(45, 3, 59, 1),
                FontWeight.bold,
                letterSpace: 0,
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 5,
              ),
              RatingBar.builder(
                initialRating: review.toDouble(),
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemSize: 25,
                itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {},
                ignoreGestures: true, // Disable user interaction
              ),
              const SizedBox(
                height: 5,
              ),
              TextWidget(
                comment,
                16,
                const Color.fromRGBO(45, 3, 59, 1),
                FontWeight.normal,
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
