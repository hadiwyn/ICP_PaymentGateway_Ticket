// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:get/get.dart';
import 'package:ticket_wisata_donorojo/app/modules/user/dashboard/detail_ticket.dart';

class RiwayatTiket extends StatefulWidget {
  const RiwayatTiket({Key? key}) : super(key: key);

  @override
  State<RiwayatTiket> createState() => _RiwayatTiketState();
}

class _RiwayatTiketState extends State<RiwayatTiket> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  CollectionReference data_transaction =
      FirebaseFirestore.instance.collection('transaction');

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<List<Order>> fetchData() async {
    MySqlConnection connection = await getConnection();
    Results results = await connection.query('SELECT * FROM orders');
    await connection.close();

    List<Order> orderList = []; // buat variabel list kosong
    for (var row in results) {
      Order order = Order.fromMap(
          row.fields); // buat objek Order dari tiap baris hasil query
      orderList.add(order); // tambahkan objek Order ke dalam list
    }

    for (Order order in orderList) {
      DocumentReference docRef = data_transaction.doc(order.id);

      docRef.get().then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          var data = documentSnapshot.data() as Map<String, dynamic>;
          if (data != null) {
            if (data['status'] != 'Paid') {
              data_transaction
                  .doc(order.id)
                  .update({
                    'status': order.status,
                  })
                  .then((value) => print("Data Transaction Updated"))
                  .catchError((error) =>
                      print("Failed to update Data Transaction: $error"));
            }
          }
        } else {
          // Document doesn't exist in Firestore
          print('Document does not exist in Firestore');
        }
      }).catchError((error) {
        // An error occurred while fetching the document
        print('Error fetching document: $error');
      });
    }

    setState(() {}); // tambahkan setState untuk memperbarui tampilan

    return orderList; // kembalikan list yang telah diisi dengan objek Order
  }

  Future<MySqlConnection> getConnection() async {
    var settings = new ConnectionSettings(
        host: 'mr-code.my.id',
        port: 3306,
        user: 'root',
        password: 'Sinoman86!',
        db: 'belajar_midtrans');
    return await MySqlConnection.connect(settings);
  }

  Future<void> addProduct(
      int id,
      String name,
      String tour_name,
      String phone,
      int qty,
      String price,
      String total_price,
      String date_visit,
      String date_add,
      String status) async {
    // CollectionReference product = firestore.collection("wisata");

    final DocumentReference doc = await data_transaction.add({
      "transaction_id": id,
      "nama_wisata": tour_name,
      "nama": name,
      "phone": phone,
      // 'email': emailCurrentUser,
      "jumlah": qty,
      "harga": price,
      "total_harga": total_price,
      "tanggal_kunjungan": date_visit,
      "tanggal_pembelian": date_add,
      "status": status,
    });
  }

  Future<void> deleteData(String id) async {
    // Delete data from MySQL
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'mr-code.my.id',
        port: 3306,
        user: 'root',
        password: 'Sinoman86!',
        db: 'belajar_midtrans'));

    await conn.query('DELETE FROM orders WHERE id = ?', [id]);

    await conn.close();

    try {
      await FirebaseFirestore.instance
          .collection('transaction')
          .doc(id)
          .delete();
      print('Dokumen berhasil dihapus!');
    } catch (e) {
      print('Error: $e');
    }
  }

  List<Order> _orders = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            // ignore: prefer_const_constructors
            Spacer(),
            const Text(
              "Riwayat Tiket",
              style: const TextStyle(color: Colors.black),
            ),
            Spacer(),
          ],
        ),
        actions: const [],
        elevation: 0,
      ),
      body: FutureBuilder<List<Order>>(
        future: fetchData(),
        builder: (BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
          if (snapshot.hasData) {
            List<Order>? orders = snapshot.data?.reversed.toList();
            return Align(
              alignment: Alignment.topCenter,
              child: ListView.builder(
                itemCount: orders?.length,
                itemBuilder: (BuildContext context, int index) {
                  Order order = orders![index];

                  if (order.status != 'Paid') {
                    return Container(); // jika tidak sama, maka tidak ditampilkan
                  }
                  if (auth.currentUser!.displayName != order.name) {
                    return Container(); // jika tidak sama, maka tidak ditampilkan
                  }
                  return InkWell(
                    onTap: () {
                      Get.to(DetailTicket(
                          order.tour_name,
                          order.id,
                          order.name,
                          order.phone,
                          order.date_add,
                          order.date_visit,
                          order.qty,
                          order.status));
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 6,
                            color: Color(0x34000000),
                            offset: Offset(0, 3),
                          )
                        ],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Tiket Wisata ${order.tour_name}",
                                      style: TextStyle(
                                        fontFamily: 'Lexend Deca',
                                        color: Colors.blueGrey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Spacer(),
                                    InkWell(
                                      onTap: () async {
                                        bool confirm = false;
                                        await showDialog<void>(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('Confirm'),
                                              content: SingleChildScrollView(
                                                child: ListBody(
                                                  children: const <Widget>[
                                                    Text(
                                                        'Are you sure you want to delete this item?'),
                                                  ],
                                                ),
                                              ),
                                              actions: <Widget>[
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.grey[600],
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("No"),
                                                ),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.blueGrey,
                                                  ),
                                                  onPressed: () {
                                                    confirm = true;
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("Yes"),
                                                ),
                                              ],
                                            );
                                          },
                                        );

                                        if (confirm) {
                                          deleteData(order.id);
                                          setState(() {
                                            fetchData();
                                          });
                                          print("Confirmed!");
                                        }
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                        size: 24.0,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Text(
                                  "Jumlah : ${order.qty}",
                                  // ignore: prefer_const_constructors
                                  style: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                // ignore: prefer_const_constructors
                                Spacer(),
                                Row(
                                  children: [
                                    // ignore: prefer_const_constructors
                                    Icon(
                                      Icons.price_change,
                                      color: Colors.blueGrey,
                                      size: 12,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      'Rp.${order.total_price},00',
                                      // ignore: prefer_const_constructors
                                      style: TextStyle(
                                        fontFamily: 'Lexend Deca',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    Spacer(
                                      flex: 6,
                                    ),
                                    Text(
                                      'Berlaku sampai ${order.date_visit}',
                                      // ignore: prefer_const_constructors
                                      style: TextStyle(
                                        fontFamily: 'Lexend Deca',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      order.status == 'Paid'
                                          ? Icons.verified
                                          : Icons.timelapse,
                                      color: order.status == 'Paid'
                                          ? Colors.blue
                                          : Colors.red,
                                      size: 24,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class Order {
  final String id;
  final String name;
  final String tour_name;
  final String phone;
  final int total_price;
  final String date_add;
  final String date_visit;
  final int qty;
  final String status;

  Order(
      {required this.id,
      required this.name,
      required this.tour_name,
      required this.phone,
      required this.total_price,
      required this.date_add,
      required this.date_visit,
      required this.qty,
      required this.status});

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      name: map['name'],
      tour_name: map['tour_name'],
      phone: map['phone'],
      date_add: map['date_add'],
      date_visit: map['date_visit'],
      total_price: map['total_price'],
      qty: map['qty'],
      status: map['status'],
    );
  }
}
