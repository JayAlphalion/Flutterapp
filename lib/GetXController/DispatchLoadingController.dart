import 'package:get/get.dart';

class DispatchLoadingController extends GetxController{
 var isLoading=true.obs;

void updateLoading(){
  isLoading.value=!isLoading.value;
}

}