// import 'dart:developer';
// import 'dart:async';
// import 'dart:io';
// import 'dart:isolate';
// import 'dart:ui';
// import 'package:dio/dio.dart';
// import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:get/get.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

// class TestPage extends StatefulWidget {
//   const TestPage({Key? key}) : super(key: key);

//   @override
//   State<TestPage> createState() => _TestPageState();
// }

// class _TestPageState extends State<TestPage> {
//   ReceivePort _port = ReceivePort();
//   List<Map> downloadsListMaps = [];
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _bindBackgroundIsolate();
//     FlutterDownloader.registerCallback(downloadCallback);
//   }

//   static void downloadCallback(
//       String id, DownloadTaskStatus status, int progress) {
//     final SendPort? send =
//         IsolateNameServer.lookupPortByName('downloader_send_port');
//     send!.send([id, status, progress]);
//   }

//   void _unbindBackgroundIsolate() {
//     IsolateNameServer.removePortNameMapping('downloader_send_port');
//   }

//   void _bindBackgroundIsolate() {
//     bool isSuccess = IsolateNameServer.registerPortWithName(
//         _port.sendPort, 'downloader_send_port');
//     if (!isSuccess) {
//       _unbindBackgroundIsolate();
//       _bindBackgroundIsolate();
//       return;
//     }
//     _port.listen((dynamic data) {
//       String id = data[0];
//       DownloadTaskStatus status = data[1];
//       int progress = data[2];
//       var task = downloadsListMaps.where((element) => element['id'] == id);
//       task.forEach((element) {
//         element['progress'] = progress;
//         element['status'] = status;
//         setState(() {});
//       });
//     });
//   }

//   Future task() async {
//     List<DownloadTask>? getTasks = await FlutterDownloader.loadTasks();
//     getTasks!.forEach((_task) {
//       Map _map = Map();
//       _map['status'] = _task.status;
//       _map['progress'] = _task.progress;
//       _map['id'] = _task.taskId;
//       _map['filename'] = _task.filename;
//       _map['savedDirectory'] = _task.savedDir;
//       downloadsListMaps.add(_map);
//     });
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           children: [
//             InkWell(
//               onTap: () async {
//                 requestDownload(
//                     'https://firebasestorage.googleapis.com/v0/b/alphadatabase-6609c.appspot.com/o/chatdoc%2FPXL_20221224_194342332.MP.jpg?alt=media&token=ca38350a-ea0d-4f1d-895e-d31969591222',
//                     'File ${1 + 1}');
//                 // final taskId = await FlutterDownloader.enqueue(
//                 //   url:
//                 //       'https://firebasestorage.googleapis.com/v0/b/alphadatabase-6609c.appspot.com/o/chatdoc%2FPXL_20221224_194342332.MP.jpg?alt=media&token=ca38350a-ea0d-4f1d-895e-d31969591222',
//                 //   headers: {}, // optional: header send with url (auth token etc)
//                 //   savedDir:
//                 //       'the path of directory where you want to save downloaded files',
//                 //   showNotification:
//                 //       true, // show download progress in status bar (for Android)
//                 //   openFileFromNotification:
//                 //       true, // click on notification to open downloaded file (for Android)
//                 // );
//               },
//               child: Container(
//                 height: 100,
//                 width: Get.width / 2,
//                 alignment: Alignment.center,
//                 child: Text("Tap me"),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

  
//   // showDialogue(File file) {
//   //   return showDialog(
//   //       context: context,
//   //       builder: (context) {
//   //         return Dialog(
//   //           shape: RoundedRectangleBorder(
//   //               borderRadius: BorderRadius.all(Radius.circular(8))),
//   //           child: Padding(
//   //             padding: const EdgeInsets.all(2.0),
//   //             child: Container(
//   //               child: Image.file(
//   //                 file,
//   //                 fit: BoxFit.cover,
//   //               ),
//   //             ),
//   //           ),
//   //         );
//   //       });
//   //}
// }
