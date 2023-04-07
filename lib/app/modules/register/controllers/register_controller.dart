import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class RegisterController extends GetxController {
  late TextEditingController nameC;
  late TextEditingController no_tlpC;
  late TextEditingController emailC;
  late TextEditingController passwdC;
  late TextEditingController confPasswdC;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    update();
  }

  Future<void> signUp(BuildContext context) async {
    bool isRegistrationSuccessful = false;
    try {
      // set loading to true
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      // create user with email and password
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailC.text,
        password: passwdC.text,
      );

      // update user information
      User user = userCredential.user!;
      await user.updateDisplayName(nameC.text);

      User? userid = FirebaseAuth.instance.currentUser;

      CollectionReference ref = FirebaseFirestore.instance.collection('users');

      ref.doc(userid!.uid).set({
        'email': emailC.text,
        'nama_lengkap': nameC.text,
        'no_tlp': no_tlpC.text,
        'Password': passwdC.text,
        'role': 'user'
      });

      // set flag to indicate success
      isRegistrationSuccessful = true;
    } on FirebaseAuthException catch (e) {
      // show error dialog and set loading to false
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

      print(messageToDisplay);

      Get.back(); // dismiss progress indicator
      await Future.delayed(Duration(milliseconds: 500)); // add delay

      Get.dialog(
        AlertDialog(
          title: const Text('Pendaftaran Gagal'),
          content: Text(messageToDisplay),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Oke"),
            )
          ],
        ),
      );
    } finally {
      // dismiss progress indicator
      // Get.back();

      // show success dialog if registration was successful
      if (isRegistrationSuccessful) {
        Get.dialog(
          AlertDialog(
            title: const Text('Pendaftaran Berhasil'),
            content:
                const Text("Akun kamu sudah dibuat, kamu bisa masuk sekarang"),
            actions: [
              TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pop();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.LOGIN,
                    (route) => false,
                  );
                },
                child: const Text("Oke"),
              )
            ],
          ),
        );
      }
    }
  }

  @override
  void onInit() {
    nameC = TextEditingController();

    no_tlpC = TextEditingController();
    emailC = TextEditingController();
    passwdC = TextEditingController();
    confPasswdC = TextEditingController();
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

  String? Function(String?) get requiredValidator =>
      (value) => value?.trim().isEmpty ?? true ? 'Form ini dibutuhkan !' : null;

  String? Function(String?) get confirmValidator => (confirmPasswordText) {
        if (confirmPasswordText?.trim().isEmpty ?? true) {
          return 'Form ini dibutuhkan !';
        }
        if (passwdC.text != confirmPasswordText) {
          return 'Password tidak sama';
        }
        return null;
      };
}
