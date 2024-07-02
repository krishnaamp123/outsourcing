import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outsourcing/z_autentikasi/controller/regis_controller.dart';
import 'package:outsourcing/z_autentikasi/widget/my_button.dart';
import 'package:outsourcing/z_autentikasi/widget/my_textfield.dart';
import 'package:outsourcing/z_autentikasi/widget/pass_textfield.dart';
import 'dart:core';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final RegisController regisController = RegisController();
  final RegisController regisController1 = Get.put(RegisController());
  var animate = false;
  var opacity = 0.0;
  bool position = false;
  late Size size;
  DateTime selectedDate = DateTime.now();
  String _formatDate(DateTime date) {
    return "${date.year}-${date.month}-${date.day}";
  }

  String dateValidationError = "";
  bool isDateSelected = false;
  String? selectedGender;
  List<String> genderOptions = ['l', 'p'];
  bool isDataLoaded = false;
  String? selectedDomisili;
  Map<String, int> domisiliMap = {};
  List<String> domisiliOptions = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      animator();
      regisController1.getRegency();
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
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  top: position ? 230 : 290,
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
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  top: position ? 260 : 320,
                  left: 0,
                  right: 0,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: SizedBox(
                      height: 380,
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            MyTextField(
                              controller: regisController.usernameController,
                              hintText: 'Nama Lengkap',
                              obscureText: false,
                              validator: regisController.validateUsername,
                              onChanged: (_) {
                                setState(() {
                                  regisController.usernameError = null;
                                });
                              },
                            ),
                            const SizedBox(height: 5),
                            MyTextField(
                              controller: regisController.emailController,
                              hintText: 'Email',
                              obscureText: false,
                              validator: regisController.validateEmail,
                              onChanged: (_) {
                                setState(() {
                                  regisController.emailError = null;
                                });
                              },
                            ),
                            const SizedBox(height: 5),
                            PassTextField(
                              controller: regisController.passwordController,
                              hintText: 'Password',
                              validator: regisController.validatePassword,
                              onChanged: (_) {
                                setState(() {
                                  regisController.passwordError = null;
                                });
                              },
                            ),
                            const SizedBox(height: 5),
                            MyTextField(
                              controller: regisController.alamatController,
                              hintText: 'Alamat',
                              obscureText: false,
                              validator: regisController.validateAlamat,
                              onChanged: (_) {
                                setState(() {
                                  regisController.alamatError = null;
                                });
                              },
                            ),
                            const SizedBox(height: 5),
                            MyTextField(
                              controller: regisController.nikController,
                              hintText: 'No NIK',
                              obscureText: false,
                              validator: regisController.validateNIK,
                              onChanged: (_) {
                                setState(() {
                                  regisController.nikError = null;
                                });
                              },
                            ),
                            const SizedBox(height: 5),
                            MyTextField(
                              controller: regisController.telponController,
                              hintText: 'No Telpon',
                              obscureText: false,
                              validator: regisController.validateTelpon,
                              onChanged: (_) {
                                setState(() {
                                  regisController.telponError = null;
                                });
                              },
                            ),
                            const SizedBox(height: 5),
                            MyTextField(
                              controller: regisController.tempatController,
                              hintText: 'Tempat Lahir',
                              obscureText: false,
                              validator: regisController.validateTempat,
                              onChanged: (_) {
                                setState(() {
                                  regisController.tempatError = null;
                                });
                              },
                            ),
                            const SizedBox(height: 5),
                            GestureDetector(
                              onTap: () async {
                                final DateTime? dateTime = await showDatePicker(
                                  context: context,
                                  initialDate: selectedDate,
                                  firstDate: DateTime(1990),
                                  lastDate: DateTime.now(),
                                );
                                if (dateTime != null) {
                                  print("date is sudah terpilih");
                                  setState(() {
                                    selectedDate = dateTime;
                                    isDateSelected = true;
                                    dateValidationError = "";
                                    regisController.selectedDate = selectedDate;
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                  left: 36,
                                  right: 36,
                                  top: 14,
                                  bottom: 14,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        isDateSelected
                                            ? _formatDate(selectedDate)
                                            : "Tanggal Lahir",
                                        style: TextStyle(
                                          color: isDateSelected
                                              ? Colors.black
                                              : const Color.fromARGB(
                                                  255, 80, 80, 80),
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (dateValidationError.isNotEmpty)
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 36.0),
                                  child: Text(
                                    dateValidationError,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            const SizedBox(height: 5),
                            Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 245, 245, 245),
                                  ),
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                    right: 40,
                                    top: 0,
                                    bottom: 0,
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  child: DropdownButton2<String>(
                                    hint: const Text(
                                      "Jenis Kelamin",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color:
                                              Color.fromARGB(255, 80, 80, 80),
                                          fontWeight: FontWeight.normal),
                                    ),
                                    value: selectedGender,
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedGender = newValue;
                                        regisController.selectedGender =
                                            newValue;
                                      });
                                    },
                                    items: genderOptions.map((String option) {
                                      return DropdownMenuItem<String>(
                                        value: option,
                                        child: Text(
                                          option,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),

                            // Domisili
                            GetBuilder<RegisController>(
                              builder: (value) {
                                if (!isDataLoaded &&
                                    value.listRegency.isNotEmpty) {
                                  domisiliMap = {
                                    for (var item in value.listRegency)
                                      item.regency.toString(): item.id!
                                  };
                                  domisiliOptions = domisiliMap.keys.toList();
                                  isDataLoaded = true;
                                }

                                return Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 245, 245, 245),
                                      ),
                                      padding: const EdgeInsets.only(
                                        left: 16,
                                        right: 40,
                                        top: 0,
                                        bottom: 0,
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      child: DropdownButton2<String>(
                                        hint: const Text(
                                          "Domisili",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color.fromARGB(
                                                  255, 80, 80, 80),
                                              fontWeight: FontWeight.normal),
                                        ),
                                        value: selectedDomisili,
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedDomisili = newValue;
                                            regisController.selectedDomisili =
                                                domisiliMap[newValue];
                                          });
                                        },
                                        items: domisiliOptions
                                            .map((String option) {
                                          return DropdownMenuItem<String>(
                                            value: option,
                                            child: Text(
                                              option,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 15),

                            // //sign up button
                            // MyButton(
                            //   text: "Sign Up",
                            //   onTap: () {
                            //     // Validate inputs
                            //     if (_formKey.currentState!.validate() &&
                            //         isDateSelected &&
                            //         selectedGender != null &&
                            //         selectedDomisili != null) {
                            //       regisController.handleSignin(context);
                            //     } else {
                            //       setState(() {
                            //         if (!isDateSelected) {
                            //           dateValidationError =
                            //               "Tanggal lahir harus dipilih";
                            //         }
                            //         if (selectedGender == null) {
                            //           regisController.selectedGender = null;
                            //         }
                            //         if (selectedDomisili == null) {
                            //           regisController.selectedDomisili = null;
                            //         }
                            //       });
                            //     }
                            //   },
                            // ),
                            // const SizedBox(height: 15),

                            // //already have an account? login here
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Text(
                            //       'Sudah punya akun?',
                            //       style: TextStyle(color: Colors.grey[700]),
                            //     ),
                            //     const SizedBox(width: 4),
                            //     GestureDetector(
                            //       onTap: widget.onTap,
                            //       child: const Text(
                            //         'Login sekarang',
                            //         style: TextStyle(
                            //           color: Colors.blue,
                            //           fontWeight: FontWeight.bold,
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                //sign in button
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  top: position ? 650 : 700,
                  left: 0,
                  right: 0,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: MyButton(
                      text: "Sign Up",
                      onTap: () {
                        // Validate inputs
                        if (_formKey.currentState!.validate() &&
                            isDateSelected &&
                            selectedGender != null &&
                            selectedDomisili != null) {
                          regisController.handleSignin(context);
                        } else {
                          setState(() {
                            if (!isDateSelected) {
                              dateValidationError =
                                  "Tanggal lahir harus dipilih";
                            }
                            if (selectedGender == null) {
                              regisController.selectedGender = null;
                            }
                            if (selectedDomisili == null) {
                              regisController.selectedDomisili = null;
                            }
                          });
                        }
                      },
                    ),
                  ),
                ),

                // or continue with
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  top: position ? 700 : 750,
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
                  top: position ? 725 : 775,
                  left: 20,
                  right: 20,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sudah Punya Akun?',
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
