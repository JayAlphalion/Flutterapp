import 'dart:developer';

import 'package:alpha_app/UserModules/DriverModules/Model/ChatModel.dart';
import 'package:alpha_app/Universals/utils/Constants.dart';
import 'package:alpha_app/Universals/utils/ImageUtils.dart';
import 'package:flutter/material.dart';

class GetFile {
  static getDocOrImgOrFile(String fileName) {
    if (getFileType(fileName) == 'pdf' ||
        getFileType(fileName) == 'xlsl' ||
        getFileType(fileName) == 'xlsx' ||
        getFileType(fileName) == 'xls' ||
        getFileType(fileName) == 'docx' ||
        getFileType(fileName) == 'dot' ||
        getFileType(fileName) == 'dotx' ||
        getFileType(fileName) == 'txt' ||
        getFileType(fileName) == 'doc' ||
        getFileType(fileName) == 'psd') {
      return Constant.DocxMessage;
    } else if (getFileType(fileName) == 'png' ||
        getFileType(fileName) == 'jpg' ||
        getFileType(fileName) == 'jpeg' ||
        getFileType(fileName) == 'gif') {
      return Constant.ImageMessage;
    } else {
      return Constant.OthersFile;
    }
  }

  static String getFileType(String fileName) {
    return fileName.split('.').last;
  }

  static Widget getIcon(fileName) {
    String type = getFileType(fileName);
    if (type == 'pdf') {
      return Image.asset(
        ImageUtils.PDF_ICON,
        height: 120,
        width: 120,
      );
    } else if (type == 'xlsx' || type == 'xls') {
      return Image.asset(
        ImageUtils.EXCEL_ICON,
        height: 120,
        width: 120,
      );
    } else {
      return Image.asset(
        ImageUtils.WORD_ICON,
        height: 120,
        width: 120,
      );
    }
  }

  static String getMsgType(filePath) {
    String type = getFileType(filePath);
    if (type == 'mp4' || type == 'MOV' || type == 'WMV' || type == 'AVI') {
      return Constant.VideoMessage;
    } else if (type == 'mp3'|| type=='m4a' ) {
      return Constant.AudioMessage;
    } else if (type == 'jpg' || type == 'png') {
      return Constant.ImageMessage;
    } else {
      return Constant.DocxMessage;
    }
    debugger();
    print(type);
  }
}
