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

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late String date;
  // ignore: non_constant_identifier_names
  var transaction_id = '';

  int _quantity = 1;
  // ignore: non_constant_identifier_names
  int total_price = 0;

  String uName = "";
  String uEmail = "";
  String uPhone = "";

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

        // nama_pemesan.text = uName!;
      }
      print(uName);
      print(uEmail);
      print(uPhone);
    });
  }

  @override
  void initState() {
    getUsers().then((value) {
      nama_pemesan.text = uName;
    }).catchError((error) {
      print("Error getting user data: $error");
    });
    dateInput.text = "";
    peopleInput.text = "1";
    totalHarga.text = "Rp. ${widget.detail["harga"]}";
    total_price = int.parse(widget.detail["harga"]);
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
        iconTheme: const IconThemeData(color: Colors.black),
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
                    color: const Color(0x34000000),
                    offset: const Offset(0, 3),
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
                      decoration: const BoxDecoration(
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
                      child: const Center(
                          child: Text(
                        "Mohon isi data dibawah ini !",
                        style: TextStyle(
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
                    const Padding(
                      padding: EdgeInsets.only(top: 40, left: 12),
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
                                      icon: const Icon(Icons.people),
                                      labelText:
                                          "Jumlah Orang"), // Only numbers can be entered
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15, left: 20),
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: OutlinedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                      side: const BorderSide(color: Colors.red),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _quantity -= 1;
                                    total_price = total_price - harga;
                                    peopleInput.text = _quantity.toString();
                                    totalHarga.text =
                                        "Rp. ${total_price.toString()}";
                                  });
                                  // for (int i = 0; i > _quantity; i--) {
                                  //   totalPrice -= harga;
                                  // }
                                  print(_quantity);
                                  print(total_price);
                                  print(harga);
                                },
                                child: const Icon(
                                  Icons.remove,
                                  size: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: OutlinedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    side: const BorderSide(color: Colors.red),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  _quantity += 1;
                                  total_price =
                                      int.parse(widget.detail["harga"]);
                                  total_price *= _quantity;
                                  peopleInput.text = _quantity.toString();
                                  totalHarga.text =
                                      "Rp. ${total_price.toString()}";
                                });
                                print(_quantity);
                                print(total_price);
                                print(harga);
                              },
                              child: const Icon(
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
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: InkWell(
                onTap: () {
                  print(uName);
                  if (widget._formKey.currentState != null &&
                      widget._formKey.currentState!.validate()) {
                    addProduct(uName, widget.detail['nama'], uPhone, _quantity,
                        harga, total_price, date, "Unpaid");
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
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
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                      child: Text(
                    "Pesan Sekarang",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
                ),
              ),
            ),
            const Spacer()
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

  Future<void> addProduct(String name, String tourName, String phone, int qty,
      int price, int totalPrice, String dateVisit, String status) async {
    CollectionReference product = firestore.collection("transaction");
    String dateAdd = DateFormat("dd MMM yyyy").format(DateTime.now());

    final DocumentReference doc = await product.add({
      "nama": name,
      "nama_wisata": tourName,
      "phone": phone,
      "jumlah": qty,
      "harga": price,
      "total_harga": totalPrice,
      "tanggal_kunjungan": dateVisit,
      "tanggal_dibuat": dateAdd,
      "status": status,
    });

    // ignore: non_constant_identifier_names
    final String ID = doc.id;
    doc.update({'transaction_id': ID});

    setState(() {
      transaction_id = ID;
    });

    int harga = int.parse(widget.detail["harga"]);

    Get.off(MidtransView(
      transaction_id: transaction_id,
      count: harga,
      name_product: widget.detail["nama"],
      quantity: _quantity,
      totalPrice: total_price,
      date: date,
      dateAdd: dateAdd,
      name: name,
      email: uEmail,
      phone: uPhone,
    ));
  }
}
