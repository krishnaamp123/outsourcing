import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:outsourcing/components/text_widget.dart';
import 'package:outsourcing/z_pengguna/profile/controller/serviceuser_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  var serviceuserCon = Get.put(ServiceUserController());
  bool isDataLoaded = false;
  int? userid;
  String? profileid;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    await _loadIdData();
    await _loadData();
  }

  Widget buildImageWithCookie(int id) {
    return FutureBuilder<Uint8List>(
      future: serviceuserCon.serviceuser.fetchImageWithCookie(id),
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
        return const CircularProgressIndicator();
      },
    );
  }

  _loadIdData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var idData = localStorage.getString('user');
    if (idData != null) {
      var id = jsonDecode(idData);
      if (id != null && id['id'] is int) {
        setState(() {
          userid = id['id'];
        });
      } else {
        print("ID bukan integer");
      }
    }
  }

  Future<void> _loadData() async {
    if (userid != null) {
      await _refreshData();
      serviceuserCon.setUserId(userid!);
      setState(() {
        isDataLoaded = true;
      });
    }
  }

  Future<void> _refreshData() async {
    if (userid != null) {
      serviceuserCon.setUserId(userid!);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: isDataLoaded
            ? Obx(() => serviceuserCon.isLoading.value
                ? const Center(
                    child: SpinKitWanderingCubes(
                      color: Colors.deepPurple,
                      size: 50.0,
                    ),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          serviceuserCon.listServiceUser.map((placementuser) {
                        var user = placementuser;
                        var userprofile = placementuser.serviceUserProfile;
                        const color = Color.fromRGBO(129, 12, 168, 1);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const TextWidget(
                              'Profile',
                              25,
                              Color.fromRGBO(45, 3, 59, 1),
                              FontWeight.bold,
                              letterSpace: 0,
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(height: 40),
                            Center(
                              child: Stack(children: [
                                buildImageWithCookie(user.id!.toInt()),
                                Positioned(
                                  bottom: 0,
                                  right: 4,
                                  child: GestureDetector(
                                    onTap: () {
                                      serviceuserCon.navigateToDetails(
                                        context,
                                        user.id!,
                                        user.email!,
                                        userprofile!.fullname!,
                                        user.password!,
                                        userprofile.fullAddress!,
                                        userprofile.birthPlace!,
                                        userprofile.birthDate!,
                                        userprofile.nik!,
                                        userprofile.gender!,
                                        userprofile.phone!,
                                      );
                                    },
                                    child: buildEditIcon(color),
                                  ),
                                ),
                              ]),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              userprofile!.fullname!,
                              style: const TextStyle(
                                color: Color.fromRGBO(45, 3, 59, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              user.email!,
                              style: TextStyle(
                                color: Colors.black.withOpacity(.6),
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 20),
                            const Divider(
                              height: 10,
                              thickness: 5,
                              color: Color.fromRGBO(45, 3, 59, 1),
                              indent: 20,
                              endIndent: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: SizedBox(
                                  height: 310,
                                  width: MediaQuery.of(context).size.width,
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Alamat :',
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  129, 12, 168, 1),
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            userprofile.fullAddress!,
                                            style: const TextStyle(
                                              color:
                                                  Color.fromRGBO(45, 3, 59, 1),
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          const Text(
                                            'Nomor Telepon :',
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  129, 12, 168, 1),
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            userprofile.phone!,
                                            style: const TextStyle(
                                              color:
                                                  Color.fromRGBO(45, 3, 59, 1),
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          const Text(
                                            'Tanggal Lahir:',
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  129, 12, 168, 1),
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            userprofile.birthDate!,
                                            style: const TextStyle(
                                              color:
                                                  Color.fromRGBO(45, 3, 59, 1),
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          const Text(
                                            'Tempat Lahir:',
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  129, 12, 168, 1),
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            userprofile.birthPlace!,
                                            style: const TextStyle(
                                              color:
                                                  Color.fromRGBO(45, 3, 59, 1),
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          const Text(
                                            'Nomor Induk Keluarga :',
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  129, 12, 168, 1),
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            userprofile.nik!,
                                            style: const TextStyle(
                                              color:
                                                  Color.fromRGBO(45, 3, 59, 1),
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          const Text(
                                            'Jenis Kelamin :',
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  129, 12, 168, 1),
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            userprofile.gender!,
                                            style: const TextStyle(
                                              color:
                                                  Color.fromRGBO(45, 3, 59, 1),
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ))
            : const Center(
                child: SpinKitWanderingCubes(
                  color: Colors.deepPurple,
                  size: 50.0,
                ),
              ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        all: 3,
        color: Colors.white,
        child: buildCircle(
          color: color,
          all: 8,
          child: const Icon(
            Icons.edit,
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
