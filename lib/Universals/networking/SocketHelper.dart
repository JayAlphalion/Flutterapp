import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math';
import 'package:alpha_app/UserModules/DriverModules/Model/SocketChatModel.dart';
import 'package:alpha_app/UserModules/DriverModules/Model/responses/NewLoadRequestResponse.dart';
import 'package:alpha_app/Universals/helper/ServerErrorHelper.dart';
import 'package:alpha_app/Universals/helper/ToastHelper.dart';
import 'package:alpha_app/Universals/networking/EventBusManager.dart';
import 'package:alpha_app/Universals/networking/NetworkConstant.dart';
import 'package:alpha_app/Universals/utils/SharedPrefConstant.dart';
import 'package:alpha_app/Universals/utils/SharedPrefs.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

import 'SocketConstant.dart';

class SocketService {
  static IO.Socket socket = IO.io(NetworkConstant.BASE_URL);

  SocketService getInstance() {
    return SocketService();
  }

  connectSocket() {
    print("seding connection request");
    socket = io(NetworkConstant.BASE_URL, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();

//for connection error.
    socket.onConnectError((err) {
      socket.dispose();
      print(err);
      ServerErrorHelper.openDialog(onRetry: () {
        Get.back();
        connectSocket();
      });
    });

//for error.
    socket.onError((err) {
      socket.dispose();
      print(err);
      ServerErrorHelper.openDialog(onRetry: () {
        Get.back();
        connectSocket();
      });
    });
    socket.on(SocketConstant.SOCKET_CONNECT, (_) {
      print(SocketConstant.SOCKET_CONNECT);
      // connectSocketNow();
      joinRoom();
    });

    // Below is the listener to listen from socket

    socket.on(SocketConstant.SOCKET_DISCONNECT, (_) {
      print(SocketConstant.SOCKET_DISCONNECT);
      ToastHelper().showErrorToast(message: 'Socket disconneted');
    });

// FOR new joined users.
    socket.on(SocketConstant.SOCKET_EVENT_NEW_CONNET, (data) async {
      // debugger();
      print(data);
      print(SocketConstant.SOCKET_EVENT_NEW_CONNET + ": " + data.toString());

      joinRoom();
    });

// for new load request.
    socket.on(SocketConstant.SOCKET_EVENT_NEW_LOAD, (data) {
      // debugger();
      // print(data);
      EventBusManager.getNewLoadRequestData.fire(data);
    });

    // //for join room response.
    // socket.on(SocketConstant.SOCKET_EVENT_JOIN_ROOM_RESPONSE, (data) {
    //   print(data);
    //   if (data[NetworkConstant.MESSAGE] == NetworkConstant.SUCCESS) {
    //     // debugger();
    //     // Here this block will be execute when driver will be join into the room.
    //     EventBusManager.userJoinedOnRoom.fire(data);
    //   } else {
    //     joinRoom();
    //   }
    // });

    //for receive mssage response.
    socket.on(SocketConstant.SOCKET_RECEIVE_MESSAGE, (data) {
      print(data);
      // debugger();
      EventBusManager.messageBox.fire(data);
    });

//for message response
    socket.on(SocketConstant.SOCKET_MESSAGE_RESPONSE, (data) {
      debugger();
      // debugger();
      EventBusManager.messageResponse.fire(data);
    });

//for testing
//     socket.on('location_response', (data) {
// // debugger();
//       print(data);
//     });
  }

  void disconnectSocket() {
    if (socket != null && socket.connected) {
      socket.disconnect();
    }
  }

  // Once connected do connect with API if you need
  void connectSocketNow() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    String? token = session.getString(SharedPrefConstant.DRIVERE_ID);

    Map data = {'user_token': token};
    socket.emitWithAck(
      SocketConstant.SOCKET_CONNECT,
      data.toString(),
    );
  }

  void joinRoom() async {
    try {
      SharedPreferences session = await SharedPreferences.getInstance();
      String token = session.getString(SharedPrefConstant.USER_TOKEN)!;
      print(token);
      socket.emitWithAck(SocketConstant.JOIN_ROOM, {
        SocketConstant.SOCKET_USERTOKEN: token,
        SocketConstant.DATA: {}
      }, ack: (data) {
        handleJoinRoomReponse(data);
      });
    } catch (e) {
      debugger();
      print(("join channel faild due to $e"));
    }
  }

  void sendMessage(SocketChatModel msgData) async {
    SharedPreferences session = await SharedPreferences.getInstance();
    String token = session.getString(SharedPrefConstant.USER_TOKEN)!;
    try {
      Map data = {
        'groupId': msgData.groupId,
        'createdAt': msgData.createdAt,
        'deletedForEveryone': msgData.deletedForEveryOne,
        'deltedForMe': msgData.deltedForMe,
        'from': msgData.from,
        'isSeen': msgData.isSeen,
        'url': msgData.url,
        'text': msgData.msgBody,
        'seenBy': msgData.seenBy,
        'to': msgData.to,
        'fileName': msgData.fileName,
        'typeOfMsg': msgData.typeOfMsg,
        // SocketConstant.USER_ID: msgData.userId,
        // SocketConstant.SOCKET_USERTOKEN: msgData.userToken
      };
      // debugger();
      print(data);

      socket.emitWithAck(SocketConstant.SEND_MESSAGE, {
        SocketConstant.SOCKET_USERTOKEN: token,
        SocketConstant.DATA: data
      }, ack: (data) {
        debugger();
        print(data);
      });
    } catch (e) {
      debugger();
      print(("join channel faild due to $e"));
    }
  }

  void sendDriverLocation({required String lat, required String long}) async {
    try {
      SharedPreferences session = await SharedPreferences.getInstance();
      String? token = session.getString(SharedPrefConstant.USER_TOKEN)!;
      String? groupId = session.getString(SharedPrefConstant.GROUP_ID);
      Map locationData = {'lattitude': lat, 'longtitude': long};
      Map data = {
        'group_id': groupId!,
        'location': json.encode(locationData),
        'current_time': DateTime.now().toString()
      };
      socket.emitWithAck(SocketConstant.SEND_DRIVER_LOCATION, {
        SocketConstant.SOCKET_USERTOKEN: token,
        SocketConstant.DATA: data
      }, ack: (data) {
        handleUpdateDriverLocation(data);
      });
    } catch (e) {
      print(e);
    }

    // print(data);
  }

  void handleJoinRoomReponse(data) {
    if (data[NetworkConstant.MESSAGE] == NetworkConstant.SUCCESS) {
      // debugger();
      // Here this block will be execute when driver will be join into the room.
      EventBusManager.userJoinedOnRoom.fire(data);
    } else {
      joinRoom();
    }
  }

  void handleUpdateDriverLocation(data) {
    print(data);
  }
}
