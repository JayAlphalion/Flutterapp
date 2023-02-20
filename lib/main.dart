//  @dart=2.9
import 'dart:async';
import 'package:alpha_app/UserModules/BrokerModule/views/mainPage/BrokerSplashPage.dart';
import 'package:alpha_app/UserModules/DriverModules/Model/chat_model.dart';
import 'package:alpha_app/UserModules/DriverModules/Views/SplashPage.dart';
import 'package:alpha_app/NotificationService/local_notification_service.dart';
import 'package:alpha_app/UserModules/DriverModules/Views/mainPage/DashBoard.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:firebase_core/firebase_core.dart';

import 'UserModules/OwnerOperatorModule/views/OwOp_SplashPage.dart';
import 'firebase_options.dart';
import 'NotificationService/NotificationHelper.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification.title);
}

Future main() async {
// await initLocator();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  LocalNotificationService.inititalize();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    NotificationService.getNotification();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:
          // TestPage()
          // DriverSplashScreen(),
          OwOpSplashScreen(),
      // BrokerSplashScreen(),
    );
  }
}
