import 'package:WisataKU/app/modules/admin/create_data/index.dart';
import 'package:WisataKU/app/modules/admin/dashboard/listView_admin.dart';
import 'package:WisataKU/app/modules/admin/scanner/barcode_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

class HomeViewAdmin extends StatefulWidget {
  const HomeViewAdmin({super.key});

  @override
  State<HomeViewAdmin> createState() => _HomeViewAdminState();
}

class _HomeViewAdminState extends State<HomeViewAdmin> {
  String? nama = "";

  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

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

  bool _showFab = true;

  void _toggleFabVisibility() {
    setState(() {
      _showFab = !_showFab;
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
            color: const Color.fromARGB(255, 93, 193, 255),
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
          const Positioned(
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
              "${nama!} - Admin",
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 250),
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Colors.white),
              child: const Padding(
                padding: EdgeInsets.only(top: 130),
                child: ListViewAdmin(),
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
                      offset: const Offset(0, 3), // changes position of shadow
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
          // Padding(
          //   padding: const EdgeInsets.only(top: 110, left: 15, right: 15),
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(
          //       vertical: 2.0,
          //       horizontal: 12.0,
          //     ),
          //     decoration: BoxDecoration(
          //       color: Colors.white.withOpacity(0.3),
          //       borderRadius: const BorderRadius.all(
          //         Radius.circular(20.0),
          //       ),
          //     ),
          //     child: Row(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: Icon(
          //             Icons.search,
          //             color: Color.fromARGB(255, 255, 255, 255),
          //           ),
          //         ),
          //         Expanded(
          //           child: TextFormField(
          //             style: TextStyle(color: Colors.white),
          //             initialValue: null,
          //             decoration: InputDecoration.collapsed(
          //               filled: true,
          //               fillColor: Color.fromARGB(0, 248, 245, 245),
          //               hintText: "Kamu mau wisata kemana?",
          //               hintStyle: TextStyle(
          //                 color: Color.fromARGB(255, 255, 255, 255),
          //               ),
          //               hoverColor: Color.fromARGB(0, 248, 245, 245),
          //             ),
          //             onFieldSubmitted: (value) {},
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          const Positioned(
            top: 370,
            left: 15,
            child: Text(
              "Daftar Wisata",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      )),
      floatingActionButton: SpeedDial(
        // animatedIcon: AnimatedIcons.menu_close,
        // animatedIconTheme: IconThemeData(size: 22.0),
        // / This is ignored if animatedIcon is non null
        // child: Text("open"),
        // activeChild: Text("close"),
        icon: Icons.add,
        activeIcon: Icons.close,
        spacing: 3,
        openCloseDial: isDialOpen,
        childPadding: const EdgeInsets.all(5),
        spaceBetweenChildren: 4,

        // overlayColor: Colors.black,
        // overlayOpacity: 0.5,
        onOpen: () => debugPrint('OPENING DIAL'),
        onClose: () => debugPrint('DIAL CLOSED'),
        tooltip: 'Open Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        // foregroundColor: Colors.black,
        // backgroundColor: Colors.white,
        // activeForegroundColor: Colors.red,
        // activeBackgroundColor: Colors.blue,
        elevation: 8.0,
        animationCurve: Curves.elasticInOut,
        isOpenOnStart: false,

        children: [
          SpeedDialChild(
            child: const Icon(Icons.add),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            label: 'Tambah Data',
            onTap: () => Get.to(const CreateData()),
          ),
          SpeedDialChild(
            child: const Icon(Icons.camera),
            backgroundColor: Colors.deepOrange,
            foregroundColor: Colors.white,
            label: 'Scan Tiket',
            onTap: () => Get.to(const BarcodeScan()),
          ),
        ],
      ),
    );
  }
}
