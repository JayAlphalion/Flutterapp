// import 'dart:ui';

// import 'package:alpha_app/Model/ChatModel.dart';
// import 'package:alpha_app/utils/Constants.dart';
// import 'package:alpha_app/widgets/ImageOrDocComponents/ImageOrDocItemForReceiver.dart';
// import 'package:alpha_app/widgets/ImageOrDocComponents/ImageOrDocItemForSender.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';


// class ImageDecider extends StatefulWidget {
//   Key key,
//     this.task,
//     this.onDismissed,
   
//     this.onDownloadLink,
//     this.chatMessage,
//     this.index,
//   }) : super(key: key);

//   /// The [UploadTask].
//   final firebase_storage.UploadTask /*!*/ task;

//   /// Triggered when the user dismisses the task from the list.
//   final VoidCallback /*!*/ onDismissed;

  

//   /// Triggered when the user presses the "link" button on a completed upload task.
//   final Function /*!*/ onDownloadLink;
//   final ChatMessage chatMessage;
//   final int index;

//   @override
//   State<ImageOrDocItemForSender> createState() => _ImageOrDocItemForSenderState();
// }

// class _ImageOrDocItemForSenderState extends State<ImageOrDocItemForSender> {
//   /// Displays the current transferred bytes of the task.
//   String _bytesTransferred(firebase_storage.TaskSnapshot snapshot) {
//     return '${snapshot.bytesTransferred}/${snapshot.totalBytes}';
//   }

//   @override
//   void initState() {
//     // debugger();
//     print(widget.chatMessage);
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return widget.chatMessage.messageOwner==Constant.Sender?
//           widget.chatMessage.isHistory==true?
//            ImageOrDocItemForReceiver(
//                                                   chatMessage: widget.chatMessage,
//                                                   ):ImageOrDocItemForSender(
//                                                   task: widget.uploadTask,
//                                                   onDismissed: () =>
//                                                       _removeTaskAtIndex(index),
//                                                   onDownloadLink: () {
//                                                     return getUrl(
//                                                         _uploadTasks[index]
//                                                             .snapshot
//                                                             .ref);
//                                                   },
//                                                   chatMessage: messages[index],
//                                                   index: index)

//   }

// /**
//  * This Method is Responsible for Remove Uploading task from given index.
//  * [index] Required Parameter is Index. 
//  */
//   void _removeTaskAtIndex(int index) {
//     setState(() {
//       _uploadTasks = _uploadTasks..removeAt(index);
//     });
//   }
// }