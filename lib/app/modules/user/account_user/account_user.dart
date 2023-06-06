import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../splash/first_page.dart';

class AccountUser extends StatefulWidget {
  const AccountUser({super.key});

  @override
  State<AccountUser> createState() => _AccountUserState();
}

class _AccountUserState extends State<AccountUser> {
  String? uName = "";
  String? uEmail = "";
  String? uPhone = "";
  String? uImage = "";
  String imgUrl = "";

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
          uImage = snapshot.data()!['image'];
        });
      }
      print(uName);
      print(uEmail);
      print(uPhone);
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> uploadImg() async {
    final ImagePicker picker = ImagePicker();
    final XFile? img = await picker.pickImage(source: ImageSource.gallery);

    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference ref = FirebaseStorage.instance.ref().child("profiles");
    Reference imgUpload = ref.child(fileName);

    try {
      await imgUpload.putFile(File(img!.path));

      imgUrl = await imgUpload.getDownloadURL();
    } catch (error) {}

    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"image": imgUrl});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Color.fromARGB(255, 93, 193, 255)),
          // title: Image.asset(
          //   'assets/image/logo-pacitan.webp',
          //   height: 40,
          //   fit: BoxFit.fitWidth,
          // ),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
                  Get.off(const FirstPage());
                },
                icon: const Icon(Icons.logout)),
            // )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: Column(children: [
                  Container(
                    child: CircleAvatar(
                      radius: 85.0,
                      backgroundColor: Colors.grey,
                      backgroundImage: uImage == null
                          ? Image.asset("assets/image/user.png").image
                          : Image.network(uImage!).image,
                    ),
                  ),
                  Container(
                      child: ElevatedButton(
                          onPressed: uploadImg,
                          child: const Icon(Icons.photo_camera)))
                ]),
              ),
              PhysicalModel(
                color: Colors.white,
                elevation: 3,
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  width: double.infinity,
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          child: Row(
                        children: [
                          const Icon(
                            Icons.person_outline,
                            color: Colors.blue,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              uName!,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      )),
                      Container(
                          child: Row(
                        children: [
                          const Icon(
                            Icons.email_outlined,
                            color: Colors.blue,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              uEmail!,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ],
                      )),
                      Container(
                          child: Row(
                        children: [
                          const Icon(
                            Icons.phone,
                            color: Colors.blue,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            uPhone!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  void editData(value, data) {
    showModalBottomSheet(
        // isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: context,
        builder: (contexy) => Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "Ubah $data Kamu",
                    style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey),
                  ),
                  const Spacer(
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
                  const Spacer(),
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
                            color: const Color(0x34000000),
                            offset: const Offset(0, 3),
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
                  const Spacer(
                    flex: 3,
                  )
                ],
              ),
            ));
  }
}
