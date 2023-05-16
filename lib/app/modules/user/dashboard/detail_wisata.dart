// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticket_wisata_donorojo/app/modules/user/dashboard/page_view.dart';
import 'package:ticket_wisata_donorojo/app/modules/user/dashboard/pesan_tiket.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DetailWisata extends StatefulWidget {
  var detail;

  DetailWisata(this.detail, {super.key});

  @override
  State<DetailWisata> createState() => _DetailWisataState();
}

class _DetailWisataState extends State<DetailWisata> {
  void launchMap(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(height: 430, child: PageViewAutoSlide(widget.detail)),
        // Container(
        //   height: 430,
        //   width: double.infinity,
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //         image: AssetImage('assets/image/pangasan.jpeg'),
        //         fit: BoxFit.cover),
        //   ),
        // ),
        Positioned(
          left: 15,
          top: 35,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.black.withOpacity(0.2)),
              child: Center(
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 380),
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    widget.detail['nama'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    children: [
                      Spacer(),
                      const Icon(
                        Icons.location_pin,
                        size: 16.0,
                        color: Colors.black54,
                      ),
                      InkWell(
                        onTap: () {
                          launchMap(widget.detail['location']);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2, right: 20),
                          child: Text(
                            "Dapatkan Arah",
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    "Overview",
                    style: const TextStyle(
                        color: Color.fromARGB(255, 93, 193, 255), fontSize: 16),
                  ),
                ),
                Container(
                  height: 200,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      controller: ScrollController(),
                      child: Text(
                        widget.detail['deskripsi'],
                        textAlign: TextAlign.justify,
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.price_change,
                                size: 24.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Text(
                                  widget.detail['harga'],
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                          Text("Per Orang"),
                        ],
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Get.off(PesanTiket(widget.detail));
                        },
                        child: Container(
                          width: 150,
                          height: 40,
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
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: InkWell(
                            onTap: () {
                              Get.off(PesanTiket(widget.detail));
                            },
                            child: Center(
                              child: Text(
                                "Pesan Sekarang",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer()
              ],
            ),
          ),
        )
      ],
    ));
  }
}
