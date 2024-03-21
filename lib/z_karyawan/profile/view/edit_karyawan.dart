import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:outsourcing/z_karyawan/profile/model/karyawan.dart';
import 'package:outsourcing/z_karyawan/profile/model/karyawan_preferences.dart';
import 'package:outsourcing/z_karyawan/profile/view/pp_karyawan.dart';
import 'package:outsourcing/z_pengguna/profile/widget/buttonsimpan_widget.dart';
import 'package:outsourcing/z_pengguna/profile/widget/editappbar_widget.dart';
import 'package:outsourcing/z_pengguna/profile/widget/textfieldedit_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

// This class handles the Page to edit the Phone Section of the User Profile.
class EditKaryawanPage extends StatefulWidget {
  const EditKaryawanPage({Key? key}) : super(key: key);

  @override
  EditKaryawanPageState createState() {
    return EditKaryawanPageState();
  }
}

class EditKaryawanPageState extends State<EditKaryawanPage> {
  late Karyawan karyawan;
  var animate = false;
  var opacity = 0.0;
  bool position = false;
  late Size size;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // user = UserPreferences.getUser();
    karyawan = KaryawanPreferences.myKaryawan;
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
                    PPKaryawan(
                      imagePath: karyawan.imagePath,
                      isEdit: true,
                      onClicked: () async {
                        final image = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);

                        if (image == null) return;

                        final directory =
                            await getApplicationDocumentsDirectory();
                        final name = basename(image.path);
                        final imageFile = File('${directory.path}/$name');
                        final newImage =
                            await File(image.path).copy(imageFile.path);

                        setState(() =>
                            karyawan = karyawan.copy(imagePath: newImage.path));
                      },
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
                                  TextFieldEditWidget(
                                    label: 'Nama Lengkap :',
                                    text: karyawan.name,
                                    onChanged: (name) =>
                                        karyawan = karyawan.copy(name: name),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFieldEditWidget(
                                    label: 'Email :',
                                    text: karyawan.email,
                                    onChanged: (email) =>
                                        karyawan = karyawan.copy(email: email),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFieldEditWidget(
                                    label: 'Nomor Telpon :',
                                    text: karyawan.telpon,
                                    onChanged: (telpon) => karyawan =
                                        karyawan.copy(telpon: telpon),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFieldEditWidget(
                                    label: 'Alamat :',
                                    text: karyawan.alamat,
                                    // maxLines: 3,
                                    onChanged: (alamat) => karyawan =
                                        karyawan.copy(alamat: alamat),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFieldEditWidget(
                                    label: 'Nomor Induk Keluarga :',
                                    text: karyawan.nik,
                                    onChanged: (nik) =>
                                        karyawan = karyawan.copy(nik: nik),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ButtonSimpan(
                      onTap: () {
                        KaryawanPreferences.setKaryawan(karyawan);
                        Navigator.of(context).pop();
                      },
                      width: 350,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
