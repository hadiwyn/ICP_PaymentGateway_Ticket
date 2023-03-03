import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../controllers/add_data_controller.dart';

class FieldDeskripsi extends GetView<AddDataController> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        maxLines: 5,
        controller: controller.deskripsiC,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: "Deskripsi",
          border: OutlineInputBorder(),
          icon: const Icon(
            Icons.description,
            size: 24.0,
          ),
        ),
      ),
    );
  }
}
