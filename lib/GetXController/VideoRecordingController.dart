// import 'dart:async';

// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';

// class VideoRecordingController extends GetxController {
//   Timer? time;
//   RxBool isRecording = false.obs;
//   RxInt percent = 1.obs;

//   void startRecording() {
//     isRecording.value = true;
//     record();
//   }

//   void record() {
//     time = Timer.periodic(const Duration(seconds: 1), (t) {
//       if (percent.value != 20) {
//         percent.value = percent.value + 1;
//         update();
//       } else {
//         time!.cancel();
//       }
//     });
//   }
//   void stopRecording(){
//     time!.cancel();
//     isRecording.value=false;
//     update();
//   }
// }
