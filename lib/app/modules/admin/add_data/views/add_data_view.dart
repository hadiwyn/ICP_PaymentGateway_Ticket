import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticket_wisata_donorojo/app/modules/admin/add_data/views/field_photo.dart';

import '../controllers/add_data_controller.dart';
import 'field_deskripsi.dart';
import 'field_hargaTiket.dart';
import 'field_namaWisata.dart';

class AddDataView extends GetView<AddDataController> {
  const AddDataView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.blueGrey,
          ),
          backgroundColor: Colors.white,
          title: const Text(
            'Tambah Wisata',
            style: TextStyle(color: Colors.blueGrey),
          ),
          elevation: 0,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Column(
            children: [
              Spacer(),
              fieldNama(),
              SizedBox(
                height: 20,
              ),
              FieldTiket(),
              SizedBox(
                height: 20,
              ),
              FieldDeskripsi(),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              FieldPhoto(),
              SizedBox(
                height: 100,
              ),
              ElevatedButton(
                onPressed: () => controller.addProduct(controller.nameC.text,
                    controller.priceC.text, controller.deskripsiC.text),
                // ignore: prefer_const_constructors
                child: Text("Add Product"),
              ),
              Spacer(
                flex: 2,
              ),
            ],
          ),
        ));
  }
}
