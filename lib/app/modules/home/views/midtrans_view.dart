import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class MidtransView extends StatefulWidget {
  var count;
  var quantity;
  var name_product;

  MidtransView(
      {super.key,
      required this.count,
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
        appBar: AppBar(
          title: const Text("WebView"),
          actions: const [],
        ),
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
                  'http://103.176.78.133:8080?count=${widget.count}&name_product=${widget.name_product}&jumlah=${widget.quantity}',
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(),
          ],
        ));
  }
}
