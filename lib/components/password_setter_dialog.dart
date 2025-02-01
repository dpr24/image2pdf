import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image2pdf/components/custom_text_button.dart';
import 'package:image2pdf/data/constants/app_colors.dart';

class PasswordSetterDialog {
  static void showPasswordDialog({required Function(String) onSet}) {
    TextEditingController textEditingController = TextEditingController();
    Get.dialog(AlertDialog(
      backgroundColor: appColors.appDarkColor,
      title: Text(
        'Set Password',
        style: TextStyle(color: Colors.white),
      ),
      content: TextField(
        controller: textEditingController,
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        CustomTextButton(
            text: 'Set',
            onClick: () {
              onSet(textEditingController.text);
              Get.back();
            })
      ],
    ));
  }
}
