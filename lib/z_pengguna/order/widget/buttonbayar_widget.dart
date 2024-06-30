import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:outsourcing/CookieClient.dart';
import 'package:outsourcing/components/text_widget.dart';
import 'package:outsourcing/global.dart';
import 'package:outsourcing/service/token.dart';
import 'package:uuid/uuid.dart';
import 'package:url_launcher/url_launcher.dart';

class ButtonBayar extends StatefulWidget {
  final String transactionId;

  const ButtonBayar({super.key, required this.transactionId});

  @override
  State<ButtonBayar> createState() => _ButtonBayarState();
}

class _ButtonBayarState extends State<ButtonBayar> {
  Future<void> _payWithBankTransfer(BuildContext context) async {
    var token = await getToken();
    if (token.isEmpty) {
      throw Exception('Token is missing');
    }

    final uuid = Uuid();
    final orderId = '${widget.transactionId}_${uuid.v4()}';
    final url =
        Uri.parse(baseURL + '/transactions/${widget.transactionId}/pay/');
    var cj = CookieJar();
    var uri = Uri.parse(baseURL);

    await cj.saveFromResponse(uri, [Cookie('session', token)]);
    var cookies = await cj.loadForRequest(uri);
    print('Cookies: $cookies');

    var client = http.Client();
    client = CookieClient(client, cookieJar: cj);

    try {
      http.Response response = await client.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'order_id': orderId,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final midtransToken = data['data']['midtrans_token'];
        final redirectUrl = data['data']['redirect_url'];

        print('Midtrans Token: $midtransToken');
        print('Redirect URL: $redirectUrl');

        Fluttertoast.showToast(
          msg: "Payment created, redirecting...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        final uri = Uri.parse(redirectUrl);
        if (await canLaunchUrl(uri)) {
          final bool launched = await launchUrl(
            uri,
            mode: LaunchMode.inAppWebView,
          );

          if (!launched) {
            throw 'Could not launch $redirectUrl';
          }
        } else {
          throw 'Could not launch $redirectUrl';
        }
      } else {
        final errorData = jsonDecode(response.body);
        final errorMessage = errorData['message'] ?? 'Failed to create payment';
        throw Exception(errorMessage);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error: ${e.toString()}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print('Exception: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TextWidget(
                    "Pilih Metode Pembayaran",
                    20,
                    Color.fromRGBO(45, 3, 59, 1),
                    FontWeight.bold,
                    letterSpace: 0,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextWidget(
                    "Tentukan pembayaran anda\nPilih metode yang cocok untuk anda",
                    15,
                    Colors.black.withOpacity(0.6),
                    FontWeight.bold,
                    letterSpace: 0,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _payWithBankTransfer(context),
                    label: const Text('Transfer Bank',
                        style: TextStyle(
                          color: Color.fromRGBO(193, 71, 233, 1),
                        )),
                    icon: const Icon(
                      Icons.compare_arrows_rounded,
                      color: Color.fromRGBO(193, 71, 233, 1),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shadowColor: Colors.purple,
                      minimumSize: const Size(240, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      final snackBar = SnackBar(
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Info',
                          message:
                              'Pembayaran offline dapat dilakukan di office, maps : Outsourcing Bali',
                          contentType: ContentType.help,
                        ),
                      );

                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                      Future.delayed(const Duration(seconds: 0), () {
                        Navigator.of(context).pop();
                      });
                    },
                    label: const Text('Offline',
                        style: TextStyle(
                          color: Color.fromRGBO(193, 71, 233, 1),
                        )),
                    icon: const Icon(
                      Icons.attach_money,
                      color: Color.fromRGBO(193, 71, 233, 1),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shadowColor: Colors.purple,
                      minimumSize: const Size(240, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(240, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: const Color.fromRGBO(193, 71, 233, 1),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 70),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: TextWidget(
            "Pembayaran",
            16,
            Colors.white,
            FontWeight.bold,
            letterSpace: 0,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
