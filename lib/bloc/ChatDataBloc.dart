import 'dart:async';
import 'dart:io';

import 'package:alpha_app/repository/AuthRepository.dart';
import 'package:alpha_app/repository/ChatDataRespository.dart';
import 'package:alpha_app/repository/LoadRequestAcceptRejectRepository.dart';
import 'package:alpha_app/repository/ProfileDataRepository.dart';

import '../networking/Response.dart';

class ChatDataBloc {
  late ChatDataRespository chatDataRespository;
  late StreamController<dynamic> streamController;
  
  
  StreamSink<dynamic> get getChatHistoryDataSink =>
      streamController.sink;

  Stream<dynamic> get getChatHistoryDataStream =>
      streamController.stream;

 
  ChatDataBloc() {
    streamController = StreamController<dynamic>();
     chatDataRespository = ChatDataRespository();
  }

  callGetChatHistoryApi(Map paramter) async {
    try {
      dynamic chuckCats = await chatDataRespository.callGetChatHistoryApi(paramter);
      getChatHistoryDataSink.add(chuckCats);
    } catch (e) {
      getChatHistoryDataSink.add(e.toString());
      print(e);
    }
  }

  
  dispose() {
    streamController.close();
  }
}
