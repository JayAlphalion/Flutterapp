import 'dart:async';
import 'dart:io';

import 'package:alpha_app/Model/responses/BaseResponse.dart';
import 'package:alpha_app/repository/AuthRepository.dart';

import '../networking/Response.dart';

class LoginDataBloc {
  late AuthRepository authRepository;
  late StreamController<BaseResponse> streamController;

  
  StreamSink<BaseResponse> get loginDataSink =>
      streamController.sink;

  Stream<BaseResponse> get loginDataStream =>
      streamController.stream;

 
  LoginDataBloc() {
    streamController = StreamController<BaseResponse>();
     authRepository = AuthRepository();
  }

  callGetOtpResponse(Map parameter) async {
    try {
      dynamic chuckCats = await authRepository.callGetOtpApi(parameter);
      loginDataSink.add(chuckCats);
    } catch (e) {
      // loginDataSink.add(e.toString());
      print(e);
    }
  }

  
  dispose() {
    streamController.close();
  }
}
