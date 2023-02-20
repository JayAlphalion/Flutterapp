import 'package:alpha_app/Universals/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/utils.dart';

Widget bottonWidget({required String title}) {
  return Container(
    height: 45,
    width: Get.width / 1,
    decoration: BoxDecoration(
        color: AppColors.primaryColor, borderRadius: BorderRadius.circular(10)),
    alignment: Alignment.center,
    child: Text(
      title,
      style: TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
    ),
  );
}
