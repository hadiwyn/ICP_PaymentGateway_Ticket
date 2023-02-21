import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ticket_wisata_donorojo/app/modules/user/dashboard/list_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? nama = "";

  Future<void> getData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          nama = snapshot.data()!['nama_lengkap'];
        });
      }
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
      body: SingleChildScrollView(
          child: Stack(
        children: [
          Container(
            color: Color.fromARGB(255, 93, 193, 255),
            height: 300,
          ),
          // Positioned(
          //   right: 5,
          //   top: 20,
          //   child: Image.asset(
          //     "assets/image/logo.png",
          //     width: 90.0,
          //     height: 90.0,
          //     fit: BoxFit.fill,
          //   ),
          // ),
          Positioned(
            top: 40,
            left: 15,
            child: Text(
              "Selamat Datang",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Positioned(
            top: 60,
            left: 15,
            child: Text(
              nama!,
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 250),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.only(top: 130),
                child: listView(),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 170),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    "assets/image/image-travel.webp",
                    width: double.infinity,
                    height: 180.0,
                    fit: BoxFit.fill,
                  ),
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(top: 110, left: 15, right: 15),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 2.0,
                horizontal: 12.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      initialValue: null,
                      decoration: InputDecoration.collapsed(
                        filled: true,
                        fillColor: Color.fromARGB(0, 248, 245, 245),
                        hintText: "Kamu mau wisata kemana?",
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        hoverColor: Color.fromARGB(0, 248, 245, 245),
                      ),
                      onFieldSubmitted: (value) {},
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 370,
            left: 15,
            child: Text(
              "Pilih Wisata",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      )),
    );
  }
}
