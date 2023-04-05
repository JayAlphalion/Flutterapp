import 'dart:io';

import 'package:alpha_app/Universals/helper/ToastHelper.dart';
import 'package:alpha_app/Universals/utils/ImageUtils.dart';
import 'package:alpha_app/UserModules/DriverModules/Model/ChatModel.dart';
import 'package:alpha_app/Universals/helper/DownloadHelper.dart';
import 'package:alpha_app/Universals/utils/AppColors.dart';
import 'package:alpha_app/Universals/utils/Constants.dart';
import 'package:alpha_app/UserModules/DriverModules/widgets/DownloadIconWidget.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';

class FileWidgetForReceiver extends StatefulWidget {
  final ChatMessage chatMessage;
  FileWidgetForReceiver({required this.chatMessage});

  @override
  State<FileWidgetForReceiver> createState() => _FileWidgetForReceiverState();
}

class _FileWidgetForReceiverState extends State<FileWidgetForReceiver> {
  bool isDownloaded = false;
  String downloadedPercentage = '-1';

  bool isDownloading = false;

  @override
  void initState() {
    getFileInfo();
    // TODO: implement initState
    super.initState();
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

  getFileInfo() async {
    var dir = await DownloadsPathProvider.downloadsDirectory;
    if (dir != null) {
      String savename = widget.chatMessage.fileName;
      String savePath = dir.path + "/$savename";
      bool isExists = await File(savePath).exists();
      if (isExists == true) {
      if(mounted){
          setState(() {
          isDownloaded = true;
        });
      }
      }
    }
  }

  void openLocally() async {
    var dir = await DownloadsPathProvider.downloadsDirectory;
    if (dir != null) {
      String savename = widget.chatMessage.fileName;
      String savePath = dir.path + "/$savename";
      print(savePath);
      try {
        var res = await OpenFilex.open(savePath);
        ToastHelper().showToast(message: res.message);
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (isDownloaded == true) {
          openLocally();
        } else if (isDownloading == true) {
          ToastHelper().showErrorToast(message: 'Stop feature is pending');
        } else {
          downloadThisFile();
        }
      },
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        // height: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                width: 4,
                color: widget.chatMessage.messageOwner == Constant.Sender
                    ? AppColors.chatBgColor
                    : Colors.white)),

        child: Column(
          children: [
            widget.chatMessage.messageOwner == Constant.Sender
                ? Container()
                : Container(
                    width: Get.width / 1,
                    color: widget.chatMessage.messageOwner == Constant.Sender
                        ? AppColors.chatBgColor
                        : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 5, right: 10, left: 0, bottom: 5),
                      child: Text(
                        widget.chatMessage.from,
                        style: TextStyle(color: Colors.blue[200], fontSize: 14),
                      ),
                    ),
                  ),
            // SizedBox(
            //   height: 5,
            // ),
            Container(
              color:widget.chatMessage.messageOwner == Constant.Sender?AppColors.chatBgColor: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8, top: 5, right: 5, bottom: 5),
                child: Row(
                  children: [
                    isDownloaded == true
                        ? Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Image.asset(ImageUtils.OTHER_FILE_ICON,
                            height: 35,width: 35,
                            )
                          )
                        : Padding(
                            padding:
                                const EdgeInsets.only(bottom: 1.0, right: 5),
                            child: DownloadIconWidget(
                              downloadedPercentage: downloadedPercentage,
                              isDownloaded: isDownloaded,
                              isDownloading: isDownloading,
                              radius: 20,
                              iconSize: 20,
                            ),
                          ),
                    Expanded(
                      child: Text(
                        widget.chatMessage.fileName,
                        style: TextStyle(
                            color: Color.fromARGB(255, 214, 169, 169),
                            fontSize: 14),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: Get.width / 1,
              color: widget.chatMessage.messageOwner == Constant.Sender
                  ? AppColors.chatBgColor
                  : Colors.white,
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
      ),
    );
  }
}
