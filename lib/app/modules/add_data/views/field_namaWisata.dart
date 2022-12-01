// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../controllers/add_data_controller.dart';

// ignore: camel_case_types, must_be_immutable, use_key_in_widget_constructors
class fieldNama extends GetView<AddDataController> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller.nameC,
      autocorrect: false,
      textInputAction: TextInputAction.next,
      // ignore: prefer_const_constructors
      decoration: InputDecoration(labelText: "Nama Wisata"),
    );
  }
}
