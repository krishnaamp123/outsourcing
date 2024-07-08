import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:outsourcing/core.dart';
import 'package:outsourcing/global.dart';
import 'package:outsourcing/model/placement_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailPenempatanK extends StatefulWidget {
  final Function()? onTap;
  final String id;
  final String startDate;
  final String endDate;
  final String status;
  final String note;
  final String duration;
  final String totalEmployee;
  final String namaPemesan;
  final String alamat;
  final String namaSupervisor;
  final String alamatSupervisor;
  final String telponSupervisor;
  final String profileSupervisor;
  final String useridSupervisor;
  final List<Employees> employees;

  const DetailPenempatanK({
    Key? key,
    this.onTap,
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.note,
    required this.duration,
    required this.totalEmployee,
    required this.namaPemesan,
    required this.alamat,
    required this.namaSupervisor,
    required this.alamatSupervisor,
    required this.telponSupervisor,
    required this.profileSupervisor,
    required this.useridSupervisor,
    required this.employees,
  }) : super(key: key);

  @override
  State<DetailPenempatanK> createState() => _DetailPenempatanKState();
}

class _DetailPenempatanKState extends State<DetailPenempatanK> {
  var animate = false;
  var opacity = 0.0;
  bool position = false;
  late Size size;
  List<Employees> employees = [];
  int? userid;
  int expectedSalaryTotal = 0;
  String formattedSalaryTotal = '';
  int expectedSalary = 0;
  String formattedSalary = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadIdData();
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

  _loadIdData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var idData = localStorage.getString('karyawan');
    print("idData from SharedPreferences: $idData");

