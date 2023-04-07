import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ticket_wisata_donorojo/app/modules/user/dashboard/list_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? nama = "";

  Future<void> getData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          nama = snapshot.data()!['nama_lengkap'];
        });
      }
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Stack(
        children: [
          Container(
            color: Color.fromARGB(255, 93, 193, 255),
            height: 300,
          ),
          // Positioned(
          //   right: 5,
          //   top: 20,
          //   child: Image.asset(
          //     "assets/image/logo.png",
          //     width: 90.0,
          //     height: 90.0,
          //     fit: BoxFit.fill,
          //   ),
          // ),
          Positioned(
            top: 50,
            left: 15,
            child: Text(
              "Selamat Datang",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Positioned(
            top: 65,
            left: 15,
            child: Text(
              nama!,
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 55,
            right: 40,
            child: Text(
              "WisataKu",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 250),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.only(top: 130),
                child: listView(),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 180),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('wisata')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }

                    List<String> imageUrls = [];

                    snapshot.data!.docs.forEach((doc) {
                      Map<String, dynamic> data =
                          doc.data() as Map<String, dynamic>;
                      data.forEach((key, value) {
                        if (key.contains('image_')) {
                          imageUrls.add(value.toString());
                        }
                      });
                    });

                    return CarouselSlider(
                      options: CarouselOptions(
                        height: 160.0,
                        autoPlay: true,
                        enlargeCenterPage: true,
                      ),
                      items: imageUrls.map((imageUrl) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(6.0),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    imageUrl,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    );
                  },
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(top: 110, left: 15, right: 15),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 2.0,
                horizontal: 12.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.travel_explore,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      initialValue: null,
                      decoration: InputDecoration.collapsed(
                        filled: true,
                        fillColor: Color.fromARGB(0, 248, 245, 245),
                        hintText: "Kamu mau wisata kemana?",
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        hoverColor: Color.fromARGB(0, 248, 245, 245),
                      ),
                      onFieldSubmitted: (value) {},
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 370,
            left: 15,
            child: Text(
              "Pilih Wisata",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      )),
    );
  }
}
