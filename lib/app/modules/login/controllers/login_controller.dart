import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../admin/home_admin.dart';
import '../../user/dashboard/home.dart';

class LoginController extends GetxController {
  late TextEditingController emailC;
  late TextEditingController passC;
  User? user;

  Future<void> getData() async {
    User? userid = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(userid!.uid)
        .get()
        .then((DocumentSnapshot snap) {
      if (snap.exists) {
        if (snap.get('role') == 'admin') {
          Get.off(HomeAdmin());
        } else if (snap.get('role') == 'user') {
          Get.off(Home());
        }
      }
    });
  }

  Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    String encodePass = base64.encode(utf8.encode(password));

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: encodePass);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      _handleSigupError(e);
    }

    return user;
  }

  void _handleSigupError(FirebaseAuthException e) {
    String messageToDisplay;
    switch (e.code) {
      case 'user-not-found':
        messageToDisplay = 'Email atau kata sandi salah';
        break;
      default:
        messageToDisplay = 'terjadi kesalahan yang tidak diketahui';
        break;
    }
  }

  @override
  void onInit() {
    emailC = TextEditingController();
    passC = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
