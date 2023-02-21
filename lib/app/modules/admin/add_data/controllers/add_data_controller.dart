

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class AddDataController extends GetxController {
  late TextEditingController nameC;
  late TextEditingController priceC;
  late TextEditingController deskripsiC;
  late TextEditingController imgC;
  late String imgUrl;
  late XFile? imgFile;

  CollectionReference? dbRef;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      imgFile = image;
      imgC.text = image.name;
    }
    String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference ref = FirebaseStorage.instance.ref().child("images");
    Reference uploadImg = ref.child(uniqueName);

    try {
      await uploadImg.putFile(File(image!.path));
      imgUrl = await uploadImg.getDownloadURL();
      print(imgUrl);
    } catch (error) {}
  }

  void addProduct(String name, String price, String deskripsi) {
    CollectionReference product = firestore.collection("wisata");

    String cdate2 = DateFormat("MMMM, dd, yyyy").format(DateTime.now());
    

    try {
      String dateNow = DateTime.now().toIso8601String();
      product.add({
        "nama": name,
        "harga": price,
        "deskripsi": deskripsi,
        "image" : imgUrl,
        "time": cdate2
      });

      Get.defaultDialog(
        title: "Berhasil",
        middleText: "Berhasil menambahkan wisata",
        onConfirm: () {
          nameC.clear();
          priceC.clear();
          deskripsiC.clear();
          imgC.clear();
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

  @override
  void onInit() {
    nameC = TextEditingController();
    priceC = TextEditingController();
    deskripsiC = TextEditingController();
    imgC = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    nameC.dispose();
    priceC.dispose();
    deskripsiC.dispose();
    imgC.dispose();
    super.onClose();
  }
}
