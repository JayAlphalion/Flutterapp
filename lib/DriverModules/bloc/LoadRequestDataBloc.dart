import 'dart:async';
import 'dart:io';

import 'package:alpha_app/AuthModules/AuthRepository.dart';
import 'package:alpha_app/DriverModules/repository/LoadRequestAcceptRejectRepository.dart';

import '../../Universals/networking/Response.dart';

class LoadRequestDataBloc {
  late LoadRequestAcceptRejectRepository loadRequestAcceptRejectRepository;
  late StreamController<dynamic> streamController;
  
  
  StreamSink<dynamic> get loadRequestAcceptRejectDataSink =>
      streamController.sink;

  Stream<dynamic> get loadRequestAcceptRejectDataStream =>
      streamController.stream;

 
  LoadRequestDataBloc() {
    streamController = StreamController<dynamic>();
     loadRequestAcceptRejectRepository = LoadRequestAcceptRejectRepository();
  }

  callAcceptRejectLoadRequest(Map parameter) async {
    try {
      dynamic chuckCats = await loadRequestAcceptRejectRepository.callAcceptRejectloadMethod(parameter);
      loadRequestAcceptRejectDataSink.add(chuckCats);
    } catch (e) {
      loadRequestAcceptRejectDataSink.add(e.toString());
      print(e);
    }
  }

  
  dispose() {
    streamController.close();
  }
}
