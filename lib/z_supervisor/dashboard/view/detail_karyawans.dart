import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:outsourcing/core.dart';
import 'package:outsourcing/global.dart';

// This class handles the Page to edit the Name Section of the User Profile.
class DetailKaryawanS extends StatefulWidget {
  final String fullname;
  final String address;
  final String birthplace;
  final String birthdate;
  final String nik;
  final String npwp;
  final String gender;
  final String phone;
  final String education;
  final String salarytotal;
  final String salary;
  final String useridKaryawan;
  const DetailKaryawanS({
    Key? key,
    required this.fullname,
    required this.address,
    required this.birthplace,
    required this.birthdate,
    required this.nik,
    required this.npwp,
    required this.gender,
    required this.phone,
    required this.education,
    required this.salarytotal,
    required this.salary,
    required this.useridKaryawan,
  }) : super(key: key);

  @override
  DetailKaryawanSState createState() {
    return DetailKaryawanSState();
  }
}

class DetailKaryawanSState extends State<DetailKaryawanS> {
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

  void _showLargeImage(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String fullname = widget.fullname;
    String address = widget.address;
    String birthplace = widget.birthplace;
    String birthdate = widget.birthdate;
    DateTime parsedDate = DateTime.parse(birthdate);
    String formattedbirthDate = DateFormat('dd-MM-yyyy').format(parsedDate);
    String nik = widget.nik;
    String npwp = widget.npwp;
    String gender = widget.gender;
    String phone = widget.phone;
    String education = widget.education;
    String salarytotal = widget.salarytotal;
    int hargatotalInt = int.parse(salarytotal);
    String formattedSalaryTotal =
        NumberFormat.currency(locale: 'id', symbol: 'Rp.', decimalDigits: 0)
            .format(hargatotalInt);
    String salary = widget.salary;
    int hargaInt = int.parse(salary);
    String formattedSalary =
        NumberFormat.currency(locale: 'id', symbol: 'Rp.', decimalDigits: 0)
            .format(hargaInt);
    String useridKaryawan = widget.useridKaryawan;
    final imageURL = '$baseURL/resource/users/$useridKaryawan/profile/';
    print('Image URL: $imageURL');
    return Scaffold(
      // appBar: buildAppBar(context),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 30),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                top: position ? 1 : 50,
                left: 20,
                right: 20,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: BackButtonWidget(
                    animator: animator,
                    context: context,
                    labelText: 'Detail Karyawan',
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                top: position ? 80 : 130,
                width: MediaQuery.of(context).size.width,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showLargeImage(context, imageURL);
                        },
                        child: ClipOval(
                          child: Material(
                            color: Colors.transparent,
                            child: Image.network(
                              imageURL,
                              fit: BoxFit.cover,
                              width: 128,
                              height: 128,
                              errorBuilder: (context, error, stackTrace) {
                                print('Error loading image: $error');
                                return Image.asset(
                                  'lib/images/icon/ic_user.png',
                                  fit: BoxFit.cover,
                                  width: 128,
                                  height: 128,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        fullname,
                        style: const TextStyle(
                            color: Color.fromRGBO(45, 3, 59, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        phone,
                        style: TextStyle(
                            color: Colors.black.withOpacity(.6),
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
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
                          color: Colors.white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: SizedBox(
                            height: 380,
                            width: MediaQuery.of(context).size.width,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Estimasi Gaji :',
                                      style: TextStyle(
                                        color: Color.fromRGBO(129, 12, 168, 1),
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      formattedSalary,
                                      style: const TextStyle(
                                        color: Color.fromRGBO(45, 3, 59, 1),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Estimasi Gaji Total :',
                                      style: TextStyle(
                                        color: Color.fromRGBO(129, 12, 168, 1),
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      formattedSalaryTotal,
                                      style: const TextStyle(
                                        color: Color.fromRGBO(45, 3, 59, 1),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
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
                                      address,
                                      style: const TextStyle(
                                        color: Color.fromRGBO(45, 3, 59, 1),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Tanggal Lahir:',
                                      style: TextStyle(
                                        color: Color.fromRGBO(129, 12, 168, 1),
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      formattedbirthDate,
                                      style: const TextStyle(
                                        color: Color.fromRGBO(45, 3, 59, 1),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Tempat Lahir:',
                                      style: TextStyle(
                                        color: Color.fromRGBO(129, 12, 168, 1),
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      birthplace,
                                      style: const TextStyle(
                                        color: Color.fromRGBO(45, 3, 59, 1),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Pendidikan Terakhir :',
                                      style: TextStyle(
                                        color: Color.fromRGBO(129, 12, 168, 1),
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      education,
                                      style: const TextStyle(
                                        color: Color.fromRGBO(45, 3, 59, 1),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
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
                                      nik,
                                      style: const TextStyle(
                                        color: Color.fromRGBO(45, 3, 59, 1),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Nomor Pokok Wajib Pajak :',
                                      style: TextStyle(
                                        color: Color.fromRGBO(129, 12, 168, 1),
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      npwp,
                                      style: const TextStyle(
                                        color: Color.fromRGBO(45, 3, 59, 1),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Jenis Kelamin :',
                                      style: TextStyle(
                                        color: Color.fromRGBO(129, 12, 168, 1),
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      gender,
                                      style: const TextStyle(
                                        color: Color.fromRGBO(45, 3, 59, 1),
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
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
