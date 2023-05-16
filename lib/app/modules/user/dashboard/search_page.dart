import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ticket_wisata_donorojo/app/modules/user/dashboard/detail_wisata.dart';

class SearchPage extends StatefulWidget {
  final String searchQuery;

  SearchPage({required this.searchQuery});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hasil Pencarian'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('wisata') // Nama koleksi di Firebase Firestore
            .where('nama',
                isEqualTo:
                    toTitleCase(widget.searchQuery)) // Field yang ingin dicari
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          print(snapshot);
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.docs.length == 0) {
            return Center(
              child: Text("Data tidak ditemukan"),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot document = snapshot.data!.docs[index];
                  return InkWell(
                    onTap: () {
                      var detail = snapshot.data!.docs[index].data()
                          as Map<String, dynamic>;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return DetailWisata(detail);
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
                              document["nama"],
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
                            padding:
                                EdgeInsetsDirectional.fromSTEB(12, 5, 12, 0),
                            // ignore: prefer_const_constructors
                            child: Text(
                              document["deskripsi"],
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
                                    document["harga"],
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
                                    document["time"],
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
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  String toTitleCase(String text) {
    if (text == null || text.isEmpty) {
      return '';
    }
    final words = text.split(' ');
    final capitalizedWords = words.map((word) {
      final firstLetter = word.substring(0, 1).toUpperCase();
      final remainingLetters = word.substring(1).toLowerCase();
      return '$firstLetter$remainingLetters';
    });
    return capitalizedWords.join(' ');
  }
}