    if (idData != null) {
      var id;
      try {
        id = jsonDecode(idData);
        print("Decoded id data: $id");
      } catch (e) {
        print("Error decoding idData: $e");
      }

      if (id != null && id['id'] is int) {
        setState(() {
          userid = id['user_id'];
          print("User ID set to: $userid");
          _findEmployeeSalary();
        });
      } else {
        print("id is not an integer or id is null");
      }
    } else {
      print("idData is null");
    }
  }

  _findEmployeeSalary() {
    if (userid != null) {
      print("Finding employee with userId: $userid");
      Employees? employee = widget.employees.firstWhere(
        (emp) {
          print("Checking employee with userId: ${emp.employee?.userId}");
          return emp.employee?.userId == userid;
        },
        orElse: () {
          print("Employee not found");
          return Employees(expectedSalaryTotal: 0, expectedSalary: 0);
        },
      );

      setState(() {
        expectedSalaryTotal = employee.expectedSalaryTotal ?? 0;
        formattedSalaryTotal = NumberFormat.currency(
                locale: 'id', symbol: 'Rp. ', decimalDigits: 0)
            .format(expectedSalaryTotal);
        print("Expected salary total set to: $expectedSalaryTotal");
        expectedSalary = employee.expectedSalary ?? 0;
        formattedSalary = NumberFormat.currency(
                locale: 'id', symbol: 'Rp. ', decimalDigits: 0)
            .format(expectedSalary);
        print("Expected salary set to: $expectedSalary");
      });
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'waiting_for_mou':
        return Colors.orange;
      case 'waiting_for_initial_payment':
        return Colors.orange;
      case 'waiting_for_further_payment':
        return Colors.orange;
      case 'waiting_for_confirmation':
        return Colors.orange;
      case 'waiting_for_mou_confirmation':
        return Colors.orange;
      case 'ongoing':
        return Colors.green;
      case 'done':
        return Colors.blue;
      case 'confirmed':
        return Colors.blue;
      case 'suspended':
        return Colors.red;
      default:
        return const Color.fromRGBO(45, 3, 59, 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    Color statusColor = _getStatusColor(widget.status);
    String id = widget.id;
    String startDate = widget.startDate;
    DateTime parsedstartDate = DateTime.parse(startDate);
    String formattedstartDate =
        DateFormat('dd-MM-yyyy').format(parsedstartDate);
    String endDate = widget.endDate;
    DateTime parsedendDate = DateTime.parse(endDate);
    String formattedendDate = DateFormat('dd-MM-yyyy').format(parsedendDate);
    String status = widget.status;
    String note = widget.note;
    String duration = widget.duration;
    String totalEmployee = widget.totalEmployee;
    String namaPemesan = widget.namaPemesan;
    String alamat = widget.alamat;
    String namaSupervisor = widget.namaSupervisor;
    String alamatSupervisor = widget.alamatSupervisor;
    String telponSupervisor = widget.telponSupervisor;
    String useridSupervisor = widget.useridSupervisor;
    final imageSupervisorURL =
        '$baseURL/resource/users/$useridSupervisor/profile/';
    print('Image URL: $imageSupervisorURL');
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(top: 50),
        height: size.height,
        width: size.width,
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
                  labelText: 'Detail Penempatan',
                ),
              ),
            ),
            AnimatedPositioned(
                top: position ? 60 : 100,
                duration: const Duration(milliseconds: 400),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    height: size.height,
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          'Penempatan $id',
                          20,
                          const Color.fromRGBO(45, 3, 59, 1),
                          FontWeight.bold,
                          letterSpace: 0,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const SizedBox(
                                height: 50,
                                width: 50,
                                child: Center(
                                  child: Icon(
                                    Icons.attach_money,
                                    color: Colors.green,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      "Estimasi Gaji Total",
                                      15,
                                      Colors.black.withOpacity(.6),
                                      FontWeight.bold,
                                      letterSpace: 0,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextWidget(
                                      expectedSalaryTotal != 0
                                          ? formattedSalaryTotal
                                          : "Tidak ditemukan",
                                      18,
                                      const Color.fromRGBO(45, 3, 59, 1),
                                      FontWeight.bold,
                                      letterSpace: 0,
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                )),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              top: position ? 150 : 250,
              left: 20,
              right: 20,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: opacity,
                child: Card(
                  color: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SizedBox(
                    height: 210,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const TextWidget(
                              "Nama Pemesan :",
                              15,
                              Color.fromRGBO(129, 12, 168, 1),
                              FontWeight.normal,
                              letterSpace: 0,
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextWidget(
                              namaPemesan,
                              15,
                              const Color.fromRGBO(45, 3, 59, 1),
                              FontWeight.bold,
                              letterSpace: 0,
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const TextWidget(
                              "Alamat Pesanan:",
                              15,
                              Color.fromRGBO(129, 12, 168, 1),
                              FontWeight.normal,
                              letterSpace: 0,
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextWidget(
                              alamat,
                              15,
                              const Color.fromRGBO(45, 3, 59, 1),
                              FontWeight.bold,
                              letterSpace: 0,
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const TextWidget(
                                  "Estimasi Gaji : ",
                                  15,
                                  Color.fromRGBO(129, 12, 168, 1),
                                  FontWeight.normal,
                                  letterSpace: 0,
                                  textAlign: TextAlign.left,
                                ),
                                TextWidget(
                                  expectedSalary != 0
                                      ? formattedSalary
                                      : "Tidak ditemukan",
                                  15,
                                  const Color.fromRGBO(45, 3, 59, 1),
                                  FontWeight.bold,
                                  letterSpace: 0,
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const TextWidget(
                                  "Tanggal Kontrak : ",
                                  15,
                                  Color.fromRGBO(129, 12, 168, 1),
                                  FontWeight.normal,
                                  letterSpace: 0,
                                  textAlign: TextAlign.left,
                                ),
                                TextWidget(
                                  "$formattedstartDate - $formattedendDate",
                                  15,
                                  const Color.fromRGBO(45, 3, 59, 1),
                                  FontWeight.bold,
                                  letterSpace: 0,
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const TextWidget(
                                  "Status Pesanan : ",
                                  15,
                                  Color.fromRGBO(129, 12, 168, 1),
                                  FontWeight.normal,
                                  letterSpace: 0,
                                  textAlign: TextAlign.left,
                                ),
                                TextWidget(
                                  status,
                                  15,
                                  statusColor,
                                  FontWeight.bold,
                                  letterSpace: 0,
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const TextWidget(
                                  "Lama Kontrak : ",
                                  15,
                                  Color.fromRGBO(129, 12, 168, 1),
                                  FontWeight.normal,
                                  letterSpace: 0,
                                  textAlign: TextAlign.left,
                                ),
                                TextWidget(
                                  '$duration Hari',
                                  15,
                                  const Color.fromRGBO(45, 3, 59, 1),
                                  FontWeight.bold,
                                  letterSpace: 0,
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const TextWidget(
                                  "Jumlah Karyawan : ",
                                  15,
                                  Color.fromRGBO(129, 12, 168, 1),
                                  FontWeight.normal,
                                  letterSpace: 0,
                                  textAlign: TextAlign.left,
                                ),
                                TextWidget(
                                  '$totalEmployee Orang',
                                  15,
                                  const Color.fromRGBO(45, 3, 59, 1),
                                  FontWeight.bold,
                                  letterSpace: 0,
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const TextWidget(
                              "Catatan :",
                              15,
                              Color.fromRGBO(129, 12, 168, 1),
                              FontWeight.normal,
                              letterSpace: 0,
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextWidget(
                              note,
                              15,
                              Colors.black.withOpacity(.6),
                              FontWeight.bold,
                              letterSpace: 0,
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              top: position ? 370 : 460,
              left: 20,
              right: 20,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: opacity,
                child: SizedBox(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextWidget(
                        'Supervisor',
                        18,
                        Color.fromRGBO(45, 3, 59, 1),
                        FontWeight.bold,
                        letterSpace: 0,
                        textAlign: TextAlign.left,
                      ),
                      Card(
                        color: Colors.white,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SizedBox(
                          height: 90,
                          width: double.infinity,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 15,
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                  imageSupervisorURL,
                                ),
                                onBackgroundImageError: (error, stackTrace) {
                                  print('Error loading image: $error');
                                },
                                backgroundColor:
                                    const Color.fromRGBO(193, 71, 233, 1),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      namaSupervisor,
                                      style: const TextStyle(
                                        fontSize: 17,
                                        color: Color.fromRGBO(45, 3, 59, 1),
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0,
                                      ),
                                      textAlign: TextAlign.left,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    TextWidget(
                                      telponSupervisor,
                                      15,
                                      const Color.fromRGBO(129, 12, 168, 1),
                                      FontWeight.normal,
                                      letterSpace: 0,
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      alamatSupervisor,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black.withOpacity(.6),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.left,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
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
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              top: position ? 490 : 540,
              left: 20,
              right: 20,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                opacity: opacity,
                child: SizedBox(
                  height: 245,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextWidget(
                        'Karyawan',
                        18,
                        Color.fromRGBO(45, 3, 59, 1),
                        FontWeight.bold,
                        letterSpace: 0,
                        textAlign: TextAlign.left,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: widget.employees.length,
                          padding: const EdgeInsets.only(bottom: 10),
                          itemBuilder: (context, index) {
                            final employee = widget.employees[index];
                            String useridEmployee =
                                employee.employee!.userId.toString();
                            final imageEmployeeURL =
                                '$baseURL/resource/users/$useridEmployee/profile/';
                            print('Image URL: $imageEmployeeURL');
                            return Card(
                              color: Colors.white,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: SizedBox(
                                height: 90,
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(
                                        imageEmployeeURL,
                                      ),
                                      onBackgroundImageError:
                                          (error, stackTrace) {
                                        print('Error loading image: $error');
                                      },
                                      backgroundColor:
                                          const Color.fromRGBO(193, 71, 233, 1),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            employee.employee!.fullname!,
                                            style: const TextStyle(
                                              fontSize: 17,
                                              color:
                                                  Color.fromRGBO(45, 3, 59, 1),
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0,
                                            ),
                                            textAlign: TextAlign.left,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          TextWidget(
                                            employee.employee!.phone!,
                                            15,
                                            const Color.fromRGBO(
                                                129, 12, 168, 1),
                                            FontWeight.normal,
                                            letterSpace: 0,
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            employee.employee!.fullAddress!,
                                            style: TextStyle(
                                              fontSize: 15,
                                              color:
                                                  Colors.black.withOpacity(.6),
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.left,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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
