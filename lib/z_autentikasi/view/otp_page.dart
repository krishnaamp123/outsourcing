import 'package:flutter/material.dart';
import 'package:outsourcing/z_autentikasi/controller/otp_controller.dart';
import 'package:outsourcing/z_autentikasi/widget/my_button.dart';

class OTPPage extends StatefulWidget {
  final Function()? onTap;
  const OTPPage({super.key, this.onTap});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final _formKey = GlobalKey<FormState>();
  final OTPController otpController = OTPController();
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
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 60),
            height: size.height,
            width: size.width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  top: position ? 150 : 200,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: Center(
                      child: Image.asset(
                        'lib/images/emailverif.jpg',
                        height: 200,
                        width: 300,
                      ),
                    ),
                  ),
                ),

                //welcome back, you've been missed!
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  top: position ? 340 : 390,
                  left: 20,
                  right: 20,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: Column(
                      children: [
                        const Center(
                          child: Text(
                            'Verifikasi Akun',
                            style: TextStyle(
                              color: Color.fromRGBO(129, 12, 168, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Center(
                          child: Text(
                            'Selesaikan Verifikasi Melalui Email',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //sign in button
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  top: position ? 420 : 530,
                  left: 0,
                  right: 0,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: MyButton(
                      text: "Login Sekarang",
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          otpController.loginNow(context);
                        }
                      },
                    ),
                  ),
                ),

                // or continue with
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  top: position ? 470 : 580,
                  left: 0,
                  right: 0,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                ),

                // not a member? register now
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  top: position ? 490 : 605,
                  left: 20,
                  right: 20,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Tidak Menerima Email?',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            otpController.checkEmail(context);
                          },
                          child: const Text(
                            'Periksa Kembali Email Anda',
                            style: TextStyle(
                              color: Color.fromRGBO(129, 12, 168, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
