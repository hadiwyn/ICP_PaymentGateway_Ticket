import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class MidtransView extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var count;
  // ignore: prefer_typing_uninitialized_variables
  var quantity;
  // ignore: prefer_typing_uninitialized_variables, non_constant_identifier_names
  var name_product;
  // ignore: prefer_typing_uninitialized_variables
  var date;
  // ignore: prefer_typing_uninitialized_variables
  var totalPrice;
  // ignore: prefer_typing_uninitialized_variables
  var name;
  // ignore: prefer_typing_uninitialized_variables
  var email;
  // ignore: prefer_typing_uninitialized_variables
  var phone;

  MidtransView(
      {super.key,
      required this.count,
      // ignore: non_constant_identifier_names
      required this.name_product,
      required this.quantity,
      required this.totalPrice,
      required this.date,
      required this.name,
      required this.email,
      required this.phone});

  @override
  State<MidtransView> createState() => _MidtransViewState();
}

class _MidtransViewState extends State<MidtransView> {
  late WebViewController webViewController;
  bool isLoading = true;

  String cdate2 = DateFormat("MMMM, dd, yyyy").format(DateTime.now());
  String dateNow = DateTime.now().toIso8601String();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
          height: 500,
        ),
        WebView(
          javascriptMode: JavascriptMode.unrestricted,
          onProgress: (value) {
            if (value == 100) {
              setState(() {
                isLoading = false;
              });
            }
          },
          initialUrl:
              // 'https://apipayment.mr-code.my.id/'
              'https://apipayment.mr-code.my.id/?name=${widget.name}&email=${widget.email}&no_tlp=${widget.phone}&count=${widget.count}&name_product=${widget.name_product}&jumlah=${widget.quantity}&sum=${widget.totalPrice}&date=${widget.date}&cDate=${cdate2}',
        ),
        isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(),
      ],
    ));
  }
}
