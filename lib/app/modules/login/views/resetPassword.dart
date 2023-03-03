import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticket_wisata_donorojo/app/routes/app_pages.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController emailC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Reset Password"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Masukkan email anda untuk melakukan reset password !"),
              Container(
                padding: const EdgeInsets.only(top: 20),
                margin: const EdgeInsets.only(),
                child: TextFormField(
                  controller: emailC,
                  // initialValue: 'John Doe',
                  maxLength: 20,
                  decoration: const InputDecoration(
                    // labelText: 'Name',
                    labelStyle: TextStyle(
                      color: Colors.blueGrey,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                      ),
                    ),
                    // helperText: "What's your name?",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                  ),
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: emailC.text);

                      await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                  title: Text('Reset Password'),
                                  content: Text(
                                      "Link berhasil dikirim ke email kamu, Segera lakukan pengubahan password !"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Get.off(Routes.LOGIN);
                                      },
                                      child: Text("Oke"),
                                    )
                                  ]));
                    } on FirebaseAuthException catch (e) {
                      _handleSigupError(e);
                    }
                  },
                  child: const Text("Reset Password"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
