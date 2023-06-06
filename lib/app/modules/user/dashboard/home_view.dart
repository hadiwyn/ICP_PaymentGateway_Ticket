import 'package:WisataKU/app/modules/user/dashboard/list_view.dart';
import 'package:WisataKU/app/modules/user/dashboard/search_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? nama = "";

  final _searchController = TextEditingController();

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
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Stack(
        children: [
          Container(
            color: const Color.fromARGB(255, 93, 193, 255),
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
          const Positioned(
            top: 50,
            right: 20,
            child: Text(
              "Selamat Datang",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Positioned(
            top: 70,
            right: 20,
            child: Text(
              nama!,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Positioned(
            top: 55,
            left: 15,
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
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Colors.white),
              child: const Padding(
                padding: EdgeInsets.only(top: 130),
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
                      color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
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
                      return const CircularProgressIndicator();
                    }

                    List<String> imageUrls = [];

                    for (var doc in snapshot.data!.docs) {
                      Map<String, dynamic> data =
                          doc.data() as Map<String, dynamic>;
                      data.forEach((key, value) {
                        if (key.contains('image_')) {
                          imageUrls.add(value.toString());
                        }
                      });
                    }

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
                                color: const Color.fromARGB(255, 255, 255, 255),
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
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.travel_explore,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchPage(
                                  searchQuery: _searchController.text)),
                        );
                      },
                      child: TextFormField(
                        controller:
                            _searchController, // controller untuk mengambil nilai dari TextFormField
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration.collapsed(
                          filled: true,
                          fillColor: Color.fromARGB(0, 248, 245, 245),
                          hintText: "Kamu mau wisata kemana?",
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          hoverColor: Color.fromARGB(0, 248, 245, 245),
                        ),
                        onFieldSubmitted: (value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SearchPage(searchQuery: value)),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            top: 370,
            left: 15,
            child: Text(
              "Pilih Wisata",
              style: TextStyle(
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
