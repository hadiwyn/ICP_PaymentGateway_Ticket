import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../splash/first_page.dart';

class AccountUser extends StatefulWidget {
  AccountUser({super.key});

  @override
  State<AccountUser> createState() => _AccountUserState();
}

class _AccountUserState extends State<AccountUser> {
  String? uName = "";
  String? uEmail = "";
  String? uPhone = "";

  Future<void> getData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          uName = snapshot.data()!['nama_lengkap'];
          uEmail = snapshot.data()!['email'];
          uPhone = snapshot.data()!['no_tlp'];
        });
      }
      print(uName);
      print(uEmail);
      print(uPhone);
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          iconTheme: IconThemeData(color: Color.fromARGB(255, 93, 193, 255)),
          // title: Image.asset(
          //   'assets/image/logo-pacitan.webp',
          //   height: 40,
          //   fit: BoxFit.fitWidth,
          // ),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Spacer(),
              Center(
                child: CircleAvatar(
                  radius: 40.0,
                  backgroundImage: NetworkImage(
                    "https://i.ibb.co/PGv8ZzG/me.jpg",
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 10),
                child: Row(
                  children: [
                    Text("Nama Lengkap"),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Text(
                        uName!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Spacer(),
                      // IconButton(
                      //   onPressed: () {
                      //     editData(uName, 'Nama Lengkap');
                      //   },
                      //   icon: const Icon(
                      //     Icons.edit,
                      //     size: 20.0,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 10),
                child: Row(
                  children: [
                    Text("Email"),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
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
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                  ),
                  child: Row(
                    children: [
                      Text(
                        uEmail!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Spacer(),
                      // IconButton(
                      //   onPressed: () {
                      //     editData(uEmail, 'Email');
                      //   },
                      //   icon: const Icon(
                      //     Icons.edit,
                      //     size: 20.0,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 10),
                child: Row(
                  children: [
                    Text("Nomor Telepon"),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Text(
                        uPhone!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Spacer(),
                      // IconButton(
                      //   onPressed: () {
                      //     editData(uPhone, 'Nomor Telepon');
                      //   },
                      //   icon: const Icon(
                      //     Icons.edit,
                      //     size: 20.0,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ));
  }

  void editData(value, data) {
    showModalBottomSheet(
        // isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: context,
        builder: (contexy) => Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "Ubah ${data} Kamu",
                    style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(),
                    child: TextFormField(
                      initialValue: value,
                      maxLength: 20,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(
                          color: Colors.blueGrey,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: 150,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                      child: Center(
                          child: Text(
                        "Ubah",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey),
                      )),
                    ),
                  ),
                  Spacer(
                    flex: 3,
                  )
                ],
              ),
            ));
  }
}
