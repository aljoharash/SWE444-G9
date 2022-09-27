import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itmaen/controller/addMedicineController.dart';
import 'package:itmaen/Widget/Card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:itmaen/addMedicinePages/adddialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:itmaen/home.dart';
import 'package:itmaen/navigation.dart';
import 'package:itmaen/secure-storage.dart';

import 'addmedicine.dart';

class addByScan extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User? loggedInUser = _auth.currentUser;

  String? genericName;
  String? tradeName;
  String? strengthValue;
  String? unitOfStrength;
  String? volume;
  String? unitOfVolume;
  String? packageSize;
  String? barcode;
  String? description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 140, 167, 190),
        title: Center(
            child: Text(
          "الماسح الضوئي",
          style: GoogleFonts.tajawal(fontWeight: FontWeight.bold),
        )),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: GetBuilder<addMedicineController>(
              init: addMedicineController(),
              builder: (_) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      width: double.infinity,
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: _.scannedMedicine.isEmpty
                              ? Container(
                                  alignment: Alignment.center,
                                  height: 100,
                                  child: addMedicineController.notFound
                                      ? Text(
                                          'لم يتم المسح حتى الان أو لم يتم العثور على الدواء',
                                          style: GoogleFonts.tajawal(
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text(
                                          'اقرأ الباركود',
                                          style: GoogleFonts.tajawal(
                                              fontWeight: FontWeight.bold),
                                        ))
                              : Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(
                                      height: 30,
                                    ),
                                    BuildCard(
                                      info: 'اسم الدواء',
                                      icon: FontAwesomeIcons.medkit,
                                      item: tradeName = _
                                          .scannedMedicine[0].tradeName
                                          .toString(),
                                    ),
                                    Divider(),
                                    BuildCard(
                                      info: 'وصف الدواء ',
                                      icon: FontAwesomeIcons.list,
                                      item: description = _
                                          .scannedMedicine[0].description
                                          .toString(),
                                    ),
                                    Divider(),
                                    BuildCard(
                                      info: 'الجرعة ',
                                      icon: FontAwesomeIcons.diagnoses,
                                      item: strengthValue = _
                                          .scannedMedicine[0].strengthValue
                                          .toString(),
                                    ),
                                    Divider(),
                                    BuildCard(
                                      info: 'الاسم العلمي ',
                                      icon: FontAwesomeIcons.stethoscope,
                                      item: genericName = _
                                          .scannedMedicine[0].genericName
                                          .toString(),
                                    ),
                                    Divider(),
                                    BuildCard(
                                      info: 'عدد الحبات',
                                      icon: FontAwesomeIcons.pills,
                                      item: packageSize = _
                                          .scannedMedicine[0].packageSize
                                          .toString(),
                                    ),
                                    Divider(),
                                  ],
                                ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 60.0,
                        width: 200,
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 140, 167, 190),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Center(
                                    child: Icon(
                                  FontAwesomeIcons.barcode,
                                  size: 16,
                                  color: Colors.white,
                                )),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "الماسح الضوئي",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.tajawal(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            onPressed: () => _.scanBarcode()),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 60.0,
                        width: 200,
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 76, 146, 15),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: TextButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Center(
                                    child: Icon(
                                  FontAwesomeIcons.plus,
                                  size: 16,
                                  color: Colors.white,
                                )),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "إضافة",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.tajawal(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            onPressed: () {
                              if (addMedicineController.notFound == false) {
                                _firestore.collection('medicines').add({
                                  'Generic name': genericName,
                                  'Trade name': tradeName,
                                  'Strength value': strengthValue,
                                  'Unit of strength': unitOfStrength,
                                  'Volume': volume,
                                  'Unit of volume': unitOfVolume,
                                  'Package size': packageSize,
                                  'barcode': barcode,
                                  'description': description,
                                  'caregiverID': loggedInUser!.uid,
                                });
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Navigation()));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    // margin: EdgeInsets.only(right: 10),

                                    content: Text(
                                        'عليك استخدام الماسح الضوئي أولاً ',
                                        style: TextStyle(fontSize: 20),
                                        textAlign: TextAlign.right),
                                  ),
                                );
                              }

                              _.scannedMedicine.clear();
                            }),
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}