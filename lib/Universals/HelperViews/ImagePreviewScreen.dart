// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class ImagePrivewScreen extends StatelessWidget {
  final String url;
  ImagePrivewScreen({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              height: Get.height / 1,
              width: Get.width / 1,
              child: PhotoView(
                imageProvider: NetworkImage(url),
              )),
          Positioned(
              left: 25,
              top: 60,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: Colors.white,
                ),
              )),
          Positioned(
              right: 25,
              top: 70,
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context, 'done');
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  )))
        ],
      ),
    );
  }
}
