class SocketChatModel {
  String messageId;
  String msgBody;
  String createdAt;
  String deletedForEveryOne;
  String deltedForMe;
  String deliveredTime;
  String url;
  String from;
  String isSeen;
  List<dynamic> seenBy;
  String to;
  String typeOfMsg;
  String userToken;
  String fileName;
  String groupId;
  String userId;

  SocketChatModel(
      {
        required this.messageId,
        required this.msgBody,
      required this.createdAt,
      required this.deletedForEveryOne,
      required this.deltedForMe,
      required this.deliveredTime,
      required this.url,
      required this.from,
      required this.isSeen,
      required this.seenBy,
      required this.to,
      required this.typeOfMsg,
      required this.userToken,
      required this.fileName,
      required this.groupId,
      required this.userId
      });
}
