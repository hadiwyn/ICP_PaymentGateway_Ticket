import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:ticket_wisata_donorojo/app/modules/user/account_user/account_user.dart';
import 'package:ticket_wisata_donorojo/app/modules/user/dashboard/dashboard.dart';
import 'package:ticket_wisata_donorojo/app/modules/user/dashboard/home_view.dart';
import 'package:ticket_wisata_donorojo/app/modules/user/dashboard/list_view.dart';
import 'package:ticket_wisata_donorojo/app/modules/user/dashboard/riwayat_tiket.dart';
import 'package:ticket_wisata_donorojo/app/modules/splash/first_page.dart';
import 'package:get/get.dart';

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
    HomeView(),
    RiwayatTiket(),
    AccountUser()
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
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Akun',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 93, 193, 255),
        onTap: _onItemTapped,
      ),
    );
  }
}
