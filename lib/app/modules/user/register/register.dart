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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: 120,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 93, 193, 255),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Center(
                    child: Text(
                      'WisataKu',
                      style: GoogleFonts.patuaOne(
                        textStyle: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 700,
                transform: Matrix4.translationValues(0.0, -30, 0),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Text(
                        "Buat Akun Kamu",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
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
                                  const SizedBox(height: 25.0),
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
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const Spacer(),
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
      // String encodedPass = base64.encode(utf8.encode(passwdC.text));

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailC.text, password: passwdC.text);
      registerUser(nameC.text, no_tlpC.text, emailC.text, passwdC.text);
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
