import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';
import 'package:outsourcing/components/text_widget.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;
import 'package:outsourcing/global.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class ButtonPembayaran extends StatefulWidget {
  final String transactionId;

  const ButtonPembayaran({super.key, required this.transactionId});

  @override
  State<ButtonPembayaran> createState() => _ButtonPembayaranState();
}

class _ButtonPembayaranState extends State<ButtonPembayaran> {
  MidtransSDK? _midtrans;

  @override
  void initState() {
    super.initState();
    _initSDK();
  }

  Future<void> _initSDK() async {
    await dot_env.dotenv.load();
    print('Loading environment variables...');
    try {
      final clientKey = dot_env.dotenv.env['MIDTRANS_CLIENT_KEY'] ?? "";
      print('Client Key: $clientKey');
      final midtrans = await MidtransSDK.init(
        config: MidtransConfig(
          clientKey: clientKey,
          merchantBaseUrl: dot_env.dotenv.env['BASE_URL'] ??
              "", // Pastikan ini diisi dengan URL merchant Anda
          colorTheme: ColorTheme(
            colorPrimary: Colors.blue,
            colorPrimaryDark: Colors.blue,
            colorSecondary: Colors.blue,
          ),
        ),
      );
      midtrans.setUIKitCustomSetting(skipCustomerDetailsPages: true);
      midtrans.setTransactionFinishedCallback((result) {
        print('Transaction Completed: $result');
        _showToast('Transaction Completed', false);
      });
      setState(() {
        _midtrans = midtrans;
      });
      print('Midtrans SDK initialized successfully');
    } catch (e) {
      print('Failed to initialize Midtrans SDK: $e');
      _showToast('Failed to initialize Midtrans SDK: $e', true);
    }
  }

  Future<Map<String, dynamic>> getTokenNew() async {
    final uuid = Uuid();
    final orderId = '${widget.transactionId}_${uuid.v4()}';
    final url =
        Uri.parse(baseURL + '/transactions/${widget.transactionId}/pay/');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'order_id': orderId,
        // Tambahkan body request jika diperlukan
      }),
    );
    print('Response from backend: ${response.body}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      final errorData = jsonDecode(response.body);
      final errorMessage = errorData['message'] ?? 'Failed to create payment';
      throw Exception(errorMessage);
    }
  }

  void _showToast(String msg, bool isError) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: isError ? Colors.red : Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<void> _startPayment() async {
    if (_midtrans == null) {
      _showToast('Midtrans SDK is not initialized', true);
      return;
    }
    try {
      final result = await getTokenNew();
      print('Token result: $result'); // Log token result
      if (result.containsKey('data') &&
          result['data'].containsKey('midtrans_token')) {
        final midtransToken = result['data']['midtrans_token'];
        print('Starting payment with token: $midtransToken'); // Log token
        try {
          _midtrans?.startPaymentUiFlow(token: midtransToken);
        } catch (e) {
          print('Midtrans SDK startPaymentUiFlow Error: $e');
          _showToast(
              'Midtrans SDK startPaymentUiFlow Error: ${e.toString()}', true);
        }
      } else {
        throw Exception('Invalid token response');
      }
    } catch (e) {
      print('Error: $e');
      _showToast('Transaction Failed: ${e.toString()}', true);
    }
  }

  @override
  void dispose() {
    _midtrans?.removeTransactionFinishedCallback();
    super.dispose();
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
                    onPressed: () {
                      // Fungsi untuk mengunggah file PDF
                    },
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
                      shadowColor: Colors.purple, // Warna teks
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
                    onPressed: _startPayment,
                    label: const Text('E-Wallet',
                        style: TextStyle(
                          color: Color.fromRGBO(193, 71, 233, 1),
                        )),
                    icon: const Icon(
                      Icons.payment_rounded,
                      color: Color.fromRGBO(193, 71, 233, 1),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shadowColor: Colors.purple, // Warna teks
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
                      // Fungsi untuk mengunggah file PDF
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
                      shadowColor: Colors.purple, // Warna teks
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
