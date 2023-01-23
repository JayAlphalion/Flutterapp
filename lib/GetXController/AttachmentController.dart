import 'package:alpha_app/utils/Constants.dart';
import 'package:get/get.dart';

class AttachmentController extends GetxController{
  bool isAttachmentActive=true;
  String recordingStatus=Constant.NonStart;

  void changeState(bool val){
    isAttachmentActive=val;
    update();
  }

void changeRecordingStatus(String val){
  recordingStatus=val;
  update();
}



}