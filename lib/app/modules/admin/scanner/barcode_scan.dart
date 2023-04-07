import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';
import 'package:ticket_wisata_donorojo/app/modules/admin/scanner/result.dart';

class BarcodeScan extends StatefulWidget {
  const BarcodeScan({Key? key}) : super(key: key);

  @override
  _BarcodeScanState createState() => _BarcodeScanState();
}

class _BarcodeScanState extends State<BarcodeScan> {
  late String _barcodeScanRes = '';

  Future<void> _scanBarcode() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", true, ScanMode.BARCODE);

    QuerySnapshot transactions = await FirebaseFirestore.instance
        .collection('transaction')
        .where('transaction_id', isEqualTo: barcodeScanRes)
        .get();

    if (transactions.docs.isNotEmpty) {
      DocumentSnapshot transaction = transactions.docs.first;

      Get.to(Result(
          (transaction.data() as Map<String, dynamic>)['nama_wisata'],
          (transaction.data() as Map<String, dynamic>)['nama'],
          (transaction.data() as Map<String, dynamic>)['tanggal_kunjungan'],
          (transaction.data() as Map<String, dynamic>)['jumlah'],
          (transaction.data() as Map<String, dynamic>)['total_harga'],
          (transaction.data() as Map<String, dynamic>)['status']));
    }

    setState(() {
      _barcodeScanRes = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tiket Wisata Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _scanBarcode,
              child: Text('Scan Tiket Wisata'),
            ),
          ],
        ),
      ),
    );
  }
}
