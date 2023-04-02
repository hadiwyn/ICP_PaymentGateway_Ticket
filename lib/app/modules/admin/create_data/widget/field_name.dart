import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FieldName extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var nameC;

  FieldName(this.nameC, {super.key});

  @override
  State<FieldName> createState() => _FieldNameState();
}

class _FieldNameState extends State<FieldName> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: widget.nameC,
        autocorrect: false,
        textInputAction: TextInputAction.next,
        // ignore: prefer_const_constructors
        decoration: const InputDecoration(
          icon: const Icon(
            Icons.abc,
            size: 24.0,
          ),
          labelText: "Nama Wisata",
        ),
      ),
    );
  }
}
