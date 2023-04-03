// @dart=2.9
// import 'package:alpha_app/Model/chatMessage.dart';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:alpha_app/Universals/Widgets/HelperWidget.dart';
import 'package:intl/intl.dart';
import 'package:alpha_app/UserModules/DriverModules/Model/ChatModel.dart';
import 'package:alpha_app/UserModules/DriverModules/Model/chat_model.dart';
import 'package:alpha_app/Universals/HelperViews/ImagePreviewScreen.dart';
import 'package:alpha_app/Universals/helper/FileTypeHelper.dart';
import 'package:alpha_app/Universals/utils/AppColors.dart';
import 'package:alpha_app/Universals/utils/Constants.dart';
import 'package:alpha_app/Universals/utils/ImageUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:lottie/lottie.dart';
import 'package:open_filex/open_filex.dart';
import 'package:video_player/video_player.dart';

class VideoInChatWidgetForSender extends StatefulWidget {
  const VideoInChatWidgetForSender({
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
  State<VideoInChatWidgetForSender> createState() =>
      _VideoInChatWidgetForSenderState();
}

class _VideoInChatWidgetForSenderState
    extends State<VideoInChatWidgetForSender> {
  /// Displays the current transferred bytes of the task.
  String _bytesTransferred(firebase_storage.TaskSnapshot snapshot) {
    return '${snapshot.bytesTransferred}/${snapshot.totalBytes}';
  }

  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.chatMessage.fileName)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    // _controller.play();
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
                  const EdgeInsets.only(top: 8, bottom: 30, left: 8, right: 8),
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment:
                    widget.chatMessage.messageOwner == Constant.Reciver
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                children: [
                  // chatMessage.messageOwner == Constant.Sender
                  //     ?
                  imageView(context, state)
                ],
              ));
        });
  }

  Widget imageView(context, firebase_storage.TaskState state) {
    return Container(
      // height: Get.height / 3,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
      ),
      child: InkWell(
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
          child:
              //for image.
              Container(
            child: Stack(
              children: [
                Container(
                  // height: Get.height / 2.,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border:
                          Border.all(width: 4, color: AppColors.chatBgColor)),
                  child: Column(
                    children: [
                      Container(
                          height: Get.height / 3.5,
                          alignment: Alignment.center,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                  height: Get.height / 3.5,
                                  alignment: Alignment.center,
                                  child: VideoPlayer(_controller)),
                              state == firebase_storage.TaskState.running
                                  ? HelperWidget.UploadLoaderWidget()
                                  : const Icon(
                                      Icons.play_arrow,
                                      size: 30,
                                      color: AppColors.chatBgColor,
                                    )
                            ],
                          )),
                      Container(
                        color: AppColors.chatBgColor,
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 40,
                              width: Get.width / 1,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, right: 0, left: 0, bottom: 0),
                                child: Text(
                                  widget.chatMessage.fileName.split('/').last,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                              ),
                            ),
                            Container(
                              width: Get.width / 1,
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, right: 10, left: 0, bottom: 0),
                                child: Text(
                                  widget.chatMessage.dateTime,
                                  style: TextStyle(
                                      color: AppColors.chatDateTimeColor,
                                      fontSize: 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
