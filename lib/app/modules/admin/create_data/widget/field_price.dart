import 'package:flutter/material.dart';

class FieldPrice extends StatefulWidget {
  var priceC;

  FieldPrice(this.priceC, {super.key});

  @override
  State<FieldPrice> createState() => _FieldPriceState();
}

class _FieldPriceState extends State<FieldPrice> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: widget.priceC,
        textInputAction: TextInputAction.next,
        // ignore: prefer_const_constructors
        decoration: InputDecoration(
          labelText: "Harga Tiket",
          icon: const Icon(
            Icons.price_change,
            size: 24.0,
          ),
        ),
      ),
    );
  }
}
