 import 'dart:io';

import 'package:alpha_app/helper/ImagePickerHelper.dart';
import 'package:alpha_app/utils/AppColors.dart';
import 'package:alpha_app/utils/Constants.dart';
import 'package:alpha_app/widgets/AudioPlayerWidget.dart';
import 'package:alpha_app/widgets/SoundRecorderWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AddClaimPageWidgets{

Widget audioRecordedWidget({required String title, required List<File> audioFiles}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: Get.width / 1.5,
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        EmptyaudioBox(),
        for (int i = 0; i < audioFiles.length; i++)
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: audioPlayerWidget(
              audioFiles: audioFiles,
              index: i
            ),
          )
      ],
    );
  }

  
  // void uploadImageToTheFirebase(File file, String key) {}

  Widget imageBox(String hintText, File file) {
    return Container(
      height: 150,
      width: Get.width / 1,
      decoration: file == null
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1, color: Colors.black26),
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1, color: Colors.black26),
              image: DecorationImage(image: FileImage(file), fit: BoxFit.fill)),
      alignment: Alignment.center,
      child: file == null
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                hintText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.black54),
              ),
            )
          : Container(),
    );
  }

  Widget EmptyaudioBox() {
    return Container(
      height: 65,
      width: Get.width / 1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: Colors.black26),
      ),
      alignment: Alignment.center,
      child: const SoundRecorderWidget(),
    );
  }



  Widget audioPlayerWidget({ required List<File>audioFiles,required int index}) {
    return AudioPlayerWidget(audioFiles: audioFiles, index: index,
    
    );
  }

}