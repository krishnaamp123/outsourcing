import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:midtrans_sdk/midtrans_sdk.dart';
import 'package:outsourcing/components/text_widget.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:outsourcing/service/token_service.dart';

class ButtonPembayaran extends StatefulWidget {
  const ButtonPembayaran({super.key});

  @override
  State<ButtonPembayaran> createState() => _ButtonPembayaranState();
}

class _ButtonPembayaranState extends State<ButtonPembayaran> {
  // MidtransSDK? _midtrans;

  // @override
  // void initState() {
  //   super.initState();
  //   _initSDK();
  // }

  // Future<void> _initSDK() async {
  //   await dotenv.load();
  //   try {
  //     final midtrans = await MidtransSDK.init(
  //       config: MidtransConfig(
  //         clientKey: dotenv.env['MIDTRANS_CLIENT_KEY'] ?? "",
  //         merchantBaseUrl: "",
  //         colorTheme: ColorTheme(
  //           colorPrimary: Colors.blue,
  //           colorPrimaryDark: Colors.blue,
  //           colorSecondary: Colors.blue,
  //         ),
  //       ),
  //     );
  //     midtrans.setUIKitCustomSetting(skipCustomerDetailsPages: true);
  //     midtrans.setTransactionFinishedCallback((result) {
  //       _showToast('Transaction Completed', false);
  //     });
  //     setState(() {
  //       _midtrans = midtrans;
  //     });
  //   } catch (e) {
  //     _showToast('Failed to initialize Midtrans SDK', true);
  //   }
  // }

  // void _showToast(String msg, bool isError) {
  //   Fluttertoast.showToast(
  //       msg: msg,
  //       toastLength: Toast.LENGTH_LONG,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: isError ? Colors.red : Colors.green,
  //       textColor: Colors.white,
  //       fontSize: 16.0);
  // }

  // Future<void> _startPayment() async {
  //   if (_midtrans == null) {
  //     _showToast('Midtrans SDK is not initialized', true);
  //     return;
  //   }
  //   try {
  //     final result = await TokenService().getToken();
  //     if (result.containsKey('data') &&
  //         result['data'].containsKey('midtrans_token')) {
  //       final midtransToken = result['data']['midtrans_token'];
  //       _midtrans?.startPaymentUiFlow(token: midtransToken);
  //     } else {
  //       throw Exception('Invalid token response');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     _showToast('Transaction Failed: ${e.toString()}', true);
  //   }
  // }

  // @override
  // void dispose() {
  //   _midtrans?.removeTransactionFinishedCallback();
  //   super.dispose();
  // }

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
                  // ElevatedButton.icon(
                  //   onPressed: _startPayment,
                  //   label: const Text('E-Wallet',
                  //       style: TextStyle(
                  //         color: Color.fromRGBO(193, 71, 233, 1),
                  //       )),
                  //   icon: const Icon(
                  //     Icons.payment_rounded,
                  //     color: Color.fromRGBO(193, 71, 233, 1),
                  //   ),
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Colors.white,
                  //     shadowColor: Colors.purple, // Warna teks
                  //     minimumSize: const Size(240, 40),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //   ),
                  // ),
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
