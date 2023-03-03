import 'dart:convert';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticket_wisata_donorojo/app/modules/login/views/login_view.dart';
import 'package:ticket_wisata_donorojo/app/modules/user/dashboard/dashboard.dart';
import 'package:ticket_wisata_donorojo/app/modules/user/register/registerService.dart';
import 'package:ticket_wisata_donorojo/app/routes/app_pages.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late TextEditingController nameC = TextEditingController();
  late TextEditingController no_tlpC = TextEditingController();
  late TextEditingController emailC = TextEditingController();
  late TextEditingController passwdC = TextEditingController();
  late TextEditingController confPasswdC = TextEditingController();
  bool loading = false;

  TextInputType? keyboardType;

  FormFieldValidator<String>? validator;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: const Color(0xFF6F35A5),
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: const Color(0xFF6F35A5),
            shape: const StadiumBorder(),
            maximumSize: const Size(double.infinity, 56),
            minimumSize: const Size(double.infinity, 56),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFFF1E6FF),
          iconColor: Color(0xFF6F35A5),
          prefixIconColor: Color(0xFF6F35A5),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              // Positioned(
              //   top: 0,
              //   left: 0,
              //   child: Image.network(
              //     "https://capekngoding.com/uploads/62f680369803f_main_top.png",
              //     width: 120,
              //   ),
              // ),
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Text("daftar Akun".toUpperCase(),
                            style: GoogleFonts.roboto(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      const SizedBox(height: 32.0),
                      // CircleAvatar(
                      //   radius: 40.0,
                      //   backgroundImage: NetworkImage(
                      //     "https://i.ibb.co/PGv8ZzG/me.jpg",
                      //   ),
                      // ),
                      // const SizedBox(height: 40.0),
                      Row(
                        children: [
                          const Spacer(),
                          Expanded(
                            flex: 8,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: nameC,
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.next,
                                    cursorColor: const Color(0xFF6F35A5),
                                    decoration: const InputDecoration(
                                      hintText: "Nama Lengkap",
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Icon(Icons.person),
                                      ),
                                    ),
                                    validator: _requeiredValidator,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16),
                                    child: TextFormField(
                                      controller: no_tlpC,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      cursorColor: const Color(0xFF6F35A5),
                                      decoration: const InputDecoration(
                                        hintText: "Nomor Telepon",
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Icon(Icons.person),
                                        ),
                                      ),
                                      validator: _requeiredValidator,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16),
                                    child: TextFormField(
                                      controller: emailC,
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next,
                                      cursorColor: const Color(0xFF6F35A5),
                                      decoration: const InputDecoration(
                                        hintText: "Email",
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Icon(Icons.person),
                                        ),
                                      ),
                                      validator: _requeiredValidator,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16),
                                    child: TextFormField(
                                      controller: passwdC,
                                      textInputAction: TextInputAction.done,
                                      obscureText: true,
                                      cursorColor: const Color(0xFF6F35A5),
                                      decoration: const InputDecoration(
                                        hintText: "Password",
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Icon(Icons.person),
                                        ),
                                      ),
                                      validator: _requeiredValidator,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    child: TextFormField(
                                      controller: confPasswdC,
                                      textInputAction: TextInputAction.done,
                                      obscureText: true,
                                      cursorColor: const Color(0xFF6F35A5),
                                      decoration: const InputDecoration(
                                        hintText: "Konfirmasi Password",
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Icon(Icons.lock),
                                        ),
                                      ),
                                      validator: _requeiredConfirmValidator,
                                    ),
                                  ),
                                  const SizedBox(height: 16.0 / 2),
                                  if (loading) ...[
                                    Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  ],
                                  if (!loading) ...[
                                    ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState != null &&
                                            _formKey.currentState!.validate()) {
                                          sigUp();
                                        }
                                      },
                                      child: Text("Daftar".toUpperCase()),
                                    ),
                                  ],
                                  const SizedBox(height: 16.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      const Text(
                                        "Sudah mempunyai Akun ? ",
                                        style:
                                            TextStyle(color: Color(0xFF6F35A5)),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          "Masuk",
                                          style: TextStyle(
                                            color: Color(0xFF6F35A5),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
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

  String? _requeiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Form ini dibutuhkan !';
    } else {
      return null;
    }
  }

  String? _requeiredConfirmValidator(String? confirmPasswordText) {
    if (confirmPasswordText == null || confirmPasswordText.trim().isEmpty) {
      return 'Form ini dibutuhkan !';
    }
    if (passwdC.text != confirmPasswordText) {
      print(passwdC.text);
      print(confirmPasswordText);
      return 'Password tidak sama';
    } else {
      return null;
    }
  }

  Future sigUp() async {
    setState(() {
      loading = true;
    });
    try {
      String encodedPass = base64.encode(utf8.encode(passwdC.text));

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailC.text, password: encodedPass);
      registerUser(nameC.text, no_tlpC.text, emailC.text, encodedPass);
      // await FirebaseFirestore.instance.collection('users').add({
      //   'nama_lengkap': nameC.text,
      //   'no_tlp': no_tlpC.text,
      //   'email': emailC.text,
      //   'password': passwdC.text,
      //   'role': 'user'
      // });

      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                  title: Text('Pendaftaran Berhasil'),
                  content:
                      Text("Akun kamu sudah dibuat, kamu bisa masuk sekarang"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Get.offNamed(Routes.LOGIN);
                        FirebaseAuth.instance.signOut();
                        Get.deleteAll();
                      },
                      child: Text("Oke"),
                    )
                  ]));
    } on FirebaseAuthException catch (e) {
      _handleSigupError(e);
      setState(() {
        loading = false;
      });
    }
  }

  void _handleSigupError(FirebaseAuthException e) {
    String messageToDisplay;
    switch (e.code) {
      case 'email-already-in-use':
        messageToDisplay = 'Email sudah ada';
        break;
      case 'invalid-email':
        messageToDisplay = 'Email tidak valid';
        break;
      case 'operation-not-allowed':
        messageToDisplay = 'Operasi tidak diperbolehkan';
        break;
      case 'weak-password':
        messageToDisplay = 'Kata sandi terlalu lemah';
        break;
      default:
        messageToDisplay = 'terjadi kesalahan yang tidak diketahui';
        break;
    }

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: Text("Pendaftaran Gagal"),
                content: Text(messageToDisplay),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text("Oke"),
                  )
                ]));
  }
}
