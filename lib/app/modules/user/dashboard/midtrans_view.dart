import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter/webview_flutter.dart';

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
  // late WebViewController webViewController;
  // late final WebViewController controller;
  bool isLoading = true;

  String cdate2 = DateFormat("MMMM, dd, yyyy").format(DateTime.now());
  String dateNow = DateTime.now().toIso8601String();

  @override
  void initState() {
    super.initState();
    // controller = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..setBackgroundColor(const Color(0x00000000))
    //   ..setNavigationDelegate(
    //     NavigationDelegate(
    //       onProgress: (int progress) {
    //         // Update loading bar.
    //       },
    //       onPageStarted: (String url) {},
    //       onPageFinished: (String url) {},
    //       onWebResourceError: (WebResourceError error) {},
    //       onNavigationRequest: (NavigationRequest request) {
    //         if (request.url.startsWith('https://www.youtube.com/')) {
    //           return NavigationDecision.prevent;
    //         }
    //         return NavigationDecision.navigate;
    //       },
    //     ),
    //   )
    //   ..loadRequest(Uri.parse('https://flutter.dev'));
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
                'https://ab95-140-213-173-211.ngrok-free.app/checkout?transaction_id=${widget.transaction_id}&nama=${widget.name}&harga=${widget.count}&telepon=${widget.phone}&quantity=${widget.quantity}&date_visit=${widget.date}&date_add=${widget.dateAdd}&tourname=${widget.name_product}',
          ),
          // WebViewWidget(controller: controller),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const Stack(),
        ],
      ),
    );
  }
}
