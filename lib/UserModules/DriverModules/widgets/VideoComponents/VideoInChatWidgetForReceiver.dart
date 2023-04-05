// @dart=2.9
// import 'package:alpha_app/Model/chatMessage.dart';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:alpha_app/Universals/HelperViews/VideoPlayerPage.dart';
import 'package:alpha_app/Universals/helper/ToastHelper.dart';
import 'package:alpha_app/UserModules/DriverModules/Model/ChatModel.dart';
import 'package:alpha_app/UserModules/DriverModules/Model/chat_model.dart';
import 'package:alpha_app/Universals/HelperViews/ImagePreviewScreen.dart';
import 'package:alpha_app/Universals/helper/DownloadHelper.dart';
import 'package:alpha_app/Universals/helper/FileTypeHelper.dart';
import 'package:alpha_app/Universals/utils/AppColors.dart';
import 'package:alpha_app/Universals/utils/Constants.dart';
import 'package:alpha_app/Universals/utils/ImageUtils.dart';
import 'package:alpha_app/UserModules/DriverModules/widgets/DownloadIconWidget.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:lottie/lottie.dart';
import 'package:open_filex/open_filex.dart';
import 'package:video_player/video_player.dart';

class VideoInChatWidgetForReceiver extends StatefulWidget {
  const VideoInChatWidgetForReceiver({
    Key key,
    this.chatMessage,
    this.index,
  }) : super(key: key);

  final ChatMessage chatMessage;
  final int index;

  @override
  State<VideoInChatWidgetForReceiver> createState() =>
      _VideoInChatWidgetForReceiverState();
}

class _VideoInChatWidgetForReceiverState
    extends State<VideoInChatWidgetForReceiver> {
  /// Displays the current transferred bytes of the task.
  String _bytesTransferred(firebase_storage.TaskSnapshot snapshot) {
    return '${snapshot.bytesTransferred}/${snapshot.totalBytes}';
  }

  VideoPlayerController _controller;
  bool isDownloaded = false;
  String downloadedPercentage = '-1';
  bool isDownloading = false;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.chatMessage.url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        if (mounted) {
          setState(() {});
        }
      });
    getFileInfo();
    // _controller.play();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  getFileInfo() async {
    var dir = await DownloadsPathProvider.downloadsDirectory;
    if (dir != null) {
      String savename = widget.chatMessage.fileName;
      String savePath = dir.path + "/$savename";
      bool isExists = await File(savePath).exists();
      if (isExists == true) {
        setState(() {
          isDownloaded = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: widget.chatMessage.isHistory == true &&
                  widget.chatMessage.messageOwner == Constant.Sender
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [imageViewForReciver(context)],
        ));
  }

  Widget imageViewForReciver(context) {
    return Container(
      //   height: Get.height / 3,
      child: InkWell(
          onTap: () async {
            
            if (isDownloaded == true) {
              //play locally this video because this is already downloaded.
              playLocally();
            } else {
              Get.to(VideoPlayerPage(
                url: widget.chatMessage.url,
              ));
              if (isDownloading == false) {
                downloadThisFile();
              }
            }
          },
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            decoration: BoxDecoration(
                border: Border.all(width: 4, color: Colors.white)),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  children: [
                    widget.chatMessage.messageOwner == Constant.Sender
                        ? Container()
                        : Container(
                            width: Get.width / 1,
                            color: widget.chatMessage.messageOwner ==
                                    Constant.Sender
                                ? AppColors.chatBgColor
                                : Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, right: 10, left: 0, bottom: 5),
                              child: Text(
                                widget.chatMessage.from,
                                style: TextStyle(
                                    color: Colors.blue[200], fontSize: 14),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                        height: Get.height / 4,
                        alignment: Alignment.center,
                        child: VideoPlayer(_controller)),
                    Container(
                      width: Get.width / 1,
                      height: 40,
                      color: widget.chatMessage.messageOwner == Constant.Sender
                          ? AppColors.chatBgColor
                          : Colors.white,
                      // alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, right: 0, left: 0, bottom: 0),
                        child: Text(
                          widget.chatMessage.fileName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ),
                    ),
                    Container(
                      width: Get.width / 1,
                      color: Colors.white,
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 5, right: 10, left: 0, bottom: 0),
                        child: Text(
                          widget.chatMessage.dateTime,
                          style: TextStyle(
                              color: AppColors.chatDateTimeColor, fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                ),
                isDownloaded == true
                    ? InkWell(
                        onTap: () async {
                          playLocally();
                        },
                        child: Icon(
                          Icons.play_arrow,
                          size: 50,
                          color: Colors.white,
                        ),
                      )
                    : InkWell(
                        onTap: () {
                        if(isDownloading){
                          //pause downloading.
                          ToastHelper().showToast(message: 'Right now stop feature is pending');

                        }else{
                            downloadThisFile();
                        }
                        },
                        child: DownloadIconWidget(
                          downloadedPercentage: downloadedPercentage,
                          isDownloaded: isDownloaded,
                          isDownloading: isDownloading,
                        ),
                      )
              ],
            ),
          )),
    );
  }

  void downloadThisFile() async {
    setState(() {
      isDownloading = true;
    });
    await DownloadHelper().downloadThisItem(
        url: widget.chatMessage.url,
        nameWithType: widget.chatMessage.fileName,
        onCallBack: (e) {
          print(e);
          setState(() {
            downloadedPercentage = e;
          });
          if (e == '100%') {
            setState(() {
              isDownloaded = true;
            });
          }
          // print(e);
        });
  }

  void playLocally() async {
    var dir = await DownloadsPathProvider.downloadsDirectory;
    if (dir != null) {
      String savename = widget.chatMessage.fileName;
      String savePath = dir.path + "/$savename";
      print(savePath);
      try {
        await OpenFilex.open(savePath);
      } catch (e) {
        print(e);
      }
    }
  }
}
