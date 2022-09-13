import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:itmaen/constant.dart';
import 'package:itmaen/home.dart';
import 'package:itmaen/login.dart';

import 'firebase.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = 'SignUpScreen';

  @override
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController username = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController phoneNum = new TextEditingController();
  String errorMessage = '';
  @override
  Widget build(BuildContext context) => Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    /*SafeArea(
                      child: Hero(
                        tag: 'logo',
                        child: Container(
                          height: 500.0,
                          child: Text('sss'),
                        ),
                      ),
                    ),*/
                    SizedBox(
                      height: 180.0,
                    ),
                    SafeArea(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "انشاء حساب",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 50,
                              color: Colors.blueGrey,
                              fontFamily: 'Madani Arabic Black'),
                        ),
                      ),
                    ),
                    /*SizedBox(
                      height: 50.0,
                    ),*/
                    TextFormField(
                      controller: username,
                      validator: ValidateUserName,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 239, 237, 237),
                        hintText: 'اسم المستخدم ',
                        enabled: true,
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, right: 12.0, bottom: 8.0, top: 8.0),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 236, 231, 231),
                                width: 3)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(
                              color: Color.fromARGB(79, 255, 255, 255)),
                          borderRadius: new BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: email,
                      validator: ValidateEmail,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 239, 237, 237),
                        hintText: ' البريد الالكتروني ',
                        enabled: true,
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, right: 12.0, bottom: 8.0, top: 8.0),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 236, 231, 231),
                                width: 3)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(
                              color: Color.fromARGB(79, 255, 255, 255)),
                          borderRadius: new BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(errorMessage),
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: password,
                      validator: ValidatePassword,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 239, 237, 237),
                        hintText: 'كلمة المرور ',
                        enabled: true,
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, right: 12.0, bottom: 8.0, top: 8.0),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 236, 231, 231),
                                width: 3)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(
                              color: Color.fromARGB(79, 255, 255, 255)),
                          borderRadius: new BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: phoneNum,
                      validator: ValidatePhoneNumber,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 239, 237, 237),
                        hintText: 'رقم الهاتف ',
                        enabled: true,
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, right: 12.0, bottom: 8.0, top: 8.0),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 236, 231, 231),
                                width: 3)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(
                              color: Color.fromARGB(79, 255, 255, 255)),
                          borderRadius: new BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    ElevatedButton(
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          backgroundColor: Colors.blueGrey),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            final newUser =
                                await _auth.createUserWithEmailAndPassword(
                                    email: email.text, password: password.text);
                            errorMessage = '';
                            if (newUser != null) {
                              //will take us to the homescreen
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              );
                            }

                            User? updateUser =
                                FirebaseAuth.instance.currentUser;
                            //updateUser?.updateDisplayName(username);
                            userSetup(username, email, password, phoneNum);
                          } on FirebaseAuthException catch (error) {
                            errorMessage = error.message!;
                            errorMessage = 'البريد الالكتروني مسجل مسبقا';
                          }
                          setState(() {});
                        }
                      },
                      child: Text(
                        'انشاء ',
                        style: TextStyle(fontFamily: 'Madani Arabic Black'),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginPage()));
                      },
                      child: const Text(
                        'لديّ حساب مسبقا',
                        style: TextStyle(fontFamily: 'Madani Arabic Black'),
                      ),
                    ),
                  ]),
            ),
          )));
}

String? ValidateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty)
    return ' الرجاء ادخال البريد الالكتروني';

  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formEmail.trim()))
    return 'البريد الاكتروني المدخل غير صحيح';
  return null;
}

String? ValidatePassword(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty)
    return ' الرجاء ادخال الرقم السري';
  String pattern = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formPassword.trim()))
    return ('يجب أن تتكون كلمة المرور على ٨ رموز(منها حرف ورقم على الاقل) ');
  ; // check arabic formation
  return null;
}

String? ValidateUserName(String? FormName) {
  if (FormName == null || FormName.isEmpty) return 'الرجاء ادخال اسم المستخدم';
  String pattern =
      r'^(?=.{2,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(FormName.trim()))
    return 'يجب أن يحتوي اسم المستخدم على حرفين على الاقل';
  return null;
}

String? ValidatePhoneNumber(String? FormNhoneNumber) {
  if (FormNhoneNumber == null || FormNhoneNumber.isEmpty)
    return 'الرجاء ادخال رقم الهاتف';
  String pattern = r'[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(FormNhoneNumber.trim()))
    return ' الرقم المدخل غير صحيح  ';
  return null;
}