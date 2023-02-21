import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ticket_wisata_donorojo/app/modules/user/dashboard/page_view.dart';

import 'list_view.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot<Object?>> getData() {
    CollectionReference wisata = firestore.collection("wisata");

    return wisata.get();
  }

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference wisata = firestore.collection("wisata");
    return wisata.orderBy("time", descending: true).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Object?>>(
        stream: streamData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var listAllDocument = snapshot.data!.docs;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black38,
                            spreadRadius: 0,
                            blurRadius: 10),
                      ],
                    ),
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.only(
                    //       bottomRight: Radius.circular(30),
                    //       bottomLeft: Radius.circular(30)),
                    //   // boxShadow: [
                    //   //   BoxShadow(
                    //   //       color: Colors.black38,
                    //   //       spreadRadius: 0,
                    //   //       blurRadius: 10),
                    //   // ],
                    // ),
                    child: Column(children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(top: 12),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height: 150,
                                child: Stack(
                                  // ignore: prefer_const_literals_to_cre
                                  // ate_immutables
                                  children: [
                                    pageView(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ]),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 10),
                        child: Text(
                          "Daftar Wisata",
                          style: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Colors.blueGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //     height: 400,
                  //     width: double.infinity,
                  //     child: listView(listAllDocument)),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
