import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/services.dart';

class ScanController{
   Future<String> getImage() async {
    String imagePath;
    try {
      imagePath = (await EdgeDetection.detectEdge)!;
    } on PlatformException catch (e) {
      imagePath = e.toString();
    }

    return imagePath;
  }

}