// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ticket_wisata_donorojo/app/modules/home/views/page_view.dart';
import 'list_view.dart';

import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

import 'nav_bar.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: navBar(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromARGB(255, 22, 103, 196)),
        title: Center(
          child: Image.asset(
            'assets/image/logo-pacitan.webp',
            height: 40,
            fit: BoxFit.fitWidth,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 3,
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
          stream: controller.streamData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              var listAllDocument = snapshot.data!.docs;
              return SingleChildScrollView(
                child: Column(
                  children: [
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
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  pageView(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    listView(listAllDocument),
                  ],
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
      floatingActionButton: Visibility(
          visible: true,
          child: FloatingActionButton(
            onPressed: () => Get.toNamed(Routes.ADD_DATA),
            child: Icon(Icons.add),
          )),
    );
  }
}
