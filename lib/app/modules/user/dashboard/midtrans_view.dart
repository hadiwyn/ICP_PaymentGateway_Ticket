import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class MidtransView extends StatefulWidget {
  // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
  var transaction_id;
  // ignore: prefer_typing_uninitialized_variables
  var count;
  // ignore: prefer_typing_uninitialized_variables
  var quantity;
  // ignore: prefer_typing_uninitialized_variables, non_constant_identifier_names
  var name_product;
  // ignore: prefer_typing_uninitialized_variables
  var date;
  // ignore: prefer_typing_uninitialized_variables
  var dateAdd;
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
      // ignore: non_constant_identifier_names
      required this.transaction_id,
      required this.count,
      // ignore: non_constant_identifier_names
      required this.name_product,
      required this.quantity,
      required this.totalPrice,
      required this.date,
      required this.dateAdd,
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        // ignore: prefer_const_constructors
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
                'https://bad7-182-2-82-142.ap.ngrok.io/checkout?transaction_id=${widget.transaction_id}&nama=${widget.name}&harga=${widget.count}&telepon=${widget.phone}&quantity=${widget.quantity}&date_visit=${widget.date}&date_add=${widget.dateAdd}&tourname=${widget.name_product}'
            // 'https://apipayment.mr-code.my.id/?name=${widget.name}&email=${widget.email}&no_tlp=${widget.phone}&count=${widget.count}&name_product=${widget.name_product}&jumlah=${widget.quantity}&sum=${widget.totalPrice}&date=${widget.date}&cDate=${cdate2}',
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
