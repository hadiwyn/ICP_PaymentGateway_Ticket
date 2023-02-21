import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../controllers/add_data_controller.dart';

class FieldPhoto extends GetView<AddDataController> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller.imgC,
            enabled: false,
            decoration:
                // ignore: prefer_const_constructors
                InputDecoration(
                    icon: Icon(Icons.photo),
                    labelText: "Masukkan Foto"), // Only numbers can be entered
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: ElevatedButton(
            child: Text("Upload Foto"),
            onPressed: () {
              controller.getImage();
            },
          ),
        ),
      ],
    );
  }
}
