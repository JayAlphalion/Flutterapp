// @dart=2.9
// import 'package:alpha_app/Model/chatMessage.dart';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:alpha_app/UserModules/DriverModules/Model/ChatModel.dart';
import 'package:alpha_app/UserModules/DriverModules/Model/chat_model.dart';
import 'package:alpha_app/Universals/widgets/ImagePreviewScreen.dart';
import 'package:alpha_app/Universals/helper/FileTypeHelper.dart';
import 'package:alpha_app/Universals/utils/AppColors.dart';
import 'package:alpha_app/Universals/utils/Constants.dart';
import 'package:alpha_app/Universals/utils/ImageUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:lottie/lottie.dart';
import 'package:open_filex/open_filex.dart';
import 'package:video_player/video_player.dart';

class AudioFileForSender extends StatefulWidget {
  const AudioFileForSender({
    Key key,
    this.task,
    this.onDismissed,
    this.onDownloadLink,
    this.chatMessage,
    this.index,
  }) : super(key: key);

  /// The [UploadTask].
  final firebase_storage.UploadTask /*!*/ task;

  /// Triggered when the user dismisses the task from the list.
  final VoidCallback /*!*/ onDismissed;

  /// Triggered when the user presses the "link" button on a completed upload task.
  final Function /*!*/ onDownloadLink;
  final ChatMessage chatMessage;
  final int index;

  @override
  State<AudioFileForSender> createState() => _AudioFileForSenderState();
}

class _AudioFileForSenderState extends State<AudioFileForSender> {
  /// Displays the current transferred bytes of the task.
  String _bytesTransferred(firebase_storage.TaskSnapshot snapshot) {
    return '${snapshot.bytesTransferred}/${snapshot.totalBytes}';
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<firebase_storage.TaskSnapshot>(
        stream: widget.task.snapshotEvents,
        builder: (
          BuildContext context,
          AsyncSnapshot<firebase_storage.TaskSnapshot> asyncSnapshot,
        ) {
          Widget subtitle = const Text('---');
          firebase_storage.TaskSnapshot snapshot = asyncSnapshot.data;
          firebase_storage.TaskState state = snapshot?.state;

          if (asyncSnapshot.hasError) {
            if (asyncSnapshot.error is firebase_core.FirebaseException &&
                (asyncSnapshot.error as firebase_core.FirebaseException).code ==
                    'canceled') {
              subtitle = const Text('Upload canceled.');
            } else {
              // ignore: avoid_print
              print(asyncSnapshot.error);
              subtitle = const Text('Something went wrong.');
            }
          } else if (snapshot != null) {
            subtitle =
                Text('$state: ${_bytesTransferred(snapshot)} bytes sent');
            // setState(() {

            // });
          }

          return Padding(
              padding:
                  const EdgeInsets.only(top: 8, bottom: 10, left: 8, right: 8),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment:
                    widget.chatMessage.messageOwner == Constant.Reciver
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                children: [
                  // chatMessage.messageOwner == Constant.Sender
                  //     ?
                  AudioWidget(context, state)
                ],
              ));
        });
  }

  Widget AudioWidget(context, firebase_storage.TaskState state) {
    return InkWell(
      onTap: () async {
        //debugger();
        String fileType = GetFile.getFileType(widget.chatMessage.fileName);
        //  debugger();

        String url = await widget.onDownloadLink();
        try {
          await OpenFilex.open(widget.chatMessage.fileName);
        } catch (e) {
          debugger();
          print(e);
        }
      },
      // child:

      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        // height: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 4, color: AppColors.chatBgColor),
            
            color: Colors.white
            ),

        child: Column(
          children: [
            // Container(
            //   width: Get.width / 1,
            //   // color: Colors.white,
            //   child: Padding(
            //     padding: const EdgeInsets.only(
            //         top: 5, right: 10, left: 0, bottom: 5),
            //     child: Text(
            //       widget.chatMessage.from,
            //       style: TextStyle(color: Colors.blue[200], fontSize: 14),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      // audio.play(
                    },
                    child: Icon(
                      Icons.play_arrow,
                      size: 45,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          widget.chatMessage.fileName.split('/').last,
                          style: TextStyle(
                              color: Color.fromARGB(255, 214, 169, 169),
                              fontSize: 14),
                        ),
                        state == firebase_storage.TaskState.running
                            ? Container(
                                height: 30,
                                width: 30,
                                child: Lottie.asset(ImageUtils.UPLOAD_GIF),
                              )
                            : Container()
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: Get.width / 1,
              color: AppColors.chatBgColor,
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 5, right: 10, left: 0, bottom: 0),
                child: Text(
                  widget.chatMessage.dateTime,
                  style: TextStyle(color:AppColors.chatDateTimeColor, fontSize: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
