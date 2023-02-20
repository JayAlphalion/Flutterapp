import 'dart:convert';
import 'dart:developer';

import 'package:alpha_app/UserModules/DriverModules/Model/chat_model.dart';
import 'package:alpha_app/AuthModules/LoginApiResponse.dart';
import 'package:alpha_app/AuthModules/AuthDataBloc.dart';
import 'package:alpha_app/Universals/helper/LoaderWidget.dart';
import 'package:alpha_app/Universals/helper/ResponseHelper.dart';
import 'package:alpha_app/Universals/helper/ToastHelper.dart';
import 'package:alpha_app/Universals/networking/NetworkConstant.dart';
import 'package:alpha_app/Universals/networking/Response.dart';
import 'package:alpha_app/Universals/networking/SocketHelper.dart';
import 'package:alpha_app/Universals/networking/StatusCodeConstant.dart';
import 'package:alpha_app/Universals/utils/AppColors.dart';
import 'package:alpha_app/Universals/utils/ImageUtils.dart';
import 'package:alpha_app/Universals/utils/SharedPrefConstant.dart';
import 'package:alpha_app/UserModules/DriverModules/Views/mainPage/DashBoard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LoginState { ENTER_NUMBER, ENTER_OTP }

class OTPLogin extends StatefulWidget {
  const OTPLogin({Key? key}) : super(key: key);

  @override
  State<OTPLogin> createState() => _OTPLoginState();
}

class _OTPLoginState extends State<OTPLogin> {
  final pinController = TextEditingController();
  final numController = TextEditingController();
  final focusNode = FocusNode();
  late AuthDataBloc loginDataBloc;
  final GlobalKey<State> _keyLoader = GlobalKey<State>();

  String? message;
  String? driver_id;
  String? name;
  String? driver_token;

