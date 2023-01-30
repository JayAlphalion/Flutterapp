import 'dart:async';
import 'dart:io';

import 'package:alpha_app/Universals/Models/BaseResponse.dart';
import 'package:alpha_app/AuthModules/AuthRepository.dart';

import '../Universals/networking/Response.dart';

class AuthDataBloc {
  late AuthRepository authRepository;
  late StreamController<Response<BaseResponse>> streamController;

  StreamSink<Response<BaseResponse>> get loginDataSink => streamController.sink;

  Stream<Response<BaseResponse>> get loginDataStream => streamController.stream;
  String token='';

//OTP Verify Streams
  late StreamController<Response<BaseResponse>> otpVerifyStreamController;

  StreamSink<Response<BaseResponse>> get otpVerifyDataSink =>
      otpVerifyStreamController.sink;

  Stream<Response<BaseResponse>> get otpVerifyDataStream =>
      otpVerifyStreamController.stream;

  AuthDataBloc() {
    streamController = StreamController<Response<BaseResponse>>();
    otpVerifyStreamController = StreamController<Response<BaseResponse>>();
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

  callVerifyOtpVerification(Map parameter) async {
    try {
      dynamic chuckCats =
          await authRepository.callVerifyOtpApi(parameter,token);
      otpVerifyDataSink.add(chuckCats);
    } catch (e) {
      // otpVerifyDataSink.add(e.toString());
      print(e);
    }
  }

  dispose() {
    streamController.close();
    otpVerifyDataSink.close();
  }
}
