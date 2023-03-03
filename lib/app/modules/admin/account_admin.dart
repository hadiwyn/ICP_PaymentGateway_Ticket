import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../splash/first_page.dart';

class AccountAdmin extends StatefulWidget {
  const AccountAdmin({super.key});

  @override
  State<AccountAdmin> createState() => _AccountAdminState();
}

class _AccountAdminState extends State<AccountAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        iconTheme: IconThemeData(color: Color.fromARGB(255, 22, 103, 196)),
        title: Image.asset(
          'assets/image/logo-pacitan.webp',
          height: 40,
          fit: BoxFit.fitWidth,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          // ignore: prefer_const_constructors
          // Padding(
          //   // ignore: prefer_const_constructors
          //   padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
          //   // ignore: prefer_const_constructors

          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Get.deleteAll();
                Get.off(FirstPage());
              },
              icon: Icon(Icons.logout)),
          // )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
        ),
      ),
    );
  }
}
