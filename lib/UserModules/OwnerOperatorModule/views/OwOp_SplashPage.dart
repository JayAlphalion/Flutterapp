import 'dart:async';

import 'package:alpha_app/UserModules/DriverModules/Model/chat_model.dart';
import 'package:alpha_app/UserModules/DriverModules/Model/responses/NewLoadRequestResponse.dart';
import 'package:alpha_app/AuthModules/AuthPages/OTPLogin.dart';
import 'package:alpha_app/Universals/helper/ServerErrorHelper.dart';
import 'package:alpha_app/Universals/networking/EventBusManager.dart';
import 'package:alpha_app/Universals/networking/SocketHelper.dart';
import 'package:alpha_app/Universals/utils/ImageUtils.dart';
import 'package:alpha_app/Universals/utils/SharedPrefConstant.dart';
import 'package:alpha_app/UserModules/DriverModules/Views/mainPage/DashBoard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_fadein/flutter_fadein.dart';

import 'OwOp_Dashboard.dart';

class OwOpSplashScreen extends StatefulWidget {
  // const SplashScreen({super.key});

  @override
  State<OwOpSplashScreen> createState() => _OwOpSplashScreenState();
}

class _OwOpSplashScreenState extends State<OwOpSplashScreen> {
  String? stream_user_id;

  checkLoginStatus() async {
    SharedPreferences session = await SharedPreferences.getInstance();
    setState(() {
      stream_user_id = session.getString(SharedPrefConstant.DRIVERE_ID);
    });
    // print("---------------");
    // print(stream_user_id);
  }

  @override
  void initState() {
    super.initState();
    EventBusManager.userJoinedOnRoom.on().listen((event) {
      if (event['message'] != 'success') {
        ServerErrorHelper.openDialog(onRetry: () {
          SocketService().joinRoom();
        });
      }
      if (event['message'] == 'success') {
        navigagte();
      }
    });

    startApp();
  }

  startApp() async {
    try {
      await checkLoginStatus();
      navigationPage();
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    } catch (e) {
      print(e);
    }
  }

  void navigationPage() async {
    if (stream_user_id == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => OTPLogin(),
          ),
          (Route<dynamic> route) => false);
    } else {
      SocketService().connectSocket();
      //  SocketServic   e(). connectSocketNow();
    }
  }

  void navigagte() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // String? chatString = preferences.getString("ChatObject");
    // var chat = ChatModel.fromJson(chatString!);
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => OwOpDashboard(index: 0),
          ),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FadeIn(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              ImageUtils.Logo,
              height: 100,
              width: Get.width / 1.3,
            ),
            Text(
              "Please Wait\nWe are creating your work space.",
              textAlign: TextAlign.center,
            )
          ],
        ),
        // Optional paramaters
        duration: Duration(milliseconds: 1000),
        curve: Curves.bounceInOut,
      )),
    );
  }
}
