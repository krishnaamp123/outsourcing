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
  //text editing controllers
  final RegisController regisController = RegisController();
  final RegisController regisController1 = Get.put(RegisController());
  var animate = false;
  var opacity = 0.0;
  bool position = false;
  late Size size;
  DateTime selectedDate = DateTime.now();
  String _formatDate(DateTime date) {
    return "${date.year} - ${date.month} - ${date.day}";
  }

  String dateValidationError = "";
  bool isDateSelected = false;
  String? selectedGender;
  List<String> genderOptions = ['L', 'P'];
  bool isDataLoaded = false;
  String? selectedDomisili;
  List<String> domisiliOptions = [];

  @override
  void initState() {
    // TODO: implement initState
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

                //welcome back, you've been missed!
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

                //fullname textfield
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  top: position ? 260 : 320,
                  left: 0,
                  right: 0,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: SizedBox(
                      height: 400,
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
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
                            PassTextField(
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
                            const SizedBox(height: 5),
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
                            MyTextField(
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
                            const SizedBox(height: 5),
                            MyTextField(
                              controller: regisController.tempatController,
                              hintText: 'Tempat Lahir',
                              obscureText: false,
                              validator: regisController
                                  .validateTempat, // Set validator dari controller
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
                                  setState(() {
                                    selectedDate = dateTime;
                                    isDateSelected = true;
                                    dateValidationError = "";
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

                            // Jenis Kelamin
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
                                    value: selectedGender,
                                    hint: const Text(
                                      "Jenis Kelamin",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color:
                                              Color.fromARGB(255, 80, 80, 80),
                                          fontWeight: FontWeight.normal),
                                    ),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedGender = newValue!;
                                      });
                                    },
                                    items: genderOptions.map((String option) {
                                      return DropdownMenuItem<String>(
                                        value: option,
                                        child: Text(
                                          option,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      );
                                    }).toList(),
                                    buttonStyleData: const ButtonStyleData(
                                      height: 50,
                                    ),
                                    iconStyleData: const IconStyleData(
                                      icon: Icon(
                                        Icons.arrow_drop_down_outlined,
                                      ),
                                      iconSize: 25,
                                      iconEnabledColor: Colors.grey,
                                    ),
                                    dropdownStyleData:
                                        const DropdownStyleData(maxHeight: 120),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 50,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // const DomisiliDropdown(),

                            //Domisili
                            Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Obx(() => DropdownButtonHideUnderline(
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
                                        value: selectedDomisili,
                                        hint: const Text(
                                          "Domisili",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color.fromARGB(
                                                  255, 80, 80, 80),
                                              fontWeight: FontWeight.normal),
                                        ),
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedDomisili = newValue!;
                                          });
                                        },
                                        items: regisController1
                                                .listRegency.isEmpty
                                            ? []
                                            : regisController1.listRegency
                                                .map((regency) =>
                                                    regency.regency ??
                                                    "") // Ubah disini
                                                .toList()
                                                .map((option) =>
                                                    DropdownMenuItem<String>(
                                                      value: option,
                                                      child: Text(
                                                        option,
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                      ),
                                                    ))
                                                .toList(),
                                        buttonStyleData: const ButtonStyleData(
                                          height: 50,
                                        ),
                                        iconStyleData: const IconStyleData(
                                          icon: Icon(
                                            Icons.arrow_drop_down_outlined,
                                          ),
                                          iconSize: 25,
                                          iconEnabledColor: Colors.grey,
                                        ),
                                        dropdownStyleData:
                                            const DropdownStyleData(
                                                maxHeight: 120),
                                        menuItemStyleData:
                                            const MenuItemStyleData(
                                          height: 50,
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
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
                        } else {
                          setState(() {
                            dateValidationError = "Masukkan tanggal lahir";
                          });
                        }
                      },
                    ),
                  ),
                ),

                // divider
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 400),
                  top: position ? 715 : 770,
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
                  top: position ? 735 : 795,
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
