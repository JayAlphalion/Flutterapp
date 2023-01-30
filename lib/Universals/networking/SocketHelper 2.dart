import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math';
import 'package:alpha_app/DriverModules/Model/SocketChatModel.dart';
import 'package:alpha_app/DriverModules/Model/responses/NewLoadRequestResponse.dart';
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
      //  connectSocketNow();
      // // joinRoom();
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

    //for join room response.
    socket.on(SocketConstant.SOCKET_EVENT_JOIN_ROOM_RESPONSE, (data) {
      print(data);
      if (data[NetworkConstant.MESSAGE] == NetworkConstant.SUCCESS) {
        // Here this block will be execute when driver will be join into the room.
        EventBusManager.userJoinedOnRoom.fire(data);
      } else {
        joinRoom();
      }
    });

    //for receive mssage response.
    socket.on(SocketConstant.SOCKET_RECEIVE_MESSAGE, (data) {
      EventBusManager.messageBox.fire(data);
    });

//for message response
    socket.on(SocketConstant.SOCKET_MESSAGE_RESPONSE, (data) {
      // debugger();
      EventBusManager.messageResponse.fire(data);
    });



//for testing
socket.on('location_response', (data) {
// debugger();
print(data);
});

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
      String token = session.getString(SharedPrefConstant.DRIVER_TOKEN)!;
      print(token);
      socket.emit(
          SocketConstant.JOIN_ROOM, {SocketConstant.SOCKET_USER_ID: token});
    } catch (e) {
      debugger();
      print(("join channel faild due to $e"));
    }
  }

  void sendMessage(SocketChatModel msgData) async {
    try {
      Map data = {
        'group_id': msgData.groupId,
        'created_at': msgData.createdAt,
        'deletedForEveryone': msgData.deletedForEveryOne,
        'deltedForMe': msgData.deltedForMe,
        'from': msgData.from,
        'isSeen': msgData.isSeen,
        'url': msgData.url,
        'text': msgData.msgBody,
        'seenBy': msgData.seenBy,
        'to': msgData.to,
        'file_name': msgData.fileName,
        'typeOfMsg': msgData.typeOfMsg,
        SocketConstant.USER_ID:msgData.userId,
        SocketConstant.SOCKET_USER_ID: msgData.userToken
      };
      // debugger();
      // print(data);
      socket.emit(SocketConstant.SEND_MESSAGE, data);
    } catch (e) {
      debugger();
      print(("join channel faild due to $e"));
    }
  }

  void sendDriverLocation({required String lat, required String long}) async {
    try {
      SharedPreferences session = await SharedPreferences.getInstance();
      String? token = session.getString(SharedPrefConstant.DRIVER_TOKEN)!;
      String? groupId = session.getString(SharedPrefConstant.GROUP_ID);
      Map locationData = {'lattitude': lat, 'longtitude': long};
      Map data = {
        'group_id': groupId!,
        'user_token': token,
        'data': json.encode(locationData),
        'current_time':DateTime.now().toString()
      };
      print('seding location');
      print(data);
      socket.emit(SocketConstant.SEND_DRIVER_LOCATION, data);
    } catch (e) {
      print(e);
    }

    // print(data);
  }
}
