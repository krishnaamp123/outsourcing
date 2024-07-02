import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:outsourcing/service/supervisor_service.dart';
import 'package:outsourcing/z_pengguna/profile/widget/buttonsimpan_widget.dart';
import 'package:outsourcing/z_pengguna/profile/widget/editappbar_widget.dart';
import 'package:outsourcing/z_supervisor/profile/controller/supervisor_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditSupervisorProfilePage extends StatefulWidget {
  final int id;
  final String email;
  final String fullname;
  final String password;
  final String fulladdress;
  final String birthplace;
  final String birthdate;
  final String nik;
  final String npwp;
  final String gender;
  final String phone;

  const EditSupervisorProfilePage({
    Key? key,
    required this.id,
    required this.email,
    required this.fullname,
    required this.password,
    required this.fulladdress,
    required this.birthplace,
    required this.birthdate,
    required this.nik,
    required this.npwp,
    required this.gender,
    required this.phone,
  }) : super(key: key);

  @override
  EditSupervisorProfilePageState createState() =>
      EditSupervisorProfilePageState();
}

class EditSupervisorProfilePageState extends State<EditSupervisorProfilePage> {
  var animate = false;
  var opacity = 0.0;
  bool position = false;
  late Size size;
  var supervisorCon = Get.put(SupervisorController());
  final supervisor = SupervisorService();

  late TextEditingController fullnameController;
  late TextEditingController passwordController;
  late TextEditingController addressController;
  late TextEditingController phoneController;

  File? _profileImage;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      animator();
    });

    fullnameController = TextEditingController(text: widget.fullname);
    passwordController = TextEditingController(text: "");
    addressController = TextEditingController(text: widget.fulladdress);
    phoneController = TextEditingController(text: widget.phone);
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

  Widget buildImageWithCookie(int id) {
    return FutureBuilder<Uint8List>(
      future: supervisorCon.supervisor.fetchImageWithCookie(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return ClipOval(
              child: Image.memory(
                snapshot.data!,
                fit: BoxFit.cover,
                width: 128,
                height: 128,
              ),
            );
          } else if (snapshot.hasError) {
            return const Icon(Icons.person, size: 128, color: Colors.grey);
          }
        }
        return const SpinKitWanderingCubes(
          color: Colors.deepPurple,
          size: 50.0,
        );
      },
    );
  }

  Future<void> _pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final directory = await getApplicationDocumentsDirectory();
      final name = basename(image.path);
      final imageFile = File('${directory.path}/$name');
      final newImage = await File(image.path).copy(imageFile.path);

      setState(() {
        _profileImage = newImage;
      });
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> _updateProfile(BuildContext context) async {
    try {
      final response = await supervisor.patchSupervisor(
        widget.id,
        fullnameController.text,
        addressController.text,
        phoneController.text,
        passwordController.text.isEmpty ? null : passwordController.text,
        _profileImage,
      );

      if (response.statusCode == 200) {
        print('Profile updated successfully');
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        var userData = localStorage.getString('supervisor');
        if (userData != null) {
          var user = jsonDecode(userData);
          user['fullname'] = fullnameController.text;
          user['fulladdress'] = addressController.text;
          user['phone'] = phoneController.text;
          await localStorage.setString('supervisor', jsonEncode(user));
        }
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Info',
            message:
                'Update profile berhasil disimpan, terimakasih telah melakukan perubahan profile!',
            contentType: ContentType.success,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);

        // Wait for 2 seconds before popping the screen
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });
      } else {
        print('Failed to update profile: ${response.body}');
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Error',
            message:
                'Update profile gagal dilakukan. silakan periksa inputan kembali!',
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildEditAppBar(context),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: AnimatedPositioned(
            duration: const Duration(milliseconds: 400),
            top: position ? 1 : 1,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              opacity: opacity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Center(
                      child: Stack(
                        children: [
                          _profileImage == null
                              ? buildImageWithCookie(widget.id)
                              : ClipOval(
                                  child: Image.file(
                                    _profileImage!,
                                    fit: BoxFit.cover,
                                    width: 128,
                                    height: 128,
                                  ),
                                ),
                          Positioned(
                            bottom: 0,
                            right: 4,
                            child: GestureDetector(
                              onTap: _pickImage,
                              child: buildEditIcon(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SizedBox(
                          height: 400,
                          width: MediaQuery.of(context).size.width,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: fullnameController,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(45, 3, 59, 1),
                                    ),
                                    decoration: const InputDecoration(
                                      labelText: 'Nama Lengkap :',
                                      labelStyle: TextStyle(
                                        fontSize: 16,
                                        color: Color.fromRGBO(129, 12, 168, 1),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    controller: passwordController,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(45, 3, 59, 1),
                                    ),
                                    decoration: const InputDecoration(
                                      labelText: 'Password :',
                                      labelStyle: TextStyle(
                                        fontSize: 16,
                                        color: Color.fromRGBO(129, 12, 168, 1),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    controller: addressController,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(45, 3, 59, 1),
                                    ),
                                    decoration: const InputDecoration(
                                      labelText: 'Alamat :',
                                      labelStyle: TextStyle(
                                        fontSize: 16,
                                        color: Color.fromRGBO(129, 12, 168, 1),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    controller: phoneController,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Color.fromRGBO(45, 3, 59, 1),
                                    ),
                                    decoration: const InputDecoration(
                                      labelText: 'Nomor Telpon :',
                                      labelStyle: TextStyle(
                                        fontSize: 16,
                                        color: Color.fromRGBO(129, 12, 168, 1),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ButtonSimpan(
                      onTap: () => _updateProfile(context),
                      width: 350,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEditIcon() => buildCircle(
        all: 3,
        color: Colors.white,
        child: buildCircle(
          color: const Color.fromRGBO(129, 12, 168, 1),
          all: 8,
          child: const Icon(
            Icons.photo_camera,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
