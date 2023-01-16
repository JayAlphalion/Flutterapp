import 'package:flutter/cupertino.dart';

class ChatMessage{
  String messageId;
  String messageContent;
  String messageOwner;
  String messageType;
  String fileName;
  String fileType;
  String url;
  String from;
  String dateTime;
  bool isHistory;
  ChatMessage({
    required this.messageId,
    required this.messageContent, required this.messageOwner,required this.messageType,required this.fileName,
  required this.fileType, required this.url, required this.from, required this.dateTime,
  required this.isHistory
  });
}