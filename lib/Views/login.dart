import 'dart:convert';
import 'dart:developer';

import 'package:alpha_app/Model/responses/LoginApiResponse.dart';
import 'package:alpha_app/Views/OTPLogin.dart';
import 'package:alpha_app/bloc/AuthDataBloc.dart';
import 'package:alpha_app/helper/LoaderWidget.dart';
import 'package:alpha_app/helper/ToastHelper.dart';
import 'package:alpha_app/networking/SocketHelper.dart';
import 'package:alpha_app/utils/ImageUtils.dart';
import 'package:alpha_app/utils/SharedPrefConstant.dart';
import 'package:alpha_app/widgets/BottonWidget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/chat_model.dart';
import '../widgets/bottomBar.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _name = TextEditingController();
  TextEditingController _pass = TextEditingController();
  late AuthDataBloc authDataBloc;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  //bool _isLoading = false;
  var chechUserlogcli;
  String? message;
  String? driver_id;
  String? name;
  String? driver_token;

  // checkUser() async {
  //   print("vvvvhhhhhhh");
  //   SharedPreferences session = await SharedPreferences.getInstance();
  //   try {
  //     var dio = Dio();
  //     Map data = {
  //       "userId": _name.text,
  //       "password": _pass.text,
  //     };
  //     print("vvvvkkkkkkkk");
  //     final response = await dio.post(
  //         "https://alphalionserver.herokuapp.com/API/V2/driverLog",
  //         data: data);
  //     print(data);
  //     if (response!.statusCode == 200) {
  //       print("vvvv");
  //       stream_user_id = response.data['stream_user_id'];
  //       session.setString("stream_user_id", stream_user_id!);
  //       // name = response.data['name'];
  //       // session.setString("name", name!);
  //       stream_user_token = response.data['stream_user_token'];
  //       session.setString("stream_user_token", stream_user_token!);
  //       print("BBBBBBBB");
  //       print(stream_user_id);
  //       print(stream_user_token.toString());
  //       print("BBBBBBBB");
  //       final chat = ChatModel(
  //           channelId: response.data['channel_id'],
  //           channelName: response.data['channel_type'],
  //           token: response.data["stream_user_token"],
  //           userId: response.data['stream_user_id']);
  //       session.setString('ChatObject', chat.toJson());
  //       Navigator.of(context).pushAndRemoveUntil(
  //           MaterialPageRoute(
  //             builder: (context) => BottomBar(
  //               index: 0,
  //               chat: chat!,
  //             ),
  //           ),
  //           (Route<dynamic> route) => false);
  //     }
  //   } on DioError catch (e) {
  //     if (e.response!.statusCode == 400) {
  //       print(e.response!.statusCode);
  //       Fluttertoast.showToast(
  //         msg: e.response!.data['message'].toString(),
  //         backgroundColor: Colors.grey,
  //       );
  //     } else {
  //       print(e.message);
  //       // print(e.request);
  //     }
  //   }
  // }

  @override
  void initState() {
    authDataBloc = AuthDataBloc();

    authDataBloc.loginDataStream.listen((event) {
      // debugger();
      Navigator.pop(context);
      // debugger();
      // print(event);
      if (event.statusCode == 200) {
        var res = json.decode(event.body);
        LoginApiResponse v = LoginApiResponse.fromJson(res);

        saveAndNavigate(v);
      } else if (event.statusCode == 400) {
        ToastHelper()
            .showErrorToast(message: 'User Id and password not matched');
      } else {
        ToastHelper()
            .showErrorToast(message: 'Something went wrong please check.');
      }
    });

    // TODO: implement initState
    super.initState();
  }

  void saveAndNavigate(LoginApiResponse loginApiResponse) async {
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
      BottomBar(
        index: 0,
        // chat: chat,
      ),
    );
  }

  void callLogin() {
    if (_name.text.isEmpty) {
      ToastHelper().showErrorToast(message: 'Please Enter User Id first');
    } else if (_pass.text.isEmpty) {
      ToastHelper().showErrorToast(message: 'Please Enter Password');
    } else {
      NetworkDialog.showLoadingDialog(context, _keyLoader);
      Map data = {
        "userId": _name.text,
        "password": _pass.text,
      };
      authDataBloc.callLoginApi(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const OTPLogin();
          }));
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Image.asset(
              ImageUtils.Logo,
              height: 100,
            ),
            SizedBox(
              height: 20,
            ),
            // const Text(
            //   'Login',
            //   style: TextStyle(
            //     fontSize: 26,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.black, //font color
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'User Id',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, //font color
                      ),
                    ),
                    TextFormField(
                      //autovalidateMode: AutovalidateMode.always,
                      controller: _name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontFamily: 'PoppinsLight',
                      ),
                      decoration: const InputDecoration(
                        isDense: true,
                        hintText: "User Id",
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'PoppinsLight',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, //font color
                      ),
                    ),
                    TextFormField(
                      //autovalidateMode: AutovalidateMode.always,
                      controller: _pass,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontFamily: 'PoppinsLight',
                      ),
                      decoration: const InputDecoration(
                        isDense: true,
                        hintText: "Password",
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'PoppinsLight',
                        ),
                      ),
                    ),
                  ]),
            ),

            Padding(
              padding: const EdgeInsets.only(
                  left: 40, right: 40, top: 20, bottom: 10),
              child: Bounce(
                  duration: Duration(milliseconds: 110),
                  onPressed: () {
                    callLogin();
                  },
                  child: bottonWidget(title: 'Login')),
            ),
            // ElevatedButton(
            //   child: const Padding(
            //     padding: EdgeInsets.only(top: 10, bottom: 10),
            //     child: Text(
            //       "Check User",
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 14,
            //         fontFamily: 'PoppinsLight',
            //       ),
            //     ),
            //   ),
            //   onPressed: () {
            //     callLogin();
            //     //checkUser();
            //   },
            // ),
            SizedBox(
              height: 10,
            ),

            Column(
              children: [
                Container(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "By logging in, you agree to our",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, //font color
                        ),
                      ),
                      TextButton(
                        child: const Text(
                          "Terms and Conditions",
                          style: TextStyle(
                              color: Colors.indigo,
                              fontFamily: 'Inter',
                              fontSize: 13),
                        ),
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             TermsCondition()));
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        child: const Text(
                          "Privacy Policy",
                          style: TextStyle(
                              color: Colors.indigo,
                              fontFamily: 'Inter',
                              fontSize: 13),
                        ),
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             PrivacyPolicy()));
                        },
                      ),
                      const Text(
                        "&",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Inter',
                            fontSize: 13),
                      ),
                      TextButton(
                        child: const Text(
                          "Get In Touch",
                          style: TextStyle(
                              color: Colors.indigo,
                              fontFamily: 'Inter',
                              fontSize: 13),
                        ),
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             GetInTouch()));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
