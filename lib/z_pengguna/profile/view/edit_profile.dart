import 'package:flutter/material.dart';
import 'package:outsourcing/z_pengguna/profile/model/user.dart';
import 'package:outsourcing/z_pengguna/profile/model/user_preference.dart';
import 'package:outsourcing/z_pengguna/profile/view/profile_user.dart';
import 'package:outsourcing/z_pengguna/profile/widget/buttonsimpan_widget.dart';
import 'package:outsourcing/z_pengguna/profile/widget/editappbar_widget.dart';
import 'package:outsourcing/z_pengguna/profile/widget/textfieldedit_widget.dart';

// This class handles the Page to edit the Phone Section of the User Profile.
class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  EditProfilePageState createState() {
    return EditProfilePageState();
  }
}

class EditProfilePageState extends State<EditProfilePage> {
  User user = UserPreferences.myUser;
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
              child: Column(
                children: [
                  ProfileUser(
                    imagePath: user.imagePath,
                    isEdit: true,
                    onClicked: () async {},
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
                                  text: user.name,
                                  onChanged: (name) =>
                                      user = user.copy(name: name),
                                ),
                                const SizedBox(height: 10),
                                TextFieldEditWidget(
                                  label: 'Email :',
                                  text: user.email,
                                  onChanged: (email) =>
                                      user = user.copy(email: email),
                                ),
                                const SizedBox(height: 10),
                                TextFieldEditWidget(
                                  label: 'Nomor Telpon :',
                                  text: user.telpon,
                                  onChanged: (telpon) =>
                                      user = user.copy(telpon: telpon),
                                ),
                                const SizedBox(height: 10),
                                TextFieldEditWidget(
                                  label: 'Alamat :',
                                  text: user.alamat,
                                  // maxLines: 3,
                                  onChanged: (alamat) =>
                                      user = user.copy(alamat: alamat),
                                ),
                                const SizedBox(height: 10),
                                TextFieldEditWidget(
                                  label: 'Nomor Induk Keluarga :',
                                  text: user.nik,
                                  onChanged: (nik) =>
                                      user = user.copy(nik: nik),
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
                      UserPreferences.setUser(user);
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
    );
  }
}
