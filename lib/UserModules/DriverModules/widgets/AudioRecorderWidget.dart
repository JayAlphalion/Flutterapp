import 'package:alpha_app/Universals/utils/AppColors.dart';
import 'package:alpha_app/Universals/utils/Constants.dart';
import 'package:alpha_app/Universals/utils/ImageUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class AudioRecorderWidget extends StatelessWidget {
  final Function onPausePressed;
  final Function onCompletePressed;
  final Function onResumed;
  final String recordingStatus;
 AudioRecorderWidget({required this.onPausePressed, required this.onCompletePressed, required this.onResumed, required this.recordingStatus});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 1,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.only(left:15,right:15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          
          recordingStatus==Constant.Recording?
            InkWell(
              onTap: (){
                onPausePressed();
              },
              child: Icon(
                Icons.pause_sharp,
                size: 35,
                color: AppColors.primaryColor,
              ),
            ):
            
             InkWell(
              onTap: (){
                onResumed();
              },
              child: Icon(
                Icons.play_arrow,
                size: 35,
                color: AppColors.primaryColor,
              ),
            )
            ,
            Container(
              width: Get.width / 1.8,
              height: 45,
              child: Lottie.asset(ImageUtils.RECORDER_GIF,
                width: Get.width / 1.8,
                fit: BoxFit.fill,
                // color: AppColors.primaryColor,
              height: 45,
              ),
             
            ),
            InkWell(
              onTap: (){
                onCompletePressed();
              },
              child: Icon(
                Icons.stop,
                size: 35,
                color: AppColors.primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
