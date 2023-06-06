// ignore_for_file: must_be_immutable

import 'package:WisataKU/app/modules/admin/update_data/update_data.dart';
import 'package:WisataKU/app/modules/user/dashboard/page_view.dart';
import 'package:WisataKU/app/modules/user/dashboard/pesan_tiket.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailWisataAdmin extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var detail;

  DetailWisataAdmin(this.detail, {super.key});

  @override
  State<DetailWisataAdmin> createState() => _DetailWisataAdminState();
}

class _DetailWisataAdminState extends State<DetailWisataAdmin> {
  CollectionReference users = FirebaseFirestore.instance.collection('wisata');

  void launchMap(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: 430,
            child: PageViewAutoSlide(widget.detail),
          ),
          // Container(
          //   height: 430,
          //   width: double.infinity,
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //         image: AssetImage('assets/image/pangasan.jpeg'),
          //         fit: BoxFit.cover),
          //   ),
          // ),
          Positioned(
            left: 15,
            top: 35,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.black.withOpacity(0.2)),
                child: const Center(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 380),
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      widget.detail['nama'],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      children: [
                        const Spacer(),
                        Icon(
                          Icons.location_pin,
                          size: 16.0,
                          color: widget.detail['location'] != null
                              ? Colors.black54
                              : Colors.red,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 20),
                          child: InkWell(
                            onTap: () {
                              // Get.off(Location());
                              launchMap(widget.detail['location']);
                            },
                            child: Text(
                              widget.detail['location'] != null
                                  ? "Dapatkan Arah"
                                  : "Location Required !",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: widget.detail['location'] != null
                                      ? Colors.black54
                                      : Colors.red),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, left: 10),
                    child: Text(
                      "Overview",
                      style: TextStyle(
                          color: Color.fromARGB(255, 93, 193, 255),
                          fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        widget.detail["deskripsi"],
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.price_change,
                                  size: 24.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Text(
                                    widget.detail['harga'],
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                            const Text("Per Orang"),
                          ],
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Get.off(PesanTiket(widget.detail));
                          },
                          child: InkWell(
                            onTap: () {
                              Get.defaultDialog(
                                  title: "Hapus Data",
                                  middleText:
                                      "Data akan terhapus secara permanen Apakah anda yakin ?",
                                  textConfirm: "Hapus",
                                  onConfirm: () {
                                    deleteUser();
                                    Get.back();
                                    Get.back();
                                  },
                                  confirmTextColor: Colors.white,
                                  textCancel: "Batal");
                            },
                            child: Container(
                              width: 100,
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
                              child: const Center(
                                child: Text(
                                  "Hapus Data",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Get.off(UpdateData(widget.detail));
                          },
                          child: Container(
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 93, 193, 255),
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
                            child: const Center(
                              child: Text(
                                "Ubah Data",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> deleteUser() {
    return users
        .doc(widget.detail['id'])
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }
}
