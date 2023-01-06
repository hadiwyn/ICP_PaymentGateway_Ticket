import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:ticket_wisata_donorojo/app/modules/user/dashboard/dashboard.dart';
import 'package:ticket_wisata_donorojo/app/modules/user/dashboard/nav_bar.dart';
import 'package:ticket_wisata_donorojo/app/modules/user/dashboard/riwayat_tiket.dart';
import 'package:ticket_wisata_donorojo/app/modules/splash/splash_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  // ignore: prefer_final_fields
  static List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    RiwayatTiket(),
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SplashScreen()));
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
            icon: Icon(Icons.history),
            label: 'Ticket',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
