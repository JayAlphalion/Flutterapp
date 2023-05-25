class SocketConstant {
  static const String SOCKET_CONNECT = "connect";
  static const String SOCKET_DISCONNECT = "disconnect";

  // Emitter
  static const String JOIN_ROOM = "joinroom";
  static const String SEND_MESSAGE = 'send_msg';
  static const String SEND_DRIVER_LOCATION = 'driver_location';

  //Listener
  static const String SOCKET_EVENT_NEW_CONNET = "newconnect";
  static const String SOCKET_EVENT_NEW_LOAD = "assignload";
  static const String SOCKET_EVENT_JOIN_ROOM_RESPONSE = 'room_response';
  static const String SOCKET_RECEIVE_MESSAGE = 'responseMessage';
  static const String SOCKET_MESSAGE_RESPONSE = 'msg_response';

  //param

  static const String SOCKET_USERTOKEN = 'userToken';
  static const String USER_ID='user_id';
  static const String DATA='data';
}
