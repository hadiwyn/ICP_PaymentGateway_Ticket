import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class MidtransView extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var count;
  // ignore: prefer_typing_uninitialized_variables
  var quantity;
  // ignore: prefer_typing_uninitialized_variables, non_constant_identifier_names
  var name_product;

  MidtransView(
      {super.key,
      required this.count,
      // ignore: non_constant_identifier_names
      required this.name_product,
      required this.quantity});

  @override
  State<MidtransView> createState() => _MidtransViewState();
}

class _MidtransViewState extends State<MidtransView> {
  late WebViewController webViewController;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text("WebView"),
        //   actions: const [],
        // ),
        body: Stack(
      children: [
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
              'https://apipayment.mr-code.my.id/?count=${widget.count}&name_product=${widget.name_product}&jumlah=${widget.quantity}',
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
