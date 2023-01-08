import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:ticket_wisata_donorojo/app/modules/admin/account_admin.dart';
import 'package:ticket_wisata_donorojo/app/modules/user/dashboard/riwayat_tiket.dart';
import 'package:ticket_wisata_donorojo/app/modules/splash/first_page.dart';

import 'dashboard_admin.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  // ignore: prefer_final_fields
  static List<Widget> _widgetOptions = <Widget>[
    // ignore: prefer_const_constructors
    DashboardAdmin(),
    AccountAdmin(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: navBar(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        iconTheme: IconThemeData(color: Color.fromARGB(255, 22, 103, 196)),
        title: Image.asset(
          'assets/image/logo-pacitan.webp',
          height: 40,
          fit: BoxFit.fitWidth,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          // ignore: prefer_const_constructors
          // Padding(
          //   // ignore: prefer_const_constructors
          //   padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
          //   // ignore: prefer_const_constructors

          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Get.deleteAll();
                Get.off(FirstPage());
              },
              icon: Icon(Icons.logout)),
          // )
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Akun',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
