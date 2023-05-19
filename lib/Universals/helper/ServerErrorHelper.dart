import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServerErrorHelper {
  static void openDialog({required Function onRetry}) {
    Get.dialog(
      CupertinoAlertDialog(
        title: const Text('Server Error'),
        content:
            const Text('Something Went Wrong In Server Side\nPlease Try Again'),
        actions: [
          TextButton(
            child: const Text("Retry"),
            onPressed: () {
              onRetry();
            },
          ),
        ],
      ),
    );
  
  
  }
}
