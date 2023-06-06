// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Result extends StatefulWidget {
  var nama_wisata;

  var nama_orang;

  var tgl_kunjungan;

  var qty;

  var total_harga;

  var status;

  Result(this.nama_wisata, this.nama_orang, this.tgl_kunjungan, this.qty,
      this.total_harga, this.status,
      {super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  TextEditingController namaOrang = TextEditingController();

  TextEditingController tglKunjungan = TextEditingController();

  TextEditingController quantity = TextEditingController();

  TextEditingController totalHarga = TextEditingController();

  @override
  void initState() {
    namaOrang.text = widget.nama_orang;
    tglKunjungan.text = widget.tgl_kunjungan;
    quantity.text = widget.qty.toString();
    totalHarga.text = widget.total_harga.toString();
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
    final targetDate = formatter.parse(widget.tgl_kunjungan);

// Menentukan teks yang akan ditampilkan
    final textToShow = now.compareTo(targetDate) > 0 ? 'expired' : '';

    print(now);
    print(targetDate);
    print(textToShow);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: double.infinity,
                height: 700,
                decoration: BoxDecoration(
                  color: Colors.white,
                  // ignore: prefer_const_literals_to_create_immutables
                  boxShadow: [
                    // ignore: prefer_const_constructors
                    BoxShadow(
                      blurRadius: 6,
                      // ignore: prefer_const_constructors
                      color: Color(0x34000000),
                      // ignore: prefer_const_constructors
                      offset: Offset(0, 3),
                    )
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            widget.nama_wisata,
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600)),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "Nama Pembeli",
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                        ),
                        TextFormField(
                          readOnly: true,
                          controller: namaOrang,
                          // ignore: prefer_const_constructors
                          decoration: InputDecoration(
                            // ignore: prefer_const_constructors
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                        ),
                        const Spacer(),
                        Text(
                          "Tanggal Kunjungan",
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                        ),
                        TextFormField(
                          readOnly: true,
                          controller: tglKunjungan,
                          // ignore: prefer_const_constructors
                          decoration: InputDecoration(
                            // ignore: prefer_const_constructors
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                        ),
                        const Spacer(),
                        Text(
                          "Jumlah Orang",
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                        ),
                        TextFormField(
                          readOnly: true,
                          controller: quantity,
                          // ignore: prefer_const_constructors
                          decoration: InputDecoration(
                            // ignore: prefer_const_constructors
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                        ),
                        const Spacer(),
                        Text(
                          "Total Harga",
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                        ),
                        TextFormField(
                          readOnly: true,
                          controller: totalHarga,
                          // ignore: prefer_const_constructors
                          decoration: InputDecoration(
                            // ignore: prefer_const_constructors
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                        ),
                        if (textToShow == 'expired')
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: const Center(
                                child: Text(
                              'Expired !',
                              style: TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.red),
                            )),
                          ),
                        const Spacer(),
                        InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: Center(
                            child: Icon(
                              widget.status != "Paid"
                                  ? Icons.do_not_disturb_on
                                  : Icons.verified,
                              size: 100.0,
                              color: widget.status != "Paid"
                                  ? Colors.red
                                  : const Color.fromARGB(255, 17, 246, 44),
                            ),
                          ),
                        ),
                        const Spacer(),
                      ]),
                ),
              ),
            ),
            const Spacer(),
            const Spacer(
              flex: 2,
            )
          ],
        ),
      ),
    );
  }
}
