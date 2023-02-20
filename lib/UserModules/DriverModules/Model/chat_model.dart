import 'dart:convert';


class ChatModel {
  String userId;
  String token;
  String channelId;
  String channelName;
  ChatModel(
      {required this.userId,
      required this.token,
      required this.channelId,
      required this.channelName});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'token': token,
      'channelId': channelId,
      'channelName': channelName,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      userId: map['userId'] ?? '',
      token: map['token'] ?? '',
      channelId: map['channelId'] ?? '',
      channelName: map['channelName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ChatModel(userId: $userId, token: $token, channelId: $channelId, channelName: $channelName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatModel &&
        other.userId == userId &&
        other.token == token &&
        other.channelId == channelId &&
        other.channelName == channelName;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        token.hashCode ^
        channelId.hashCode ^
        channelName.hashCode;
  }
}
