import 'package:flutter/material.dart';
import 'package:outsourcing/autentikasi/widget/my_button.dart';
import 'package:outsourcing/file/user_data.dart';
import 'package:outsourcing/pengguna/profile/widget/appbar_widget.dart';
import 'package:string_validator/string_validator.dart';

// This class handles the Page to edit the alamat Section of the User Profile.
class EditAlamatFormPage extends StatefulWidget {
  const EditAlamatFormPage({Key? key}) : super(key: key);

  @override
  EditAlamatFormPageState createState() {
    return EditAlamatFormPageState();
  }
}

class EditAlamatFormPageState extends State<EditAlamatFormPage> {
  final _formKey = GlobalKey<FormState>();
  final alamatController = TextEditingController();
  var user = UserData.myUser;

  @override
  void dispose() {
    alamatController.dispose();
    super.dispose();
  }

  void updateUserValue(String alamat) {
    user.alamat = alamat;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                    width: 330,
                    child: Text(
                      "Masukkan Alamat Anda",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: SizedBox(
                        height: 100,
                        width: 330,
                        child: TextFormField(
                          // Handles Form Validation
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your address.';
                            }
                            return null;
                          },
                          decoration:
                              const InputDecoration(labelText: 'Alamat'),
                          controller: alamatController,
                        ))),
                Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: 330,
                          height: 50,
                          child: MyButton(
                            text: "Ubah",
                            onTap: () {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState!.validate() &&
                                  isAlpha(alamatController.text)) {
                                updateUserValue(alamatController.text);
                                Navigator.pop(context);
                              }
                            },
                          ),
                        )))
              ]),
        ));
  }
}
