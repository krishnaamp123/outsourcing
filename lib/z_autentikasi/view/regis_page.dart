import 'package:flutter/material.dart';
import 'package:outsourcing/z_autentikasi/controller/regis_controller.dart';
import 'package:outsourcing/z_autentikasi/widget/my_button.dart';
import 'package:outsourcing/z_autentikasi/widget/my_textfield.dart';
import 'package:outsourcing/z_autentikasi/widget/pass_textfield.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  //text editing controllers
  final RegisController regisController = RegisController();
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

  //sign user in method
  void signUserUp() {}

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
            padding: const EdgeInsets.only(top: 0),
            height: size.height,
            width: size.width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  top: position ? 40 : 90,
                  left: 90,
                  right: 90,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: Image.asset(
                      'lib/images/logo.png',
                      height: 200,
                      width: 200,
                    ),
                  ),
                ),

                //welcome back, you've been missed!
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  top: position ? 240 : 290,
                  left: 0,
                  right: 0,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: Center(
                      child: Text(
                        'Ayo Buat Akun Kamu!',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),

                //fullname textfield
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  top: position ? 270 : 320,
                  left: 0,
                  right: 0,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: MyTextField(
                      controller: regisController.usernameController,
                      hintText: 'Nama Lengkap',
                      obscureText: false,
                      validator: regisController
                          .validateUsername, // Set validator dari controller
                      onChanged: (_) {
                        setState(() {
                          regisController.usernameError = null;
                        });
                      },
                    ),
                  ),
                ),

                //email textfield
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  top: position ? 335 : 385,
                  left: 0,
                  right: 0,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: MyTextField(
                      controller: regisController.emailController,
                      hintText: 'Email',
                      obscureText: false,
                      validator: regisController
                          .validateEmail, // Set validator dari controller
                      onChanged: (_) {
                        setState(() {
                          regisController.emailError = null;
                        });
                      },
                    ),
                  ),
                ),

                //password textfield
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  top: position ? 400 : 450,
                  left: 0,
                  right: 0,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: PassTextField(
                      controller: regisController.passwordController,
                      hintText: 'Password',
                      validator: regisController
                          .validatePassword, // Set validator dari controller
                      onChanged: (_) {
                        setState(() {
                          regisController.passwordError = null;
                        });
                      },
                    ),
                  ),
                ),

                //alamar textfield
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  top: position ? 465 : 515,
                  left: 0,
                  right: 0,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: MyTextField(
                      controller: regisController.alamatController,
                      hintText: 'Alamat',
                      obscureText: false,
                      validator: regisController
                          .validateAlamat, // Set validator dari controller
                      onChanged: (_) {
                        setState(() {
                          regisController.alamatError = null;
                        });
                      },
                    ),
                  ),
                ),

                //nik textfield
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  top: position ? 530 : 580,
                  left: 0,
                  right: 0,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: MyTextField(
                      controller: regisController.nikController,
                      hintText: 'No NIK',
                      obscureText: false,
                      validator: regisController
                          .validateNIK, // Set validator dari controller
                      onChanged: (_) {
                        setState(() {
                          regisController.nikError = null;
                        });
                      },
                    ),
                  ),
                ),

                //telpon textfield
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  top: position ? 595 : 645,
                  left: 0,
                  right: 0,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: MyTextField(
                      controller: regisController.telponController,
                      hintText: 'No Telpon',
                      obscureText: false,
                      validator: regisController
                          .validateTelpon, // Set validator dari controller
                      onChanged: (_) {
                        setState(() {
                          regisController.telponError = null;
                        });
                      },
                    ),
                  ),
                ),

                //sign in button
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  top: position ? 670 : 720,
                  left: 0,
                  right: 0,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: MyButton(
                      text: "Daftar",
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          regisController.handleSignin(context);
                        }
                      },
                    ),
                  ),
                ),

                // divider
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  top: position ? 720 : 770,
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

                // login now
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  top: position ? 745 : 795,
                  left: 20,
                  right: 20,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sudah Memiliki Akun?',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            regisController.navigateToLoginPage(context);
                          },
                          child: const Text(
                            'Masuk Sekarang',
                            style: TextStyle(
                              color: Color.fromRGBO(129, 12, 168, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
