import 'dart:async';

import 'package:flutter/material.dart';
import 'package:outsourcing/components/text_widget.dart';
import 'package:outsourcing/file/user.dart';
import 'package:outsourcing/file/user_data.dart';
import 'package:outsourcing/pengguna/profile/widget/display_image_widget.dart';
import 'package:outsourcing/pengguna/profile/view/edit_description.dart';
import 'package:outsourcing/pengguna/profile/view/edit_email.dart';
import 'package:outsourcing/pengguna/profile/view/edit_image.dart';
import 'package:outsourcing/pengguna/profile/view/edit_name.dart';
import 'package:outsourcing/pengguna/profile/view/edit_phone.dart';

// This class handles the Page to dispaly the user's info on the "Edit Profile" Screen
class ProfileUser extends StatefulWidget {
  const ProfileUser({super.key});

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
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
    final user = UserData.myUser;

    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(top: 60, left: 0, right: 0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              top: position ? 1 : 100,
              right: 20,
              left: 20,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: opacity,
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: TextWidget(
                      "Profile",
                      25,
                      Color.fromRGBO(45, 3, 59, 1),
                      FontWeight.bold,
                      letterSpace: 0,
                    ),
                  ),
                ),
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              opacity: opacity,
              child: InkWell(
                onTap: () async {
                  animator();
                  setState(() {});
                  await Future.delayed(const Duration(milliseconds: 500));
                  navigateSecondPage(const EditImagePage());
                  setState(() {
                    animator();
                  });
                },
                child: DisplayImage(
                  imagePath: user.image,
                  onPressed: () {},
                ),
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              opacity: opacity,
              child: buildUserInfoDisplay(
                user.name,
                'Name',
                const EditNameFormPage(),
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              opacity: opacity,
              child: buildUserInfoDisplay(
                user.phone,
                'Phone',
                const EditPhoneFormPage(),
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              opacity: opacity,
              child: buildUserInfoDisplay(
                user.email,
                'Email',
                const EditEmailFormPage(),
              ),
            ),
            Expanded(
              flex: 4,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: opacity,
                child: buildAbout(user),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
      Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              Container(
                  width: 350,
                  height: 40,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ))),
                  child: Row(children: [
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                              navigateSecondPage(editPage);
                            },
                            child: Text(
                              getValue,
                              style: const TextStyle(fontSize: 16, height: 1.4),
                            ))),
                  ]))
            ],
          ));

  // Widget builds the About Me Section
  Widget buildAbout(User user) => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tell Us About Yourself',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 1),
          Container(
              width: 350,
              height: 200,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.grey,
                width: 1,
              ))),
              child: Row(children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {
                          navigateSecondPage(EditDescriptionFormPage());
                        },
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: TextWidget(
                                user.aboutMeDescription,
                                16,
                                const Color.fromRGBO(193, 71, 233, 1),
                                FontWeight.normal,
                                letterSpace: 0,
                                textAlign: TextAlign.left,
                              ),
                            )))),
              ]))
        ],
      ));

  // Refrshes the Page after updating user info.
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  // Handles navigation and prompts refresh.
  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }
}