  @override
  void dispose() {
    numController.dispose();
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  bool showError = false;

  static const length = 4;
  static const borderColor = Color.fromRGBO(114, 178, 238, 1);
  static const errorColor = Color.fromRGBO(255, 234, 238, 1);
  static const fillColor = Color.fromRGBO(222, 231, 240, .57);
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 60,
    textStyle:
        const TextStyle(fontSize: 22, color: Color.fromRGBO(30, 60, 87, 1)),
    decoration: BoxDecoration(
      color: fillColor,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.transparent),
    ),
  );

  LoginState pageState = LoginState.ENTER_NUMBER;

  @override
  void initState() {
    loginDataBloc = AuthDataBloc();
    _handleGetOtpResponse();
    _handleVerifyOtpResponse();
    super.initState();
  }

  __callVerifyOtp() {
    if (pinController.text.isEmpty) {
      ToastHelper().showErrorToast(message: 'Please Enter OTP');
    } else if (pinController.text.length != 4) {
      ToastHelper().showErrorToast(message: 'Invalid OTP');
    } else {
      NetworkDialog.showLoadingDialog(context, _keyLoader);
      Map data = {NetworkConstant.API_PARAM_ENTERED_OTP: pinController.text};
      loginDataBloc.callVerifyOtpVerification(data);
    }
  }

  _callGetOtp() {
    if (numController.text.isEmpty) {
      ToastHelper().showErrorToast(message: 'Please Enter Mobile Number First');
    } else if (numController.text.length != 10) {
      ToastHelper().showErrorToast(message: 'Invalid Mobile Number');
    } else {
      NetworkDialog.showLoadingDialog(context, _keyLoader);
      Map data = {NetworkConstant.API_PARAM_PHONE_NUMBER: numController.text};

      loginDataBloc.callGetOtpResponse(data);
    }
  }

  _handleGetOtpResponse() {
    loginDataBloc.loginDataStream.listen((event) {
      Navigator.pop(context);
      if (event.status == Status.COMPLETED) {
        loginDataBloc.token = event.data.data.body['request_token'];
        bool flag = ResonseHelper.checkApiResponse(event.data);
        if (flag == true) {
          ToastHelper().showToast(message: 'OTP sent on your number');
          setState(() {
            pageState = LoginState.ENTER_OTP;
          });
        }
      } else {}
    });
  }

  _handleVerifyOtpResponse() {
    loginDataBloc.otpVerifyDataStream.listen((event) {
       Navigator.pop(context);
      if (event.status == Status.COMPLETED) {
        if (event.data.status == StatusCodeConstant.sucessCode) {
          LoginApiResponse v = LoginApiResponse.fromJson(event.data.data.body);
          saveAndNavigate(v);
        } else if (event.data.status ==
            StatusCodeConstant.wrongCredentailCode) {
          ToastHelper().showToast(message: 'Incorrect OTP. Try Again');
        } else if (event.data.status == StatusCodeConstant.tokenExpiredCode) {
          ToastHelper().showToast(message: 'Token Expired. Try Again');
          pageState = LoginState.ENTER_NUMBER;
          setState(() {});
        }
      } else if (event.status == Status.ERROR) {}
    });
  }

  void saveAndNavigate(LoginApiResponse loginApiResponse) async {
    print(loginApiResponse);
    SharedPreferences session = await SharedPreferences.getInstance();
    driver_id = loginApiResponse.userId;

    // debugger();
    // print(loginApiResponse);
    session.setString(SharedPrefConstant.DRIVERE_ID, driver_id!);

    driver_token = loginApiResponse.userToken;
    session.setString(SharedPrefConstant.DRIVER_TOKEN, driver_token!);
    session.setString(SharedPrefConstant.GROUP_ID, loginApiResponse.groupId);
    SocketService().connectSocket();
    // SocketService(). connectSocketNow();

    final chat = ChatModel(
        channelId: loginApiResponse.channelId,
        channelName: loginApiResponse.channelId,
        token: loginApiResponse.userToken,
        userId: loginApiResponse.userId);
    session.setString('ChatObject', chat.toJson());
    ToastHelper().showToast(message: 'login successfully done.');
    Get.offAll(
      Dashboard(
        index: 0,
        // chat: chat,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.all(24),
        width: Get.width,
        height: Get.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            Image.asset(
              ImageUtils.Logo,
              height: 200,
            ),
            const SizedBox(height: 20),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _enterNumberField(),
                const SizedBox(height: 40),
                pageState == LoginState.ENTER_OTP
                    ? _getOTPfield()
                    : Container(),
                const SizedBox(height: 40),
                _getActionButton(),
              ],
            )
          ],
        ),
      )),
    );
  }

  SizedBox _getActionButton() {
    return SizedBox(
      width: double.infinity,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: pageState == LoginState.ENTER_NUMBER
            ? () {
                _callGetOtp();
              }
            : () {
                __callVerifyOtp();
              },
        color: AppColors.primaryColor,
        child: Padding(
          padding: EdgeInsets.all(14.0),
          child: Text(
            pageState == LoginState.ENTER_NUMBER ? 'Get OTP' : 'Continue',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Pinput _getOTPfield() {
    return Pinput(
      length: length,
      controller: pinController,
      focusNode: focusNode,
      defaultPinTheme: defaultPinTheme,
      onCompleted: (pin) {
        pageState = LoginState.ENTER_OTP;
        setState(() {});
      },
      focusedPinTheme: defaultPinTheme.copyWith(
        height: 68,
        width: 64,
        decoration: defaultPinTheme.decoration!.copyWith(
          border: Border.all(color: borderColor),
        ),
      ),
      errorPinTheme: defaultPinTheme.copyWith(
        decoration: BoxDecoration(
          color: errorColor,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  TextFormField _enterNumberField() {
    return TextFormField(
      controller: numController,
      keyboardType: TextInputType.number,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        hintText: 'Enter Number',
        enabled: pageState == LoginState.ENTER_NUMBER,
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(20)),
        disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(20)),
        // prefix: const Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 8),
        //   child: Text(
        //     '(+1)',
        //     style: TextStyle(
        //         fontSize: 18,
        //         fontWeight: FontWeight.bold,
        //         color: AppColors.primaryColor),
        //   ),
        // ),
        // suffixIcon: pageState == LoginState.ENTER_NUMBER
        //     ? Container()
        //     : IconButton(
        //         onPressed: () {
        //           pageState = LoginState.ENTER_NUMBER;
        //           setState(() {});
        //         },
        //         icon: const Icon(
        //           Icons.edit,
        //           size: 32,
        //         ),
        //       ),
      ),
    );
  }
}
