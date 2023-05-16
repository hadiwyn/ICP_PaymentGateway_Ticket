import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UpdateData extends StatefulWidget {
  var detail;

  final _formKey = GlobalKey<FormState>();

  UpdateData(this.detail, {super.key});

  @override
  State<UpdateData> createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  TextEditingController deskripsi = TextEditingController();
  TextEditingController nama_wisata = TextEditingController();
  TextEditingController harga_tiket = TextEditingController();
  TextEditingController locC = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('wisata');

  @override
  void initState() {
    nama_wisata.text = widget.detail['nama'];
    harga_tiket.text = widget.detail['harga'];
    deskripsi.text = widget.detail['deskripsi'];
    locC.text = widget.detail['location'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Ubah Data",
          style: TextStyle(color: Colors.black),
        ),
        // leading: Icon(
        //   Icons.arrow_back_ios,
        //   color: Colors.black,
        // ),
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        actions: const [],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 560,
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
              child: Stack(children: [
                Form(
                  key: widget._formKey,
                  child: SingleChildScrollView(
                    child: Column(children: [
                      Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            color: Color.fromARGB(255, 93, 193, 255),
                            boxShadow: [
                              // ignore: prefer_const_constructors
                              BoxShadow(
                                blurRadius: 6,
                                color: Color(0x34000000),
                                offset: Offset(0, 3),
                              )
                            ]),
                        child: Center(
                            child: Text(
                          "Pastikan data valid !",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.only(top: 10, left: 12, right: 12),
                        margin: const EdgeInsets.only(),
                        child: TextFormField(
                          controller: nama_wisata,
                          decoration: const InputDecoration(
                            labelText: "Nama Wisata",
                            labelStyle: TextStyle(
                              color: Colors.blueGrey,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                          onChanged: (value) {},
                        ),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.only(top: 20, left: 12, right: 12),
                        margin: const EdgeInsets.only(),
                        child: TextFormField(
                          controller: harga_tiket,
                          decoration: const InputDecoration(
                            labelText: "Harga Tiket",
                            labelStyle: TextStyle(
                              color: Colors.blueGrey,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                          onChanged: (value) {},
                        ),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.only(top: 20, left: 12, right: 12),
                        margin: const EdgeInsets.only(),
                        child: TextFormField(
                          maxLines: 8,
                          controller: deskripsi,
                          textAlign: TextAlign.justify,
                          decoration: const InputDecoration(
                            labelText: "Deskripsi",
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(
                              color: Colors.blueGrey,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                          onChanged: (value) {},
                        ),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.only(top: 20, left: 12, right: 12),
                        margin: const EdgeInsets.only(),
                        child: TextFormField(
                          controller: locC,
                          decoration: const InputDecoration(
                            labelText: "URL Lokasi",
                            labelStyle: TextStyle(
                              color: Colors.blueGrey,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blueGrey,
                              ),
                            ),
                          ),
                          onChanged: (value) {},
                        ),
                      ),
                      // Padding(
                      //   padding:
                      //       const EdgeInsets.only(top: 20, left: 12, right: 12),
                      //   child: Container(
                      //       padding: EdgeInsets.all(10),
                      //       width: double.infinity,
                      //       height: 150,
                      //       decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         // ignore: prefer_const_literals_to_create_immutables
                      //         boxShadow: [
                      //           // ignore: prefer_const_constructors
                      //           BoxShadow(
                      //             blurRadius: 6,
                      //             color: Color(0x34000000),
                      //             offset: Offset(0, 3),
                      //           )
                      //         ],
                      //         borderRadius: BorderRadius.circular(20),
                      //       ),
                      //       child: Row(
                      //         children: [
                      //           Spacer(),
                      //           ClipRRect(
                      //             borderRadius: BorderRadius.circular(10),
                      //             child: Image.network(
                      //               widget.detail['image_1'],
                      //               width: 100,
                      //               height: double.infinity,
                      //               fit: BoxFit.cover,
                      //             ),
                      //           ),
                      //           Spacer(),
                      //           ClipRRect(
                      //             borderRadius: BorderRadius.circular(10),
                      //             child: Image.network(
                      //               widget.detail['image_2'],
                      //               width: 100,
                      //               height: double.infinity,
                      //               fit: BoxFit.cover,
                      //             ),
                      //           ),
                      //           Spacer(),
                      //         ],
                      //       )),
                      // )
                    ]),
                  ),
                ),
                // Positioned.fill(
                //   bottom: 10,
                //   child: Align(
                //     alignment: Alignment.bottomCenter,
                //     child: InkWell(
                //       onTap: () {
                //         // to do list
                //       },
                //       child: Container(
                //         width: 40,
                //         height: 40,
                //         decoration: BoxDecoration(
                //           color: Colors.white,
                //           // ignore: prefer_const_literals_to_create_immutables
                //           boxShadow: [
                //             // ignore: prefer_const_constructors
                //             BoxShadow(
                //               blurRadius: 6,
                //               color: Color(0x34000000),
                //               offset: Offset(0, 3),
                //             )
                //           ],
                //           borderRadius: BorderRadius.circular(20),
                //         ),
                //         child: const Icon(
                //           Icons.edit,
                //           size: 24.0,
                //         ),
                //       ),
                //     ),
                //   ),
                // )
              ]),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: InkWell(
                onTap: () {
                  if (widget._formKey.currentState != null &&
                      widget._formKey.currentState!.validate()) {
                    // To Do List
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 93, 193, 255),
                    // ignore: prefer_const_literals_to_create_immutables
                    boxShadow: [
                      // ignore: prefer_const_constructors
                      BoxShadow(
                        blurRadius: 6,
                        color: Color(0x34000000),
                        offset: Offset(0, 3),
                      )
                    ],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: InkWell(
                    onTap: () {
                      Get.defaultDialog(
                        title: 'Ubah Data',
                        content: Text('Yakin ingin mengubah data ?'),
                        confirm: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey,
                          ),
                          onPressed: () {
                            updateUser();
                            Get.back();
                            Get.back();
                          },
                          child: const Text("Ubah"),
                        ),
                        cancel: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey,
                          ),
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text("Batal"),
                        ),
                      );
                    },
                    child: Center(
                        child: Text(
                      "Ubah Data",
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )),
                  ),
                ),
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }

  Future<void> updateUser() {
    return users
        .doc(widget.detail['id'])
        .update({
          'nama': nama_wisata.text,
          'harga': harga_tiket.text,
          'deskripsi': deskripsi.text,
          'location': locC.text
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}
