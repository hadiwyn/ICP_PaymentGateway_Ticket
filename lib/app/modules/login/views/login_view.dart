import 'package:WisataKU/app/modules/login/views/resetPassword.dart';
import 'package:WisataKU/app/modules/register/views/register_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: 120,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
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
                height: 650,
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/image/logo.png",
                          width: 200.0,
                          height: 200.0,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(),
                          child: TextFormField(
                            validator: _requeiredValidatorEmail,
                            controller: controller.emailC,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                color: Colors.blueGrey,
                              ),
                              suffixIcon: Icon(
                                Icons.email,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blueGrey,
                                ),
                              ),
                              helperText: 'Masukkan alamat email',
                            ),
                            onChanged: (value) {},
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(),
                          child: TextFormField(
                            validator: _requeiredValidatorPass,
                            controller: controller.passC,
                            maxLength: 20,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                color: Colors.blueGrey,
                              ),
                              suffixIcon: Icon(
                                Icons.password,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blueGrey,
                                ),
                              ),
                              helperText: 'Masukkan kata sandi',
                            ),
                            onChanged: (value) {},
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 14.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Get.to(const ResetPassword());
                                },
                                child: const Text(
                                  "Lupa kata sandi",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          child: Row(
                            children: [
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: SizedBox(
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      backgroundColor: const Color.fromARGB(
                                          255, 93, 193, 255),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState != null &&
                                          _formKey.currentState!.validate()) {
                                        try {
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return const AlertDialog(
                                                content: Row(
                                                  children: [
                                                    CircularProgressIndicator(),
                                                    SizedBox(width: 20),
                                                    Text(
                                                      "Tunggu Sebentar...",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                          User? user = await controller
                                              .loginUsingEmailPassword(
                                                  email: controller.emailC.text,
                                                  password:
                                                      controller.passC.text,
                                                  context: context);
                                          if (user != null) {
                                            // ignore: use_build_context_synchronously
                                            controller.getData(context);
                                          } else {
                                            // ignore: use_build_context_synchronously
                                            Navigator.of(context).pop();
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
                                        } catch (e) {
                                          Navigator.of(context).pop();

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  "Terjadi kesalahan saat Masuk"),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                    child: const Text('Masuk'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Belum punya akun? ",
                              style: TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                            InkWell(
                              onTap: () => Get.to(RegisterView()),
                              child: const Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                      ],
                    ),
                  ),
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
