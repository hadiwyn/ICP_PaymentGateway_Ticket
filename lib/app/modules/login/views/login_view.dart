import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticket_wisata_donorojo/app/modules/login/views/resetPassword.dart';

import '../../user/register/register.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
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
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              // Padding(
              //   padding: const EdgeInsets.only(top: 80),
              //   child: Column(children: [
              //     Image.asset(
              //       "assets/image/logo-pacitan.webp",
              //       width: 200,
              //     ),
              //   ]),
              // ),
              SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Text(
                            "E-Ticketing Wisata",
                            style: GoogleFonts.lato(
                                // ignore: prefer_const_constructors
                                textStyle: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            )),
                          ),
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            Expanded(
                              flex: 3,
                              child:
                                  Image.asset("assets/image/logo-pacitan.webp"),
                            ),
                            const Spacer(),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                      ],
                    ),
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
                                  controller: controller.emailC,
                                  keyboardType: TextInputType.emailAddress,
                                  cursorColor: const Color(0xFF6F35A5),
                                  validator: _requeiredValidatorEmail,
                                  decoration: const InputDecoration(
                                    hintText: "Email",
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Icon(Icons.person),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: TextFormField(
                                    controller: controller.passC,
                                    textInputAction: TextInputAction.done,
                                    obscureText: true,
                                    cursorColor: const Color(0xFF6F35A5),
                                    decoration: const InputDecoration(
                                      hintText: "Password",
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Icon(Icons.lock),
                                      ),
                                    ),
                                    validator: _requeiredValidatorPass,
                                  ),
                                ),
                                const SizedBox(height: 16.0 / 2),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState != null &&
                                        _formKey.currentState!.validate()) {
                                      User? user = await controller
                                          .loginUsingEmailPassword(
                                              email: controller.emailC.text,
                                              password: controller.passC.text,
                                              context: context);
                                      if (user != null) {
                                        controller.getData();
                                      } else {
                                        Get.defaultDialog(
                                          title: "Gagal Login",
                                          middleText:
                                              "Email atau kata sandi salah",
                                          onConfirm: () {
                                            // controller.emailC.clear();
                                            // controller.passC.clear();
                                            Get.back();
                                          },
                                          textConfirm: "Okey",
                                        );
                                      }
                                    }
                                  },
                                  child: Text("Masuk".toUpperCase()),
                                ),
                                const SizedBox(height: 16.0),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 70),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      ResetPassword())));
                                        },
                                        child: const Text(
                                          "Lupa kata sandi",
                                          style: TextStyle(
                                            color: Color(0xFF6F35A5),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const Text(
                                      "Belum mempunyai Akun ? ",
                                      style:
                                          TextStyle(color: Color(0xFF6F35A5)),
                                    ),
                                    GestureDetector(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Register())),
                                      child: const Text(
                                        "Daftar",
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
            ],
          ),
        ),
      ),
    );
  }

  String? _requeiredValidatorEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email tidak boleh kosong';
    } else {
      return null;
    }
  }

  String? _requeiredValidatorPass(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Kata sandi tidak boleh kosong';
    } else {
      return null;
    }
  }
}
