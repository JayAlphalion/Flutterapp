import 'package:alpha_app/Universals/utils/ImageUtils.dart';
import 'package:alpha_app/UserModules/DriverModules/Model/ChatModel.dart';
import 'package:alpha_app/Universals/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FileWidgetForSender extends StatefulWidget {
  final ChatMessage chatMessage;
  FileWidgetForSender({required this.chatMessage});

  @override
  State<FileWidgetForSender> createState() => _FileWidgetForSenderState();
}

class _FileWidgetForSenderState extends State<FileWidgetForSender> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
      ),
      // height: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 4, color: AppColors.chatBgColor)),

      child: Column(
        children: [
         
         
          Container(
             color: AppColors.chatBgColor,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8,10,8,0),
              child: Row(
                children: [
                 Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Image.asset(ImageUtils.OTHER_FILE_ICON,
                            height: 35,width: 35,
                            )
                          ),
                  Expanded(
                    child: Text(
                      widget.chatMessage.fileName.split('/').last,
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
            color: AppColors.chatBgColor,
            alignment: Alignment.centerRight,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 5, right: 10, left: 0, bottom: 0),
              child: Text(
                widget.chatMessage.dateTime,
                style: TextStyle(color: AppColors.chatDateTimeColor, fontSize: 10),
              ),
            ),
          ),
          // Container(
          //   width: Get.width / 1,
          //   color: Colors.white,
          //   height: 10,
          // ),
        ],
      ),
    );
  }
}
