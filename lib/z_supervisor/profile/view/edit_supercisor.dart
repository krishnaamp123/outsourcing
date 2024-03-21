import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:outsourcing/z_pengguna/profile/widget/buttonsimpan_widget.dart';
import 'package:outsourcing/z_pengguna/profile/widget/editappbar_widget.dart';
import 'package:outsourcing/z_pengguna/profile/widget/textfieldedit_widget.dart';
import 'package:outsourcing/z_supervisor/profile/model/supervisor.dart';
import 'package:outsourcing/z_supervisor/profile/model/supervisor_preferences.dart';
import 'package:outsourcing/z_supervisor/profile/view/pp_supervisor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

// This class handles the Page to edit the Phone Section of the User Profile.
class EditSupervisorPage extends StatefulWidget {
  const EditSupervisorPage({Key? key}) : super(key: key);

  @override
  EditSupervisorPageState createState() {
    return EditSupervisorPageState();
  }
}

class EditSupervisorPageState extends State<EditSupervisorPage> {
  late Supervisor supervisor;
  var animate = false;
  var opacity = 0.0;
  bool position = false;
  late Size size;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // user = UserPreferences.getUser();
    supervisor = SupervisorPreferences.mySupervisor;
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
                    PPSupervisor(
                      imagePath: supervisor.imagePath,
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

                        setState(() => supervisor =
                            supervisor.copy(imagePath: newImage.path));
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
                                    text: supervisor.name,
                                    onChanged: (name) => supervisor =
                                        supervisor.copy(name: name),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFieldEditWidget(
                                    label: 'Email :',
                                    text: supervisor.email,
                                    onChanged: (email) => supervisor =
                                        supervisor.copy(email: email),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFieldEditWidget(
                                    label: 'Nomor Telpon :',
                                    text: supervisor.telpon,
                                    onChanged: (telpon) => supervisor =
                                        supervisor.copy(telpon: telpon),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFieldEditWidget(
                                    label: 'Alamat :',
                                    text: supervisor.alamat,
                                    // maxLines: 3,
                                    onChanged: (alamat) => supervisor =
                                        supervisor.copy(alamat: alamat),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFieldEditWidget(
                                    label: 'Nomor Induk Keluarga :',
                                    text: supervisor.nik,
                                    onChanged: (nik) =>
                                        supervisor = supervisor.copy(nik: nik),
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
                        SupervisorPreferences.setSupervisor(supervisor);
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
