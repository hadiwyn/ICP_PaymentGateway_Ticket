// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/register_controller.dart';

// ignore: must_be_immutable
class RegisterView extends StatelessWidget {
  RegisterView({Key? key}) : super(key: key);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<RegisterController>(
        init: RegisterController(),
        builder: (controller) {
          return Stack(
            children: [
              // Container(
              //   height: double.infinity,
              //   width: double.infinity,
              //   color: Colors.amber,
              // ),
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 67, 180, 250),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Center(
                    child: Text(
                  "WisataKu",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )),
              ),

              Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                    width: double.infinity,
                    height: 700,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      // ignore: prefer_const_literals_to_create_immutables
                      boxShadow: [
                        // ignore: prefer_const_constructors
                        BoxShadow(
                          blurRadius: 6,
                          color: Color(0x34000000),
                          offset: Offset(0, 3),
                        )
                      ],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: controller.isLoading
                        ? CircularProgressIndicator()
                        : SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Form(
                                      key: formKey,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "REGISTRASI",
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 78, 172, 255),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          TextFormField(
                                            controller: controller.nameC,
                                            keyboardType: TextInputType.name,
                                            textInputAction:
                                                TextInputAction.next,
                                            cursorColor:
                                                const Color(0xFF6F35A5),
                                            decoration: const InputDecoration(
                                              hintText: "Nama Depan",
                                              prefixIcon: Padding(
                                                padding: EdgeInsets.all(16.0),
                                                child: Icon(Icons.abc),
                                              ),
                                            ),
                                            maxLength: 10,
                                            validator:
                                                controller.requiredValidator,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 16),
                                            child: TextFormField(
                                              controller: controller.no_tlpC,
                                              keyboardType:
                                                  TextInputType.number,
                                              textInputAction:
                                                  TextInputAction.next,
                                              cursorColor:
                                                  const Color(0xFF6F35A5),
                                              decoration: const InputDecoration(
                                                hintText: "Nomor Telepon",
                                                prefixIcon: Padding(
                                                  padding: EdgeInsets.all(16.0),
                                                  child: Icon(Icons.numbers),
                                                ),
                                              ),
                                              maxLength: 13,
                                              validator:
                                                  controller.requiredValidator,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 16),
                                            child: TextFormField(
                                              controller: controller.emailC,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              textInputAction:
                                                  TextInputAction.next,
                                              cursorColor:
                                                  const Color(0xFF6F35A5),
                                              decoration: const InputDecoration(
                                                hintText: "Email",
                                                prefixIcon: Padding(
                                                  padding: EdgeInsets.all(16.0),
                                                  child: Icon(Icons.email),
                                                ),
                                              ),
                                              validator:
                                                  controller.requiredValidator,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 16),
                                            child: TextFormField(
                                              controller: controller.passwdC,
                                              textInputAction:
                                                  TextInputAction.done,
                                              obscureText: true,
                                              cursorColor:
                                                  const Color(0xFF6F35A5),
                                              decoration: const InputDecoration(
                                                hintText: "Password",
                                                prefixIcon: Padding(
                                                  padding: EdgeInsets.all(16.0),
                                                  child: Icon(Icons.password),
                                                ),
                                              ),
                                              validator:
                                                  controller.requiredValidator,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16.0),
                                            child: TextFormField(
                                              controller:
                                                  controller.confPasswdC,
                                              textInputAction:
                                                  TextInputAction.done,
                                              obscureText: true,
                                              cursorColor:
                                                  const Color(0xFF6F35A5),
                                              decoration: const InputDecoration(
                                                hintText: "Konfirmasi Password",
                                                prefixIcon: Padding(
                                                  padding: EdgeInsets.all(16.0),
                                                  child: Icon(
                                                      Icons.confirmation_num),
                                                ),
                                              ),
                                              validator:
                                                  controller.confirmValidator,
                                            ),
                                          ),
                                          const SizedBox(height: 16.0 / 2),
                                          InkWell(
                                            onTap: () {
                                              if (formKey.currentState !=
                                                      null &&
                                                  formKey.currentState!
                                                      .validate()) {
                                                controller.signUp(context);
                                              }
                                            },
                                            child: Container(
                                              width: 150,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: const [
                                                    Color.fromARGB(
                                                        255, 28, 153, 255),
                                                    Color.fromARGB(
                                                        255, 91, 233, 255)
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ),
                                                // ignore: prefer_const_literals_to_create_immutables
                                                boxShadow: [
                                                  // ignore: prefer_const_constructors
                                                  BoxShadow(
                                                    blurRadius: 6,
                                                    color: Color(0x34000000),
                                                    offset: Offset(0, 3),
                                                  )
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                "DAFTAR",
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              )),
                                            ),
                                          ),
                                          const SizedBox(height: 25.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              const Text(
                                                "Sudah mempunyai Akun ? ",
                                                style: TextStyle(
                                                    color: Color(0xFF6F35A5)),
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
                            ),
                          ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
