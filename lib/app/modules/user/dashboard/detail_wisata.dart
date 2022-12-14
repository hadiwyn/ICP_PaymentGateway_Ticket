import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ticket_wisata_donorojo/app/modules/user/dashboard/midtrans_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';

const CHENNEL = "com.hadiwi.ticket_wisata_donorojo";
const KEY_NATIVE = "ShowTiketWisata";

// ignore: must_be_immutable
class DetailWisata extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables

  var detail;

  DetailWisata({Key? key, required this.detail}) : super(key: key);

  @override
  State<DetailWisata> createState() => _DetailWisataState();
}

class _DetailWisataState extends State<DetailWisata> {
  TextEditingController dateInput = TextEditingController();
  TextEditingController peopleInput = TextEditingController();
  TextEditingController totalHarga = TextEditingController();

  final controller = Completer<WebViewController>();

  static const platform = const MethodChannel(CHENNEL);

  int _quantity = 1;
  int totalPrice = 0;

  @override
  void initState() {
    dateInput.text = "";
    peopleInput.text = "1";
    totalHarga.text = "Rp. ${widget.detail["harga"]}";
    totalPrice = int.parse(widget.detail["harga"]);
    print(_quantity);
    print(totalPrice);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int harga = int.parse(widget.detail["harga"]);

    return Scaffold(
        appBar: AppBar(
          title: const Text('DetailWisataView'),
          centerTitle: true,
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  // ignore: prefer_const_constructors
                  Text(
                    widget.detail["nama"],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 10, right: 10),
                    child: TextField(
                      controller: dateInput,
                      //editing controller of this TextField
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                          // ignore: prefer_const_constructors
                          icon: Icon(Icons.calendar_today), //icon of text field
                          labelText: "Pilih Jadwal Wisata" //label text of field
                          ),
                      readOnly: true,
                      //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2100));

                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                          setState(() {
                            dateInput.text =
                                formattedDate; //set output date to TextField value.
                          });
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 40),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: peopleInput,
                            enabled: false,
                            decoration:
                                // ignore: prefer_const_constructors
                                InputDecoration(
                                    icon: Icon(Icons.people),
                                    labelText:
                                        "Jumlah Orang"), // Only numbers can be entered
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15, left: 20),
                          child: Container(
                            width: 50,
                            height: 50,
                            child: OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  _quantity -= 1;
                                  totalPrice = totalPrice - harga;
                                  peopleInput.text = _quantity.toString();
                                  totalHarga.text =
                                      "Rp. ${totalPrice.toString()}";
                                });
                                // for (int i = 0; i > _quantity; i--) {
                                //   totalPrice -= harga;
                                // }
                                print(_quantity);
                                print(totalPrice);
                                print(harga);
                              },
                              child: Icon(
                                Icons.remove,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                _quantity += 1;
                                totalPrice = int.parse(widget.detail["harga"]);
                                totalPrice *= _quantity;
                                peopleInput.text = _quantity.toString();
                                totalHarga.text =
                                    "Rp. ${totalPrice.toString()}";
                              });
                              print(_quantity);
                              print(totalPrice);
                              print(harga);
                            },
                            child: Icon(
                              Icons.add,
                              size: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 10, right: 10),
                    child: TextField(
                      controller: totalHarga,
                      enabled: false,
                      decoration:
                          // ignore: prefer_const_constructors
                          InputDecoration(
                              icon: const Icon(Icons.price_change),
                              labelText:
                                  "Total Harga"), // Only numbers can be entered
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  OutlinedButton(
                      onPressed: (() {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return MidtransView(
                              count: harga,
                              name_product: widget.detail["nama"],
                              quantity: _quantity);
                        }));

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => SnapWebViewScreen()));
                      }),
                      child: Text("Beli")),
                ]),
              ),
            ),
          ),
        ));
  }
}
