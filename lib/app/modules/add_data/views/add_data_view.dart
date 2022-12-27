import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_data_controller.dart';
import 'field_deskripsi.dart';
import 'field_hargaTiket.dart';
import 'field_namaWisata.dart';

class AddDataView extends GetView<AddDataController> {
  const AddDataView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tambah Wisata'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [

              fieldNama(),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 10,
              ),
              FieldTiket(),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 30,
              ),
              FieldDeskripsi(),
              // ignore: prefer_const_constructors
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () => controller.addProduct(controller.nameC.text,
                    controller.priceC.text, controller.deskripsiC.text),
                // ignore: prefer_const_constructors
                child: Text("Add Product"),
              ),
            ],
          ),
        ));
  }
}
