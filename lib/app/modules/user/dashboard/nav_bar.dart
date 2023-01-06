import 'package:flutter/material.dart';

class navBar extends StatelessWidget {
  const navBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.amber,
            ),
            accountName: Text("Hadi Wiyono"),
            accountEmail: Text("hadiyw400@gmail.com"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network('https://picsum.photos/250?image=9'),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Akun"),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Pengaturan"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.feedback),
            title: Text("Masukan"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Keluar"),
          ),
        ],
      ),
    );
  }
}
