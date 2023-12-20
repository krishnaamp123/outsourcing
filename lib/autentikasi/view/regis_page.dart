import 'package:flutter/material.dart';
import 'package:outsourcing/autentikasi/controller/regis_controller.dart';
import 'package:outsourcing/autentikasi/widget/my_button.dart';
import 'package:outsourcing/autentikasi/widget/my_textfield.dart';

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

  //sign user in method
  void signUserUp() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  Image.asset(
                    'lib/images/logo.png',
                    height: 200,
                    width: 200,
                  ),

                  //welcome back, you've been missed!
                  Text(
                    'Ayo Buat Akun Kamu!',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 10),

                  //fullname textfield
                  MyTextField(
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

                  const SizedBox(height: 5),

                  //email textfield
                  MyTextField(
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
                  const SizedBox(height: 5),

                  //password textfield
                  MyTextField(
                    controller: regisController.passwordController,
                    hintText: 'Password',
                    obscureText: true,
                    validator: regisController
                        .validatePassword, // Set validator dari controller
                    onChanged: (_) {
                      setState(() {
                        regisController.passwordError = null;
                      });
                    },
                  ),
                  const SizedBox(height: 5),

                  //alamar textfield
                  MyTextField(
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
                  const SizedBox(height: 5),

                  //nik textfield
                  MyTextField(
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
                  const SizedBox(height: 5),

                  //telpon textfield
                  MyTextField(
                    controller: regisController.telponController,
                    hintText: 'No Telpon',
                    obscureText: true,
                    validator: regisController
                        .validateTelpon, // Set validator dari controller
                    onChanged: (_) {
                      setState(() {
                        regisController.telponError = null;
                      });
                    },
                  ),

                  const SizedBox(height: 10),

                  //sign in button
                  MyButton(
                    text: "Daftar",
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        regisController.handleSignin(context);
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  // divider
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // login now
                  Row(
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
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
