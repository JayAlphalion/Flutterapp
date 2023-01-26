//  @dart=2.9
import 'dart:async';
import 'package:alpha_app/Model/chat_model.dart';
import 'package:alpha_app/Services/locator.dart';
import 'package:alpha_app/Views/SplashPage.dart';
import 'package:alpha_app/Views/TestPage.dart';
import 'package:alpha_app/helper/Firebase_Options.dart';
import 'package:alpha_app/test.dart';
import 'package:alpha_app/widgets/bottomBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Views/login.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:firebase_core/firebase_core.dart';

Future main() async {
// await initLocator();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:
          // TestPage()
          SplashScreen(),
    );
  }
}
