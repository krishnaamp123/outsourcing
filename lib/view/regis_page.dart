import 'package:flutter/material.dart';
import 'package:outsourcing/components/my_button.dart';
import 'package:outsourcing/components/my_textfield.dart';
import 'package:outsourcing/components/square_tile.dart';
import 'package:outsourcing/view/login_page.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  //text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final cpasswordController = TextEditingController();
  String? _usernameError;
  String? _passwordError;
  String? _cpasswordError;

  //sign user in method
  void signUserUp() {}

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
                  'Ayo Buat Akun Kamu!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 10),

                //username textfield
                MyTextField(
                  controller: usernameController,
                  hintText: 'Email',
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan username';
                    }
                    return null;
                  },
                  onChanged: (_) {
                    setState(() {
                      _usernameError = null;
                    });
                  },
                ),
                _usernameError != null
                    ? Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Text(
                          _usernameError!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      )
                    : SizedBox(),

                const SizedBox(height: 5),

                //password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan password';
                    }
                    return null;
                  },
                  onChanged: (_) {
                    setState(() {
                      _passwordError = null;
                    });
                  },
                ),
                _passwordError != null
                    ? Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Text(
                          _passwordError!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      )
                    : SizedBox(),

                const SizedBox(height: 5),

                //confirm password textfield
                MyTextField(
                  controller: cpasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan password';
                    }
                    return null;
                  },
                  onChanged: (_) {
                    setState(() {
                      _cpasswordError = null;
                    });
                  },
                ),
                _cpasswordError != null
                    ? Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Text(
                          _cpasswordError!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      )
                    : SizedBox(),

                const SizedBox(height: 10),

                //sign in button
                MyButton(
                  text: "Daftar",
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      String username = usernameController.text;
                      String password = passwordController.text;
                      String cpassword = cpasswordController.text;
                      // Cek kembali apakah bidang input kosong sebelum navigasi
                      if (username.isEmpty) {
                        setState(() {
                          _usernameError = 'Masukkan username';
                          _passwordError = null;
                          _cpasswordError = null;
                        });
                      } else if (password.isEmpty) {
                        setState(() {
                          _passwordError = 'Masukkan password';
                          _cpasswordError = null;
                          _usernameError = null;
                        });
                      } else if (cpassword.isEmpty) {
                        setState(() {
                          _cpasswordError = 'Masukkan password';
                          _passwordError = null;
                          _usernameError = null;
                        });
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      }
                    } else {
                      setState(() {
                        _usernameError = usernameController.text.isEmpty
                            ? 'Masukkan username'
                            : null;
                        _passwordError = passwordController.text.isEmpty
                            ? 'Masukkan password'
                            : null;
                      });
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //google button
                    SquareTile(imagePath: 'lib/images/google icon.png'),
                  ],
                ),

                const SizedBox(height: 20),

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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
