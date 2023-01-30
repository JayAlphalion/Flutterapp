// // import 'package:connectivity/connectivity.dart';
// import 'dart:developer';

// import 'package:alpha_app/networking/SocketHelper.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:get/get.dart';

// /**
//  * This Function will check internet connnection connectivity.
//  * [c] : Requested Parameter will be bool value.
//  */
// checkNetworkSubSubscription(c) {
//   var subscription;
//   SocketService socketServices = SocketService();
//   subscription =
//       Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
//     if (result == ConnectivityResult.none) {
//       //show dialog without context
//       if (c.isActive == false) {
//         Get.dialog(
//           NoInternetConnectionDialog(
//             onPressed: () async {
//               bool status = await _checkNetwork();
//               if (status) {
//                 c.changeState(false);
//                 Get.back();

//                 //socketServices.sendMessage(StringUtils.DUMY_MESSAGE);

//               } else {
//                 OpenSettings.openWIFISetting();
//               }
//             },
//           ),
//           barrierDismissible: false,
//         );
//         c.changeState(true);
//       }
//     } else {
//       if (c.isActive.toString() == 'true') {
//         c.changeState(false);
//         // socketServices.sendMessage(StringUtils.DUMY_MESSAGE);

//         Get.back();
//       }
//     }
//   });
// }

// /**
//  * This Function will check internet connnection connectivity.
//  */
// Future<bool> _checkNetwork() async {
//   var connectivityResult = await (Connectivity().checkConnectivity());
//   if (connectivityResult == ConnectivityResult.none) {
//     return false;
//   } else {
//     return true;
//   }
// }
