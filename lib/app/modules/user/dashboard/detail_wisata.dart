// ignore_for_file: must_be_immutable

import 'package:WisataKU/app/modules/user/dashboard/page_view.dart';
import 'package:WisataKU/app/modules/user/dashboard/pesan_tiket.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

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
        SizedBox(height: 430, child: PageViewAutoSlide(widget.detail)),
        // Container(
        //   height: 430,
        //   width: double.infinity,
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //         image: AssetImage('assets/image/pangasan.jpeg'),
        //         fit: BoxFit.cover),
        //   ),
        // ),
        Container(
          margin: const EdgeInsets.only(top: 380),
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(color: Colors.white),
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
                      const Spacer(),
                      const Icon(
                        Icons.location_pin,
                        size: 16.0,
                        color: Color.fromARGB(255, 55, 197, 90),
                      ),
                      InkWell(
                        onTap: () {
                          launchMap(widget.detail['location']);
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(top: 2, right: 20),
                          child: Text(
                            "Dapatkan Arah",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 55, 197, 90)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    "Overview",
                    style: TextStyle(
                        color: Color.fromARGB(255, 93, 193, 255), fontSize: 16),
                  ),
                ),
                SizedBox(
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
                const Spacer(),
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
                          const Text("Per Orang"),
                        ],
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          Get.off(PesanTiket(widget.detail));
                        },
                        child: Container(
                          width: 150,
                          height: 40,
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
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: InkWell(
                            onTap: () {
                              Get.off(PesanTiket(widget.detail));
                            },
                            child: const Center(
                              child: Text(
                                "Pesan Sekarang",
                                style: TextStyle(
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
                const Spacer()
              ],
            ),
          ),
        )
      ],
    ));
  }
}
