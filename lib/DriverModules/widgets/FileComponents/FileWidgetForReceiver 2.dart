import 'dart:io';

import 'package:alpha_app/DriverModules/Model/ChatModel.dart';
import 'package:alpha_app/Universals/helper/DownloadHelper.dart';
import 'package:alpha_app/Universals/utils/AppColors.dart';
import 'package:alpha_app/Universals/utils/Constants.dart';
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
      if (isExists == true) {
        setState(() {
          isDownloaded = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
       onTap: () async {
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
                    },
                  
                  
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        // height: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 4, color: 
            widget.chatMessage.messageOwner ==
                                      Constant.Sender
                                  ? AppColors.chatBgColor:
            Colors.white)),
    
        child: Column(
          children: [
         widget.chatMessage.messageOwner == Constant.Sender
                              ? Container()
                              :   Container(
              width: Get.width / 1,
              color:
              widget.chatMessage.messageOwner ==
                                      Constant.Sender
                                  ? AppColors.chatBgColor: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 5, right: 10, left: 0, bottom: 5),
                child: Text(
                  widget.chatMessage.from,
                  style: TextStyle(color: Colors.blue[200], fontSize: 14),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  isDownloaded == true
                        ? Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Icon(
                              Icons.file_copy_rounded,
                              size: 40,
                              color: Colors.blue,
                            ),
                          )
                        : downloadedPercentage == '-1'
                            ? Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Icon(Icons.download,
                                    size: 50, color: Colors.blue),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Text(
                                  downloadedPercentage,
                                  style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 15),
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
            Container(
              width: Get.width / 1,
              color:
              widget.chatMessage.messageOwner ==
                                      Constant.Sender
                                  ? AppColors.chatBgColor:
               Colors.white,
              alignment: Alignment.centerRight,
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 5, right: 10, left: 0, bottom: 0),
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
