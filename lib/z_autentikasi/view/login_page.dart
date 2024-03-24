import 'package:flutter/material.dart';
import 'package:outsourcing/z_autentikasi/widget/my_button.dart';
import 'package:outsourcing/z_autentikasi/widget/my_textfield.dart';
import 'package:outsourcing/z_autentikasi/widget/pass_textfield.dart';
import '../controller/login_controller.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final LoginController loginController = LoginController();
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
                  top: position ? 80 : 130,
                  left: 90,
                  right: 90,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: Center(
                      child: Image.asset(
                        'lib/images/logo.png',
                        height: 200,
                        width: 200,
                      ),
                    ),
                  ),
                ),

                //welcome back, you've been missed!
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  top: position ? 280 : 330,
                  left: 20,
                  right: 20,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: Center(
                      child: Text(
                        'Selamat Datang Di OutsourcingApp!',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),

                //username textfield
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  top: position ? 310 : 360,
                  left: 0,
                  right: 0,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: MyTextField(
                      controller: loginController.emailController,
                      hintText: 'Email',
                      obscureText: false,
                      validator: loginController
                          .validateEmail, // Set validator dari controller
                      onChanged: (_) {
                        setState(() {
                          loginController.emailError = null;
                        });
                      },
                    ),
                  ),
                ),

                //password textfield
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  top: position ? 375 : 425,
                  left: 0,
                  right: 0,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: PassTextField(
                      controller: loginController.passwordController,
                      hintText: 'Password',
                      validator: loginController
                          .validatePassword, // Set validator dari controller
                      onChanged: (_) {
                        setState(() {
                          loginController.passwordError = null;
                        });
                      },
                    ),
                  ),
                ),

                //forgot password?
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  top: position ? 440 : 490,
                  left: 0,
                  right: 0,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Lupa Password?',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //sign in button
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  top: position ? 480 : 530,
                  left: 0,
                  right: 0,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: MyButton(
                      text: "Masuk",
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          loginController.handleLogin(context);
                        }
                      },
                    ),
                  ),
                ),

                // or continue with
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  top: position ? 530 : 580,
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
                  top: position ? 555 : 605,
                  left: 20,
                  right: 20,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Belum Punya Akun?',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            loginController.navigateToRegister(context);
                          },
                          child: const Text(
                            'Daftar Sekarang',
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
