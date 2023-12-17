import 'dart:io';

import 'package:flutter/material.dart';
import 'package:outsourcing/autentikasi/widget/my_button.dart';
import 'package:outsourcing/components/text_widget.dart';
import 'package:outsourcing/file/user_data.dart';
import 'package:outsourcing/pengguna/profile/widget/appbar_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

class EditImagePage extends StatefulWidget {
  const EditImagePage({Key? key}) : super(key: key);

  @override
  _EditImagePageState createState() => _EditImagePageState();
}

class _EditImagePageState extends State<EditImagePage> {
  var user = UserData.myUser;
  var opacity = 0.0;
  bool position = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      animator();

      setState(() {});
    });
  }

  animator() {
    if (opacity == 1) {
      opacity = 0;
      position = false;
    } else {
      opacity = 1;
      position = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              opacity: opacity,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const TextWidget(
                  "Tambahkan Gambar",
                  23,
                  Color.fromRGBO(45, 3, 59, 1),
                  FontWeight.bold,
                  letterSpace: 0,
                ),
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              opacity: opacity,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: GestureDetector(
                    onTap: () async {
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);

                      if (image == null) return;

                      final location = await getApplicationDocumentsDirectory();
                      final name = basename(image.path);
                      final imageFile = File('${location.path}/$name');
                      final newImage =
                          await File(image.path).copy(imageFile.path);
                      setState(
                          () => user = user.copy(imagePath: newImage.path));
                    },
                    child: Image.network(user.image),
                  ),
                ),
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              opacity: opacity,
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: MyButton(
                      text: "Update",
                      onTap: () async {
                        await UserData.setUser(user);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Profile updated')),
                        );
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
