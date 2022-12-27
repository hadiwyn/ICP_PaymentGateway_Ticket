import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RegisterController extends GetxController {
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

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
