import 'dart:async';
import 'dart:io';

import 'package:alpha_app/repository/AuthRepository.dart';

import '../networking/Response.dart';

class AuthDataBloc {
  late AuthRepository authRepository;
  late StreamController<dynamic> streamController;

  
  StreamSink<dynamic> get loginDataSink =>
      streamController.sink;

  Stream<dynamic> get loginDataStream =>
      streamController.stream;

 
  AuthDataBloc() {
    streamController = StreamController<dynamic>();
     authRepository = AuthRepository();
  }

  callLoginApi(Map parameter) async {
    try {
      dynamic chuckCats = await authRepository.callLoginApi(parameter);
      loginDataSink.add(chuckCats);
    } catch (e) {
      loginDataSink.add(e.toString());
      print(e);
    }
  }

  
  dispose() {
    streamController.close();
  }
}
