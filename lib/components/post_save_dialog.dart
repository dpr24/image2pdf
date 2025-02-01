import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostSaveDialog {
  static showDialog(int res) {
    switch (res) {
      case 1:
        Get.defaultDialog(
          title: 'File Saved',
          titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          middleText: 'Your file has been successfully saved',
          middleTextStyle: TextStyle(fontSize: 16),
          textConfirm: 'OK',
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back(); // Close the dialog
          },
          radius: 8,
          barrierDismissible: false,
        );

        break;
      case 0:
        Get.defaultDialog(
          title: 'Save Failed',
          titleStyle: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
          middleText: 'Failed to save the file.',
          middleTextStyle: TextStyle(fontSize: 16),
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back(); // Close the dialog
            // Add retry logic here, if needed
          },
          onCancel: () {
            Get.back(); // Close the dialog
          },
          radius: 8,
          barrierDismissible: false,
        );
      default:
    }
  }
}
