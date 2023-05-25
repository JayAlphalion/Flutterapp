class ChatHistoryApiResponse {
  ChatHistoryApiResponse({
    required this.messages,
  });
  late final List<Messages> messages;

  ChatHistoryApiResponse.fromJson(Map<String, dynamic> json) {
    messages =
        List.from(json['messages']).map((e) => Messages.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['messages'] = messages.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Messages {
  Messages({
    required this.data,
  });
  late final Message data;

  Messages.fromJson(Map<String, dynamic> json) {
    data = Message.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    return _data;
  }
}

class Message {
  Message({
    required this.typeOfMsg,
    required this.userToken,
    required this.text,
    required this.deletedForMe,
    required this.fileName,
    required this.createdAt,
    required this.url,
    required this.groupId,
    required this.to,
    required this.userId,
    required this.user_id,
    required this.messageId,
    required this.seenBy,
    required this.from,
    required this.deletedForEveryone,
    required this.isSeen,
  });
  late final String typeOfMsg;
  late final String userToken;
  late final String text;
  late final String deletedForMe;
  late final String fileName;
  late final String createdAt;
  late final String url;
  late final String groupId;
  late final String to;
  late final String userId;
  late final String user_id;
  late final String messageId;
  late final List<dynamic> seenBy;
  late final String from;
  late final String deletedForEveryone;
  late final String isSeen;

  Message.fromJson(Map<String, dynamic> json) {
    typeOfMsg = json['typeOfMsg'].toString();
    userToken = json['userToken'].toString();
    text = json['text'].toString();
    deletedForMe = json['deletedForMe'].toString();
    fileName = json['fileName'].toString();
    createdAt = json['createdAt'].toString();
    url = json['url'].toString();
    groupId = json['groupId'].toString();
    to = json['to'].toString();
    userId = json['userId'].toString();
    user_id = json['userd'].toString();
    messageId = json['messageId'].toString();
    seenBy = json['seenBy'];
    from = json['from'].toString();
    deletedForEveryone = json['deletedForEveryone'].toString();
    isSeen = json['isSeen'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['typeOfMsg'] = typeOfMsg;
    _data['user_token'] = userToken;
    _data['text'] = text;
    _data['deletedForMe'] = deletedForMe;
    _data['file_name'] = fileName;
    _data['created_at'] = createdAt;
    _data['url'] = url;
    _data['group_id'] = groupId;
    _data['to'] = to;
    _data['userId'] = userId;
    _data['message_id'] = messageId;
    _data['seenBy'] = seenBy;
    _data['from'] = from;
    _data['deletedForEveryone'] = deletedForEveryone;
    _data['isSeen'] = isSeen;
    return _data;
  }
}
