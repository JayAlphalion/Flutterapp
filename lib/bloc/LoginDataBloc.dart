import 'dart:async';
import 'dart:io';

import 'package:alpha_app/Model/responses/BaseResponse.dart';
import 'package:alpha_app/repository/AuthRepository.dart';

import '../networking/Response.dart';

class LoginDataBloc {
  late AuthRepository authRepository;
  late StreamController<Response<BaseResponse>> streamController;

  StreamSink<Response<BaseResponse>> get loginDataSink => streamController.sink;

  Stream<Response<BaseResponse>> get loginDataStream => streamController.stream;

//OTP Verify Streams
  late StreamController<Response<BaseResponse>> otpVerifyStreamController;

  StreamSink<Response<BaseResponse>> get otpVerifyDataSink =>
      otpVerifyStreamController.sink;

  Stream<Response<BaseResponse>> get otpVerifyDataStream =>
      otpVerifyStreamController.stream;

  LoginDataBloc() {
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
          await authRepository.callVerifyOtpApi(parameter);
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
