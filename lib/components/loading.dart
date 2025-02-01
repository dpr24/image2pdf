import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loading {
  static void showLoadingDialog() {
    Get.dialog(
      Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              const Text("Loading...", style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void showCirculorDialog() {
    Get.dialog(
      Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
