import 'package:alpha_app/Universals/utils/AppColors.dart';
import 'package:alpha_app/Universals/utils/ImageUtils.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HelperWidget {
  static Widget UploadLoaderWidget() {
    return Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: const [
            Icon(
              Icons.upload,
              size: 25,
              color: AppColors.primaryColor,
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            ),
          ],
        ));
  }
}
