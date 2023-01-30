import 'dart:async';
import 'dart:io';
import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
class ScanController{
   Future<String> getImage() async {
Permission.camera.request();


        String imagePath = join((await getApplicationSupportDirectory()).path,
        "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

        try {
          bool res= await EdgeDetection.detectEdge(imagePath);
    } on PlatformException catch (e) {
      imagePath = e.toString();
    }

    return imagePath;
  }

}