import 'package:flutter/material.dart';

class FieldLocation extends StatefulWidget {
  var loc;

  FieldLocation(this.loc, {super.key});

  @override
  State<FieldLocation> createState() => _FieldLocationState();
}

class _FieldLocationState extends State<FieldLocation> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: widget.loc,
        autocorrect: false,
        textInputAction: TextInputAction.next,
        // ignore: prefer_const_constructors
        decoration: const InputDecoration(
          icon: const Icon(
            Icons.location_on_outlined,
            size: 24.0,
          ),
          labelText: "Url Lokasi",
        ),
      ),
    );
  }
}
