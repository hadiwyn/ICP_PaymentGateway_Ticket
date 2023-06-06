import 'package:WisataKU/app/modules/splash/first_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../admin/dashboard/home_admin.dart';
import '../user/dashboard/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    openHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Image.asset('assets/background/bg.jpg').color,
      body: Column(children: [
        const Spacer(),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(
            left: 40,
            right: 40,
          ),
          child: Image.asset(
            'assets/image/logo-pacitan.webp',
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Image.asset(
            'assets/image/logo.png',
          ),
        ),
        const Spacer(),
        const Spacer(),
      ]),
    );
  }

  openHome() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      User? user = FirebaseAuth.instance.currentUser;
      Future.delayed(const Duration(seconds: 2)).then((value) async {
        print(user);
        if (user != null) {
          print(user);
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get()
              .then((DocumentSnapshot snapshot) {
            if (snapshot.get('role') == 'admin') {
              Get.off(const HomeAdmin());
            } else if (snapshot.get('role') == 'user') {
              Get.off(const Home());
            }
          });
        } else {
          Get.off(const FirstPage());
        }
      });
    });
  }
}
