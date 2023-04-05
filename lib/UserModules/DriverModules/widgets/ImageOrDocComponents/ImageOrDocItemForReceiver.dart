// @dart=2.9
// import 'package:alpha_app/Model/chatMessage.dart';
import 'dart:developer';
// import 'dart:html';
import 'dart:io';
// import 'dart:math';
import 'dart:ui';

import 'package:alpha_app/UserModules/DriverModules/Model/ChatModel.dart';
import 'package:alpha_app/UserModules/DriverModules/Model/chat_model.dart';
import 'package:alpha_app/Universals/HelperViews/ImagePreviewScreen.dart';
import 'package:alpha_app/Universals/helper/DownloadHelper.dart';
import 'package:alpha_app/Universals/helper/FileTypeHelper.dart';
import 'package:alpha_app/Universals/helper/ToastHelper.dart';
import 'package:alpha_app/Universals/utils/AppColors.dart';
import 'package:alpha_app/Universals/utils/Constants.dart';
import 'package:alpha_app/Universals/utils/ImageUtils.dart';
import 'package:alpha_app/UserModules/DriverModules/widgets/DownloadIconWidget.dart';
import 'package:alpha_app/UserModules/DriverModules/widgets/FileComponents/FileWidgetForReceiver.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:lottie/lottie.dart';
import 'package:open_filex/open_filex.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageOrDocItemForReceiver extends StatefulWidget {
  const ImageOrDocItemForReceiver({
    Key key,
    // this.task,
    // this.onDismissed,
    // this.onDownload,
    // this.onDownloadLink,
    this.chatMessage,
    this.index,
  }) : super(key: key);
  final ChatMessage chatMessage;
  final int index;

  @override
  State<ImageOrDocItemForReceiver> createState() =>
      _ImageOrDocItemForReceiverState();
}

class _ImageOrDocItemForReceiverState extends State<ImageOrDocItemForReceiver> {
  bool isDownloaded = false;
  String downloadedPercentage = '-1';

  /// Displays the current transferred bytes of the task.
  String _bytesTransferred(firebase_storage.TaskSnapshot snapshot) {
    return '${snapshot.bytesTransferred}/${snapshot.totalBytes}';
  }
bool isDownloading=false;
  @override
  void initState() {
    getFileInfo();
    // TODO: implement initState
    super.initState();
  }

  getFileInfo() async {
    var dir = await DownloadsPathProvider.downloadsDirectory;
    if (dir != null) {
      String savename = widget.chatMessage.fileName;
      String savePath = dir.path + "/$savename";
      bool isExists = await File(savePath).exists();
      // debugger();
      // print(isExists);
      if (isExists == true) {
        if (mounted) {
          setState(() {
            isDownloaded = true;
          });
        }
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
      child: GetFile.getDocOrImgOrFile(widget.chatMessage.fileType) ==
              Constant.DocxMessage
          ?
          //DOc view
          InkWell(
              onTap: () async {
                downloadThisFile();
              },
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      //   height: Get.height / 3,
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              width: 5,
                              color: widget.chatMessage.messageOwner ==
                                      Constant.Sender
                                  ? AppColors.chatBgColor
                                  : Colors.white)),
                      child: Column(
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
                                          color: Colors.blue[200],
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                         
                          Container(
                              color:widget.chatMessage.messageOwner == Constant.Sender?AppColors.chatBgColor: Colors.white,
                              height: Get.height / 5,
                              alignment: Alignment.center,
                              child:
                                  GetFile.getIcon(widget.chatMessage.fileType)),
                          Container(
                            width: Get.width / 1,
                            height: 40,
                            color: widget.chatMessage.messageOwner ==
                                    Constant.Sender
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
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                            ),
                          ),
                          Container(
                            width: Get.width / 1,
                            color: widget.chatMessage.messageOwner ==
                                    Constant.Sender
                                ? AppColors.chatBgColor
                                : Colors.white,
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
                    ),
                    DownloadIconWidget(
                        downloadedPercentage: downloadedPercentage,
                        isDownloaded: isDownloaded,
                        isDownloading: isDownloading,
                        )
                  ],
                ),
              ),
            )
          : GetFile.getDocOrImgOrFile(widget.chatMessage.fileType) ==
                  Constant.OthersFile
              ?
              //FIle view
              FileWidgetForReceiver(chatMessage: widget.chatMessage)
              :
              //image view
              InkWell(
                  onTap: () {
                    downloadThisFile();
                    // Get.to(ImagePrivewScreen(url: widget.chatMessage.url));
                  },
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 4,
                            color: widget.chatMessage.messageOwner ==
                                    Constant.Sender
                                ? AppColors.chatBgColor
                                : Colors.white)),
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
                                          top: 5,
                                          right: 10,
                                          left: 0,
                                          bottom: 5),
                                      child: Text(
                                        widget.chatMessage.from,
                                        style: TextStyle(
                                            color: Colors.blue[200],
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                            // SizedBox(
                            //   height: 5,
                            // ),
                            Container(

                                // color: Colors.blue,
                                // alignment: Alignment.center,
                                child: Stack(
                              children: [
                                Container(
                                  height: Get.height / 4,
                                  width: Get.width / 1,
                                  child: Image.network(
                                    widget.chatMessage.url,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            )),
                            Container(
                              width: Get.width / 1,
                              color: widget.chatMessage.messageOwner ==
                                      Constant.Sender
                                  ? AppColors.chatBgColor
                                  : Colors.white,
                              // alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, right: 0, left: 0, bottom: 0),
                                child: Text(
                                  widget.chatMessage.fileName,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                              ),
                            ),
                            Container(
                              width: Get.width / 1,
                              color: widget.chatMessage.messageOwner ==
                                      Constant.Sender
                                  ? AppColors.chatBgColor
                                  : Colors.white,
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
                        DownloadIconWidget(
                            downloadedPercentage: downloadedPercentage,
                            isDownloaded: isDownloaded)
                      ],
                    ),
                  ),
                ),
    );
  }

  void downloadThisFile() async {
    if (isDownloaded == true) {
      // debugger();
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
    } else {
       setState(() {
        isDownloading=true;
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
  }
}
