import 'package:alpha_app/utils/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class SuccessDialogHelper {
  static void openDialog(
      {required Function onDone,
      required String title,
      required String description}) {
    Get.dialog(
      CupertinoAlertDialog(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            title,
            style: TextStyle(color: AppColors.primaryColor, fontSize: 18),
          ),
        ),
        content: Text(
          description,
          style: TextStyle(color: Colors.black87, fontSize: 15),
        ),
        actions: [
          TextButton(
            child: const Text("Done"),
            onPressed: () {
              onDone();
            },
          ),
        ],
      ),
    );
  }
}
