import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../controllers/add_data_controller.dart';

// ignore: use_key_in_widget_constructors
class FieldTiket extends GetView<AddDataController> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller.priceC,
      textInputAction: TextInputAction.next,
      // ignore: prefer_const_constructors
      decoration: InputDecoration(labelText: "Harga Tiket"),
    );
  }
}
