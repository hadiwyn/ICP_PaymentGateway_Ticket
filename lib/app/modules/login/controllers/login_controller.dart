import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticket_wisata_donorojo/app/modules/admin/home_admin.dart';
import 'package:ticket_wisata_donorojo/app/modules/user/dashboard/home.dart';

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

    print(email);
    print(password);

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
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

  final count = 0.obs;
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

  void increment() => count.value++;
}
