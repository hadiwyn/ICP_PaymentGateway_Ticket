import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ticket_wisata_donorojo/app/modules/admin/detail%20wisata/detailWisata_admin.dart';
import 'package:ticket_wisata_donorojo/app/modules/user/dashboard/detail_wisata.dart';
import 'package:ticket_wisata_donorojo/app/modules/user/dashboard/pesan_tiket.dart';

// ignore: camel_case_types, must_be_immutable
class ListViewAdmin extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables

  @override
  State<ListViewAdmin> createState() => _listViewAdminState();
}

class _listViewAdminState extends State<ListViewAdmin> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late double count;

  Future<QuerySnapshot<Object?>> getData() {
    CollectionReference wisata = firestore.collection("wisata");

    return wisata.get();
  }

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference wisata = firestore.collection("wisata");
    return wisata.orderBy("time", descending: true).snapshots();
  }

  Future<void> lenghtData() async {
    CollectionReference wisataCollection =
        FirebaseFirestore.instance.collection('wisata');
    QuerySnapshot querySnapshot = await wisataCollection.get();
    count = querySnapshot.size as double;
    print('Jumlah dokumen di koleksi "wisata": $count');
  }

  @override
  void initState() {
    lenghtData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Object?>>(
      stream: streamData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          var listAllDoc = snapshot.data!.docs;
          return SingleChildScrollView(
            child: SizedBox(
              height: listAllDoc.length.toDouble() * 130,
              width: double.infinity,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                //shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: listAllDoc.length,
                itemBuilder: (BuildContext context, int index) => Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 82,
                        height: 106,
                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Image.network(
                              "${(listAllDoc[index].data() as Map<String, dynamic>)["image_1"]}",
                            ).image,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color(0xFF656565),
                            width: 0.5,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          var detail =
                              listAllDoc[index].data() as Map<String, dynamic>;
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              // return DetailWisata(detail: detail);
                              return DetailWisataAdmin(detail);
                            }),
                          );
                        },
                        child: Container(
                          width: 260,
                          height: 106,
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
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ignore: prefer_const_constructors
                              Padding(
                                // ignore: prefer_const_constructors
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(12, 8, 0, 0),
                                // ignore: prefer_const_constructors
                                child: Text(
                                  "${(listAllDoc[index].data() as Map<String, dynamic>)["nama"]}",
                                  textAlign: TextAlign.start,
                                  // ignore: prefer_const_constructors
                                  style: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.blueGrey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              // ignore: prefer_const_constructors
                              Padding(
                                // ignore: prefer_const_constructors
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12, 5, 12, 0),
                                // ignore: prefer_const_constructors
                                child: Text(
                                  "${(listAllDoc[index].data() as Map<String, dynamic>)["deskripsi"]}",
                                  // softWrap: false,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  // ignore: prefer_const_constructors
                                  style: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              Spacer(),
                              if (((listAllDoc[index].data()
                                      as Map<String, dynamic>)["locatiton"]) !=
                                  null)
                                Padding(
                                  // ignore: prefer_const_constructors
                                  padding: EdgeInsets.only(
                                      left: 12, bottom: 10, right: 12),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      // ignore: prefer_const_constructors
                                      Icon(
                                        Icons.price_change,
                                        color: Colors.blueGrey,
                                        size: 12,
                                      ),
                                      // ignore: prefer_const_constructors
                                      Padding(
                                        // ignore: prefer_const_constructors
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5, 0, 0, 0),
                                        // ignore: prefer_const_constructors
                                        child: Text(
                                          "${(listAllDoc[index].data() as Map<String, dynamic>)["harga"]}",
                                          // ignore: prefer_const_constructors
                                          style: TextStyle(
                                            fontFamily: 'Lexend Deca',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      // ignore: prefer_const_constructors
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        // ignore: prefer_const_constructors
                                        child: Icon(
                                          Icons.timelapse,
                                          color: Colors.blueGrey,
                                          size: 12,
                                        ),
                                      ),
                                      // igčore: prefer_const_constructors
                                      Padding(
                                        // ignore: prefer_const_constructors
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5, 0, 0, 0),

                                        // ignore: prefer_const_constructors
                                        child: Text(
                                          // ignore: prefer_interpolation_to_compose_strings
                                          "${(listAllDoc[index].data() as Map<String, dynamic>)["time"]}",
                                          // ignore: prefer_const_constructors
                                          style: TextStyle(
                                            fontFamily: 'Lexend Deca',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, bottom: 10, right: 12),
                                child: Text(
                                  "Lokasi dibutuhkan, ubah data sekarang !",
                                  style: TextStyle(
                                      fontFamily: 'Lexend Deca',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
