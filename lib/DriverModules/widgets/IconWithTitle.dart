import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

Widget iconWithTitle({required String imageFile, required String title}) {
  return Container(
    height: 50,
    width: Get.width / 1,
    child: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          Lottie.asset(imageFile, height: 30, width: 20, fit: BoxFit.fill),
          SizedBox(
            width: 20,
          ),
          Text(
            title,
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
          )
        ],
      ),
    ),
  );
}





