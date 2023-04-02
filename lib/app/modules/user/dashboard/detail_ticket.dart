// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, prefer_const_constructors
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class DetailTicket extends StatefulWidget {
  var tour_name;
  // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
  var id_trancaction;
  var name;
  var phone;
  var date_add;
  var date_visit;
  var qty;
  var status;

  DetailTicket(this.tour_name, this.id_trancaction, this.name, this.phone,
      this.date_add, this.date_visit, this.qty, this.status,
      {super.key});

  @override
  State<DetailTicket> createState() => _DetailTicketState();
}

class _DetailTicketState extends State<DetailTicket> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
// Mengambil tanggal dan waktu sekarang
    final now = DateTime.now().subtract(Duration(
      hours: DateTime.now().hour,
      minutes: DateTime.now().minute,
      seconds: DateTime.now().second,
      milliseconds: DateTime.now().millisecond,
      microseconds: DateTime.now().microsecond,
    ));

// Membuat formatter untuk tanggal dengan format 'dd MMM yyyy'
    final formatter = DateFormat('dd MMM yyyy');

// Mengubah tanggal yang ditentukan menjadi DateTime object
    final targetDate = formatter.parse(widget.date_visit);

    print(now);
    print(targetDate);
// Menentukan teks yang akan ditampilkan
    final textToShow = now.compareTo(targetDate) > 0 ? 'expired !' : '';

    return Scaffold(
        appBar: AppBar(
          // ignore: prefer_const_constructors
          title: Padding(
            padding: const EdgeInsets.only(left: 75),
            child: Text(
              "WisataKu",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          actions: const [],
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: // Generated code for this Column Widget...
            Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: AlignmentDirectional(0, 0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.80,
                  child: Stack(
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(25, 50, 25, 50),
                          child: Material(
                            color: Colors.transparent,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.70,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 240, 240, 240),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 20, 0, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                              child: Text(
                                            "Tiket Wisata",
                                            style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.w800)),
                                          )),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20,
                                                left: 20,
                                                right: 20,
                                                bottom: 10),
                                            child: Text(
                                              widget.tour_name,
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "id transaksi",
                                                      style: GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    ),
                                                    Text(
                                                      "Nama",
                                                      style: GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    ),
                                                    Text(
                                                      "Nomor Telepon",
                                                      style: GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    ),
                                                    Text(
                                                      "Tanggal Pembelian",
                                                      style: GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    ),
                                                    Text(
                                                      "Tanggal Kunjungan",
                                                      style: GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    ),
                                                    Text(
                                                      "Jumlah Orang",
                                                      style: GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      ": ${widget.id_trancaction}",
                                                      style: GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    ),
                                                    Text(
                                                      ": ${widget.name}",
                                                      style: GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    ),
                                                    Text(
                                                      ": ${widget.phone}",
                                                      style: GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    ),
                                                    Text(
                                                      ": ${widget.date_add}",
                                                      style: GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    ),
                                                    Text(
                                                      ": ${widget.date_visit}",
                                                      style: GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    ),
                                                    Text(
                                                      ": ${widget.qty} Orang",
                                                      style: GoogleFonts.poppins(
                                                          textStyle: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    ),
                                                  ],
                                                ),
                                                Spacer(
                                                  flex: 4,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 20),
                                            child: Center(
                                                child: Text(
                                              textToShow,
                                              style: TextStyle(
                                                  fontFamily: 'Lexend Deca',
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.red),
                                            )),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 20, 20, 20),
                                            child: Container(
                                              width: double.infinity,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 110, 188, 251),
                                                // ignore: prefer_const_literals_to_create_immutables
                                                boxShadow: [
                                                  // ignore: prefer_const_constructors
                                                  BoxShadow(
                                                    blurRadius: 6,
                                                    color: Color(0x34000000),
                                                  )
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                "LUNAS",
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 28,
                                                  color: Colors.white,
                                                ),
                                              )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.75,
                                          height: 25,
                                          decoration: BoxDecoration(
                                            color: Color(0x00F1F4F8),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 10, 0, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Material(
                                                  color: Colors.transparent,
                                                  elevation: 0,
                                                  shape: const CircleBorder(),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                ),
                                                Material(
                                                  color: Colors.transparent,
                                                  elevation: 0,
                                                  shape: const CircleBorder(),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                ),
                                                Material(
                                                  color: Colors.transparent,
                                                  elevation: 0,
                                                  shape: const CircleBorder(),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                ),
                                                Material(
                                                  color: Colors.transparent,
                                                  elevation: 0,
                                                  shape: const CircleBorder(),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                ),
                                                Material(
                                                  color: Colors.transparent,
                                                  elevation: 0,
                                                  shape: const CircleBorder(),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 15, left: 20, right: 20),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 90,
                                            decoration: BoxDecoration(
                                              color: Color(0x00FFFFFF),
                                              // image: DecorationImage(
                                              //   fit: BoxFit.fitHeight,
                                              //   image: Image.network(
                                              //     'https://scanbot.io/wp-content/uploads/2022/03/gs1-128-barcode-460x145.png',
                                              //   ).image,
                                              // ),
                                            ),
                                            child: BarcodeWidget(
                                              barcode: Barcode.code128(),
                                              data: widget.id_trancaction,
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
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(1, 0.4),
                        child: Material(
                          color: Colors.transparent,
                          elevation: 0,
                          shape: const CircleBorder(),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-1, 0.4),
                        child: Material(
                          color: Colors.transparent,
                          elevation: 0,
                          shape: const CircleBorder(),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
