import 'package:flutter/material.dart';

class FieldPhoto extends StatelessWidget {
  const FieldPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            enabled: false,
            decoration:
                // ignore: prefer_const_constructors
                InputDecoration(
                    icon: Icon(Icons.photo),
                    labelText: "Masukkan Foto"), // Only numbers can be entered
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: ElevatedButton(
            child: Text("Upload Foto"),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
