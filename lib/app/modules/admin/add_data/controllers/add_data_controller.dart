import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddDataController extends GetxController {
  late TextEditingController nameC;
  late TextEditingController priceC;
  late TextEditingController deskripsiC;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addProduct(String name, String price, String deskripsi) {
    CollectionReference product = firestore.collection("wisata");

    String cdate2 = DateFormat("MMMM, dd, yyyy").format(DateTime.now());

    try {
      String dateNow = DateTime.now().toIso8601String();
      product.add({
        "nama": name,
        "harga": price,
        "deskripsi": deskripsi,
        "time": cdate2
        
      });
      

      Get.defaultDialog(
        title: "Berhasil",
        middleText: "Berhasil menambahkan wisata",
        onConfirm: () {
          nameC.clear();
          priceC.clear();
          deskripsiC.clear();
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
    super.onInit();
  }

  @override
  void onClose() {
    nameC.dispose();
    priceC.dispose();
    deskripsiC.dispose();
    super.onClose();
  }
}
