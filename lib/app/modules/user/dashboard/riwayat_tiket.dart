import 'package:flutter/material.dart';

class RiwayatTiket extends StatefulWidget {
  const RiwayatTiket({super.key});

  @override
  State<RiwayatTiket> createState() => _RiwayatTiketState();
}

class _RiwayatTiketState extends State<RiwayatTiket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
        ),
      ),
    );
  }
}
