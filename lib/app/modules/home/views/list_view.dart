import 'package:flutter/material.dart';
import 'package:ticket_wisata_donorojo/app/modules/home/views/detail_wisata.dart';

// ignore: camel_case_types, must_be_immutable
class listView extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var listAllDocument;

  listView(this.listAllDocument, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: listAllDocument.length,
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
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
                  image: Image.asset(
                    'assets/image/klayar.jpeg',
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
                    listAllDocument[index].data() as Map<String, dynamic>;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return DetailWisata(detail: detail);
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
                      padding: EdgeInsetsDirectional.fromSTEB(12, 8, 0, 0),
                      // ignore: prefer_const_constructors
                      child: Text(
                        "${(listAllDocument[index].data() as Map<String, dynamic>)["nama"]}",
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
                      padding: EdgeInsetsDirectional.fromSTEB(12, 5, 12, 0),
                      // ignore: prefer_const_constructors
                      child: Text(
                        "${(listAllDocument[index].data() as Map<String, dynamic>)["deskripsi"]}",
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                          fontFamily: 'Lexend Deca',
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Padding(
                      // ignore: prefer_const_constructors
                      padding: EdgeInsetsDirectional.fromSTEB(12, 5, 0, 0),
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
                            padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                            // ignore: prefer_const_constructors
                            child: Text(
                              "${(listAllDocument[index].data() as Map<String, dynamic>)["harga"]}",
                              // ignore: prefer_const_constructors
                              style: TextStyle(
                                fontFamily: 'Lexend Deca',
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
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
                            padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),

                            // ignore: prefer_const_constructors
                            child: Text(
                              // ignore: prefer_interpolation_to_compose_strings
                              "${(listAllDocument[index].data() as Map<String, dynamic>)["time"]}",
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
            ),
          ],
        ),
      ),
    );
  }
}
