import 'dart:developer';
import 'dart:io';

import 'package:alpha_app/Universals/Widgets/HelperWidget.dart';
import 'package:alpha_app/UserModules/DriverModules/Views/claims/RecordVideoPage.dart';
import 'package:alpha_app/Universals/helper/ImagePickerHelper.dart';
import 'package:alpha_app/Universals/networking/EventBusManager.dart';
import 'package:alpha_app/Universals/utils/AppColors.dart';
import 'package:alpha_app/Universals/utils/Constants.dart';
import 'package:alpha_app/UserModules/DriverModules/widgets/AudioPlayerWidget.dart';
import 'package:alpha_app/UserModules/DriverModules/widgets/SoundRecorderWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';

class AddClaimPageWidgets {
  Widget audioRecordedWidget(
      {required String title, required List<File> audioFiles}) {
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
        
      ],
    );
  }

//video widget.

  Widget videoRecordedWidget(
      {required String title, required List<File> videoFiles, context,
     
      }) {
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
        EmptyVideoBox(context),
       
      ],
    );
  }

  // void uploadImageToTheFirebase(File file, String key) {}

  Widget imageBox(String hintText, File file) {
    return 

        Container(
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

  Widget EmptyVideoBox(context) {
    return Container(
        height: 65,
        width: Get.width / 1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.black26),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
                child: Material(
              color: Colors.blue[100],
              child: InkWell(
                child: SizedBox(
                    width: 45,
                    height: 45,
                    child: Icon(Icons.videocam,
                        color: Theme.of(context).primaryColor, size: 25)),
                onTap: () {
                  Get.to(RecordVideoPage())!.then((value) {
                    if(value!=null){
                      EventBusManager.videoRecorderEventBuss.fire(value);
                    }
                  });
                },
              ),
            ),
            
            ),
            SizedBox(width: 38,),
            Text(
              "Tap to Record",
            
            )
          ],
        ));
  }

  Widget audioPlayerWidget(
      {required List<File> audioFiles, required int index}) {
    return AudioPlayerWidget(
      audioFiles: audioFiles,
      index: index,
    );
  }

Widget videoPlayerWidget(
      {required List<File> audioFiles, required int index,required bool isUploaded}){
    return Container(
      width: Get.width / 1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: Colors.black26),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
                onTap: ()async {
                  print(audioFiles[index]);
                  // debugger();
                  // print("ere");
                  try{
                     await OpenFilex.open(audioFiles[index].path);
                  }catch(e){
                    // debugger();
                    print(e);
                  }
                },
                child: isUploaded==true
                                  ? HelperWidget.UploadLoaderWidget()
                                  : Icon(
                Icons.play_arrow,
                  size: 35,
                  color: AppColors.primaryColor,
                )),
            const SizedBox(
              width: 10,
            ),
            Expanded(child: 
            Text(audioFiles[index].path.split('/').last,
            style: TextStyle(color: Colors.black87,fontSize: 13),
            )
            )
        ])    
               
                      
          
        ),
      );
  }


}
