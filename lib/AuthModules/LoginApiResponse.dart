class LoginApiResponse {
  LoginApiResponse({
    required this.message,
    required this.userId,
    required this.name,
    required this.userToken,
    required this.channelId,
    required this.chatinit,
    required this.groupId
  });
  late final String message;
  late final String userId;
  late final String name;
  late final String userToken;
  late final String channelId;
  late final String chatinit;
  late final String groupId;
  
  LoginApiResponse.fromJson(Map<String, dynamic> json){
    message = json['message'];
    userId = json['userId'];
    name = json['name'];
    userToken = json['userToken'];
    channelId = json['channel_id'];
    chatinit = json['chatinit'];
    groupId=json['group_id'];
  }
}