import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:ticket_wisata_donorojo/app/modules/admin/create_data/widget/field_deskripsi.dart';
import 'package:ticket_wisata_donorojo/app/modules/admin/create_data/widget/field_image.dart';
import 'package:ticket_wisata_donorojo/app/modules/admin/create_data/widget/field_location.dart';
import 'package:ticket_wisata_donorojo/app/modules/admin/create_data/widget/field_name.dart';
import 'package:ticket_wisata_donorojo/app/modules/admin/create_data/widget/field_price.dart';

class CreateData extends StatefulWidget {
  const CreateData({super.key, this.dataNotifier});

  final ValueNotifier<String>? dataNotifier;
  @override
  State<CreateData> createState() => _CreateDataState();
}

class _CreateDataState extends State<CreateData> {
  TextEditingController nameC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  TextEditingController DescC = TextEditingController();
  TextEditingController LocC = TextEditingController();

  CollectionReference? dbRef;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String _error = 'No Error Detected';
  List<Asset> images = [];

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
              FieldName(nameC),
              SizedBox(
                height: 20,
              ),
              FieldPrice(priceC),
              SizedBox(
                height: 20,
              ),
              FieldLocation(LocC),
              SizedBox(
                height: 30,
              ),
              FieldDeskripsi(DescC),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Spacer(
                    flex: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: ElevatedButton(
                      child: Text("Upload Foto"),
                      onPressed: () {
                        // Get.to(FieldImage());
                        loadAssets();
                      },
                    ),
                  ),
                  Spacer(),
                  if (images.isNotEmpty)
                    const Icon(
                      Icons.verified,
                      size: 30.0,
                      color: Colors.green,
                    ),
                ],
              ),
              SizedBox(
                height: 100,
              ),
              ElevatedButton(
                onPressed: () {
                  createData(nameC.text, priceC.text, DescC.text);
                },
                child: Text("Tambah Data"),
              ),
              Spacer(
                flex: 2,
              ),
            ],
          ),
        ));
  }

  Future<void> createData(String name, String price, String deskripsi) async {
    List<String> imageUrls = [];
    CollectionReference product = firestore.collection("wisata");
    String cdate2 = DateFormat("MMMM, dd, yyyy").format(DateTime.now());
    Reference storageRef = FirebaseStorage.instance.ref().child("images");

    for (Asset imageAsset in images) {
      ByteData byteData = await imageAsset.getByteData();
      Uint8List imageData = Uint8List.fromList(byteData.buffer.asUint8List());

      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference uploadRef = storageRef.child(fileName);

      try {
        await uploadRef.putData(imageData);

        String imageUrl = await uploadRef.getDownloadURL();
        imageUrls.add(imageUrl);
      } catch (e) {
        print(e);
      }
    }

    // Buat data baru dengan field sesuai jumlah url gambar yang diupload
    Map<String, dynamic> data = {};
    for (int i = 0; i < imageUrls.length; i++) {
      data['image_${i + 1}'] = imageUrls[i];
    }

    // // Simpan data ke Firestore
    // try {
    //   await FirebaseFirestore.instance.collection('wisata').add(data);
    // } catch (e) {
    //   print(e);
    // }
    try {
      String dateNow = DateTime.now().toIso8601String();
      final DocumentReference doc = await product.add({
        "nama": name,
        "harga": price,
        "deskripsi": deskripsi,
        // "image": imgUrl,
        "time": cdate2,
        "total_gambar": imageUrls.length
      });

      final String ID = doc.id;
      doc.update({'id': ID});
      doc.update(data);

      Get.defaultDialog(
        title: "Berhasil",
        middleText: "Berhasil menambahkan wisata",
        onConfirm: () {
          nameC.clear();
          priceC.clear();
          DescC.clear();
          // imgC.clear();
          Get.back();
          Get.back();
        },
        textConfirm: "Okey",
      );
    } catch (e) {
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "Tidak Dapat Menambahkan wisata",
      );
    }
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        cupertinoOptions: CupertinoOptions(
          takePhotoIcon: "chat",
          doneButtonTitle: "Fatto",
        ),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "WisataKu",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      _error = error;
      images = resultList;
    });
  }
}
