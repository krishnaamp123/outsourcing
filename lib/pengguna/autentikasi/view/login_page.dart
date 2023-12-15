import 'package:flutter/material.dart';
import 'package:outsourcing/pengguna/autentikasi/view/widget/my_button.dart';
import 'package:outsourcing/pengguna/autentikasi/view/widget/my_textfield.dart';
import 'package:outsourcing/pengguna/autentikasi/view/widget/square_tile.dart';
import 'controller/login_controller.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final LoginController loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Image.asset(
                  'lib/images/logo.png',
                  height: 200,
                  width: 200,
                ),

                //welcome back, you've been missed!
                Text(
                  'Selamat Datang Di OutsourcingApp!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 10),

                //username textfield
                MyTextField(
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
                loginController.emailError != null
                    ? Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Text(
                          loginController.emailError!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      )
                    : const SizedBox(),

                const SizedBox(height: 5),

                //password textfield
                MyTextField(
                  controller: loginController.passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  validator: loginController
                      .validatePassword, // Set validator dari controller
                  onChanged: (_) {
                    setState(() {
                      loginController.passwordError = null;
                    });
                  },
                ),
                loginController.passwordError != null
                    ? Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Text(
                          loginController.passwordError!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      )
                    : const SizedBox(),

                const SizedBox(height: 10),

                //forgot password?
                Padding(
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

                const SizedBox(height: 20),

                //sign in button
                MyButton(
                  text: "Masuk",
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      loginController.handleLogin(context);
                    }
                  },
                ),

                const SizedBox(height: 30),

                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Atau Lanjut Dengan',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                //google + facebook sign in buttons
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //google button
                    SquareTile(imagePath: 'lib/images/google icon.png'),
                  ],
                ),

                const SizedBox(height: 20),

                // not a member? register now
                Row(
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
