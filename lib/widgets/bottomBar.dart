import 'dart:convert';
import 'dart:developer';

import 'package:alpha_app/Dialogs/AlertDialogBox.dart';
import 'package:alpha_app/Dialogs/DispachRequestDialog.dart';
import 'package:alpha_app/Model/chat_model.dart';
import 'package:alpha_app/Model/responses/DriverProfileDataResponse.dart';
import 'package:alpha_app/Model/responses/NewLoadRequestResponse.dart';
import 'package:alpha_app/Views/mainPage/ChatTabs/ChatTabScreen.dart';
import 'package:alpha_app/Views/mainPage/ChatTabs/GroupListScreen.dart';
import 'package:alpha_app/Views/mainPage/DispatchScreens/DispatchHomeScreen.dart';
import 'package:alpha_app/Views/mainPage/chating_screen.dart';
import 'package:alpha_app/Views/mainPage/payrollWidget/payrollWidget.dart';
import 'package:alpha_app/bloc/ProfileDataBloc.dart';
import 'package:alpha_app/helper/LocationTrackerHelper.dart';
import 'package:alpha_app/helper/ServerErrorHelper.dart';
import 'package:alpha_app/networking/EventBusManager.dart';
import 'package:alpha_app/networking/NetworkConstant.dart';
import 'package:alpha_app/networking/SocketHelper.dart';
import 'package:alpha_app/utils/AppColors.dart';
import 'package:alpha_app/utils/SharedPrefConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Views/mainPage/dispatch.dart';
import '../Views/mainPage/DocumentsTab/documention.dart';
import '../Views/mainPage/location.dart';
import '../Views/mainPage/payRollPage.dart';

class BottomBar extends StatefulWidget {
  final index;
  // final ChatModel? chat;

  const BottomBar({this.index});

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int pageIndex = 0;
  late ProfileDataBloc profileDataBloc;
  DriverProfileDataResponse? driverInfo;

  late final List pages;
  @override
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void initState() {
    super.initState();
    _checkPermissions();
    profileDataBloc = ProfileDataBloc();

    _handleDriverInformationResponse();
    _callGetDriverProfileData();
    LocationTrackerHelper().updateCycleOfLocation();

    EventBusManager.getNewLoadRequestData.on().listen((event) {
      NewLoadRequestionResponse v = NewLoadRequestionResponse.fromJson(event);
      callAlertDialog(v);
    });

    _selectedIndex = widget.index;
    pages = [
      GroupListScreen(),
      DispatchHomePage(),
      MyHomePage(),
      LandingPage(),//PayrollPage(),
      HomePage()
    ];
  }

  _checkPermissions() async{
    await Permission.camera.request();
    await Permission.microphone.request();
    await Permission.mediaLibrary.request();
    await Permission.photos.request();
    await Permission.photosAddOnly.request();
    await Permission.storage.request();
    await Permission.videos.request();
  }

  _callGetDriverProfileData() {
    profileDataBloc.callGetProfileData();
  }

  _handleDriverInformationResponse() {
    profileDataBloc.getProfileDataStream.listen((event) {
      // debugger();
      // print(event);
      if (event != NetworkConstant.FAILURE || event != null) {
        DriverProfileDataResponse driverProfileDataResponse =
            DriverProfileDataResponse.fromJson(event);
        driverInfo = driverProfileDataResponse;
        saveDriversInformation(driverProfileDataResponse);
      } else {
        ServerErrorHelper.openDialog(onRetry: () {
          Get.back();
          _callGetDriverProfileData();
        });
      }
    });
  }

  void saveDriversInformation(
      DriverProfileDataResponse driverProfileDataResponse) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(SharedPrefConstant.DRIVER_INFORMATION,
        json.encode(driverProfileDataResponse));
    print(driverProfileDataResponse);
  }

  @override
  void dispose() {
    LocationTrackerHelper().dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
            ),
            // ignore: deprecated_member_use
            label: 'Groups',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.data_exploration_outlined,
            ),
            // ignore: deprecated_member_use
            label: 'Dispatch',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu_book,
            ),
            // ignore: deprecated_member_use
            label: 'Documents',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.currency_exchange,
            ),
            // ignore: deprecated_member_use
            label: 'Payroll',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.location_on_outlined,
            ),
            // ignore: deprecated_member_use
            label: 'Location',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, index) {
        return pages[index];
      },
    );
  }

  void callAlertDialog(NewLoadRequestionResponse newLoadRequestionResponse) {
    showDialog<String>(
        context: context,
        //barrierColor: Colors.white.withOpacity(0),
        barrierDismissible: false,
        builder: (BuildContext context) {
          return DispachRequestDialog(
            newLoadRequestionResponse: newLoadRequestionResponse,
          );
        });
  }
}
