import 'package:alpha_app/Universals/utils/ImageUtils.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class  HelperWidget {
  static Widget UploadLoaderWidget() {
    return Container(
      height: 30,
      width: 30,
      child: Lottie.asset(ImageUtils.UPLOAD_GIF),
    );
  }
}
