
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
            accountName: Text("Coba"),
            accountEmail: Text("Email"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network('https://picsum.photos/250?image=9'),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.access_time),
            title: Text("Coba"),
          ),
          ListTile(
            leading: Icon(Icons.access_time),
            title: Text("Coba"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.access_time),
            title: Text("Coba"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.access_time),
            title: Text("Coba"),
          ),
        ],
      ),
    );
  }
}
