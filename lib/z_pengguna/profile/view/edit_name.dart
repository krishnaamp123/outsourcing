import 'package:flutter/material.dart';
import 'package:outsourcing/z_pengguna/profile/model/user.dart';
import 'package:outsourcing/z_pengguna/profile/model/user_preference.dart';
import 'package:outsourcing/z_pengguna/profile/view/profile_user.dart';
import 'package:outsourcing/z_pengguna/profile/widget/appbar_widget.dart';

// This class handles the Page to edit the Name Section of the User Profile.
class EditNameFormPage extends StatefulWidget {
  const EditNameFormPage({Key? key}) : super(key: key);

  @override
  EditNameFormPageState createState() {
    return EditNameFormPageState();
  }
}

class EditNameFormPageState extends State<EditNameFormPage> {
  // final _formKey = GlobalKey<FormState>();
  // final firstNameController = TextEditingController();
  // final secondNameController = TextEditingController();
  final user = UserPreferences.myUser;
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

  // @override
  // void dispose() {
  //   firstNameController.dispose();
  //   super.dispose();
  // }

  // void updateUserValue(String name) {
  //   // user.name = name;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
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
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  ProfileUser(
                    imagePath: user.imagePath,
                    onClicked: () async {},
                  ),
                  const SizedBox(height: 24),
                  buildName(user),
                  const SizedBox(height: 24),
                  const Divider(
                    height: 10,
                    thickness: 5,
                    color: Color.fromRGBO(45, 3, 59, 1),
                    indent: 20,
                    endIndent: 20,
                  ),
                  buildAbout(user),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: const TextStyle(
                color: Color.fromRGBO(45, 3, 59, 1),
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(fontSize: 15, color: Colors.grey[600]),
          ),
        ],
      );

  Widget buildAbout(User user) => Padding(
        padding: const EdgeInsets.only(left: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nomor Telpon :',
              style: TextStyle(
                color: Color.fromRGBO(129, 12, 168, 1),
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              user.telpon,
              style: const TextStyle(
                color: Color.fromRGBO(45, 3, 59, 1),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Alamat :',
              style: TextStyle(
                color: Color.fromRGBO(129, 12, 168, 1),
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              user.alamat,
              style: const TextStyle(
                color: Color.fromRGBO(45, 3, 59, 1),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Nomor Induk Keluarga :',
              style: TextStyle(
                color: Color.fromRGBO(129, 12, 168, 1),
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              user.nik,
              style: const TextStyle(
                color: Color.fromRGBO(45, 3, 59, 1),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
}
