class LoginApiResponse {
  LoginApiResponse({
    required this.message,
    required this.userId,
    required this.driverId,
    required this.name,
    required this.userToken,
    required this.groupId,
    // required this.chatinit,
    required this.phoneNumber
  });
  late final String message;
  late final String userId;
  late final String driverId;
  late final String name;
  late final String userToken;
  late final String groupId;
  // late final String chatinit;
  late final String phoneNumber;
  
  LoginApiResponse.fromJson(Map<String, dynamic> json){
    message = json['message'];
    userId = json['userId'];
    driverId=json['driverId'];
    name = json['name'];
    userToken = json['userToken'];
    groupId = json['groupId'];
    // chatinit = json['chatinit'];
    phoneNumber=json['phone_number'];
  }
}