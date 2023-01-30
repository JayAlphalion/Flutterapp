import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanController{
   Future<String> getImage() async {
Permission.camera.request();


    String imagePath;
    try {
      imagePath = (await EdgeDetection.detectEdge)!;
    } on PlatformException catch (e) {
      imagePath = e.toString();
    }

    return imagePath;
  }

}