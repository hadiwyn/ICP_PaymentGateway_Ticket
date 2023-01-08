import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticket_wisata_donorojo/app/modules/splash/first_page.dart';

import '../../routes/app_pages.dart';
import '../admin/home_admin.dart';
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
      body: Column(children: [
        Spacer(),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(
            left: 40,
            right: 40,
          ),
          child: Image.asset(
            'assets/image/logo-pacitan.webp',
          ),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(left: 40, right: 40),
          child: Image.asset(
            'assets/image/logo.png',
          ),
        ),
        Spacer(),
        Spacer(),
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
              Get.off(HomeAdmin());
            } else if (snapshot.get('role') == 'user') {
              Get.off(Home());
            }
          });
        } else {
          Get.off(FirstPage());
        }
      });
    });
  }
}
