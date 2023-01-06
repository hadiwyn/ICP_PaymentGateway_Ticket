import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import '../splash/splash_screen.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            onPressed: () {
              sigOut();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SplashScreen()));
            },
            icon: const Icon(
              Icons.logout,
              size: 24.0,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
        ),
      ),
    );
    ;
  }

  void sigOut() {
    FirebaseAuth.instance.signOut();
    Get.deleteAll();
    Get.reloadAll();
  }
}
