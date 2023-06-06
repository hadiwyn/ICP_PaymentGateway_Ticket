import 'package:flutter/material.dart';

class FieldDeskripsi extends StatefulWidget {
  var descC;

  FieldDeskripsi(this.descC, {super.key});

  @override
  State<FieldDeskripsi> createState() => _FieldDeskripsiState();
}

class _FieldDeskripsiState extends State<FieldDeskripsi> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        controller: widget.descC,
        maxLines: 5,
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          labelText: "Deskripsi",
          border: OutlineInputBorder(),
          icon: Icon(
            Icons.description,
            size: 24.0,
          ),
        ),
      ),
    );
  }
}
