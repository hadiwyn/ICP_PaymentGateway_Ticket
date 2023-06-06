
import 'package:WisataKU/app/modules/user/account_user/account_user.dart';
import 'package:WisataKU/app/modules/user/dashboard/home_view.dart';
import 'package:WisataKU/app/modules/user/dashboard/riwayat_tiket.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  // ignore: prefer_final_fields
  static List<Widget> _widgetOptions = <Widget>[
    const HomeView(),
    const RiwayatTiket(),
    const AccountUser()
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
        selectedItemColor: const Color.fromARGB(255, 93, 193, 255),
        onTap: _onItemTapped,
      ),
    );
  }
}
