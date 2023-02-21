import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'midtrans_view.dart';

class PesanTiket extends StatefulWidget {
  var detail;

  final _formKey = GlobalKey<FormState>();

  PesanTiket(this.detail, {super.key});

  @override
  State<PesanTiket> createState() => _PesanTiketState();
}

class _PesanTiketState extends State<PesanTiket> {
  TextEditingController dateInput = TextEditingController();
  TextEditingController peopleInput = TextEditingController();
  TextEditingController totalHarga = TextEditingController();
  TextEditingController nama_pemesan = TextEditingController();
  TextEditingController nama_wisata = TextEditingController();

  late String date;

  int _quantity = 1;
  int totalPrice = 0;

  String? uName = "";
  String? uEmail = "";
  String? uPhone = "";

  Future<void> getUsers() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        uName = snapshot.data()!['nama_lengkap'];
        uEmail = snapshot.data()!['email'];
        uPhone = snapshot.data()!['no_tlp'];

        nama_pemesan.text = uName!;
      }
    });
  }

  @override
  void initState() {
    getUsers();
    dateInput.text = "";
    peopleInput.text = "1";
    totalHarga.text = "Rp. ${widget.detail["harga"]}";
    totalPrice = int.parse(widget.detail["harga"]);
    print(totalPrice);
    nama_wisata.text = widget.detail['nama'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int harga = int.parse(widget.detail["harga"]);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Pesan Tiket",
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
              child: Form(
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
                        "Mohon isi data dibawah ini !",
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
                        controller: nama_pemesan,
                        readOnly: true,
                        decoration: const InputDecoration(
                            labelText: "Nama Pemesan",
                            labelStyle: TextStyle(
                              color: Colors.blueGrey,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blueGrey,
                              ),
                            ),
                            helperText: "Data tidak bisa diubah !"),
                        onChanged: (value) {},
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(top: 15, left: 12, right: 12),
                      margin: const EdgeInsets.only(),
                      child: TextFormField(
                        controller: nama_wisata,
                        readOnly: true,
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
                            helperText: "Data tidak bisa diubah !"),
                        onChanged: (value) {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40, left: 12),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text("Jadwal Wisata")),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 17, right: 12),
                      child: TextFormField(
                        controller: dateInput,
                        validator: _requiredValidatorDate,
                        //editing controller of this TextField
                        // ignore: prefer_const_constructors
                        decoration: InputDecoration(
                            //icon of text field//label text of field
                            ),
                        readOnly: true,
                        //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2100));

                          if (pickedDate != null) {
                            print(
                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                                DateFormat("dd MMM yyyy").format(pickedDate);
                            print(
                                formattedDate); //formatted date output using intl package =>  2021-03-16
                            setState(() {
                              dateInput.text = formattedDate;
                              date =
                                  formattedDate; //set output date to TextField value.
                            });
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: peopleInput,
                              enabled: false,
                              decoration:
                                  // ignore: prefer_const_constructors
                                  InputDecoration(
                                      icon: Icon(Icons.people),
                                      labelText:
                                          "Jumlah Orang"), // Only numbers can be entered
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15, left: 20),
                            child: Container(
                              width: 50,
                              height: 50,
                              child: OutlinedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                      side: BorderSide(color: Colors.red),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _quantity -= 1;
                                    totalPrice = totalPrice - harga;
                                    peopleInput.text = _quantity.toString();
                                    totalHarga.text =
                                        "Rp. ${totalPrice.toString()}";
                                  });
                                  // for (int i = 0; i > _quantity; i--) {
                                  //   totalPrice -= harga;
                                  // }
                                  print(_quantity);
                                  print(totalPrice);
                                  print(harga);
                                },
                                child: Icon(
                                  Icons.remove,
                                  size: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            child: OutlinedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    side: BorderSide(color: Colors.red),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  _quantity += 1;
                                  totalPrice =
                                      int.parse(widget.detail["harga"]);
                                  totalPrice *= _quantity;
                                  peopleInput.text = _quantity.toString();
                                  totalHarga.text =
                                      "Rp. ${totalPrice.toString()}";
                                });
                                print(_quantity);
                                print(totalPrice);
                                print(harga);
                              },
                              child: Icon(
                                Icons.add,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: TextField(
                        controller: totalHarga,
                        enabled: false,
                        decoration:
                            // ignore: prefer_const_constructors
                            InputDecoration(
                                icon: const Icon(Icons.price_change),
                                labelText:
                                    "Total Harga"), // Only numbers can be entered
                      ),
                    ),
                  ]),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: InkWell(
                onTap: () {
                  if (widget._formKey.currentState != null &&
                      widget._formKey.currentState!.validate()) {
                    Get.off(MidtransView(
                      count: harga,
                      name_product: widget.detail["nama"],
                      quantity: _quantity,
                      totalPrice: totalPrice,
                      date: date,
                      name: uName!,
                      email: uEmail!,
                      phone: uPhone!,
                    ));
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
                  child: Center(
                      child: Text(
                    "Pesan Sekarang",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
                ),
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }

  String? _requiredValidatorDate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Pilih jadwal wisata anda';
    } else {
      return null;
    }
  }
}
