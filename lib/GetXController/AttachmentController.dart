import 'package:get/get.dart';

class AttachmentController extends GetxController{
  bool isAttachmentActive=true;
  void changeState(bool val){
    isAttachmentActive=val;
    update();
  }
}