import 'dart:convert';
import 'dart:developer';

import 'package:alpha_app/DriverModules/Dialogs/AlertDialogBox.dart';
import 'package:alpha_app/DriverModules/Dialogs/DispachRequestDialog.dart';
import 'package:alpha_app/DriverModules/Model/chat_model.dart';
import 'package:alpha_app/DriverModules/Model/responses/DriverProfileDataResponse.dart';
import 'package:alpha_app/DriverModules/Model/responses/NewLoadRequestResponse.dart';
import 'package:alpha_app/DriverModules/Views/mainPage/ChatTabs/ChatTabScreen.dart';
import 'package:alpha_app/DriverModules/Views/mainPage/ChatTabs/GroupListScreen.dart';
import 'package:alpha_app/DriverModules/Views/mainPage/DispatchScreens/DispatchHomeScreen.dart';
import 'package:alpha_app/DriverModules/Views/mainPage/PayrollTab/PayrollPage.dart.dart';
import 'package:alpha_app/DriverModules/bloc/ProfileDataBloc.dart';
import 'package:alpha_app/Universals/helper/LocationTrackerHelper.dart';
import 'package:alpha_app/Universals/helper/ServerErrorHelper.dart';
import 'package:alpha_app/Universals/networking/EventBusManager.dart';
import 'package:alpha_app/Universals/networking/NetworkConstant.dart';
import 'package:alpha_app/Universals/networking/SocketHelper.dart';
import 'package:alpha_app/Universals/utils/AppColors.dart';
import 'package:alpha_app/Universals/utils/SharedPrefConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'DocumentsTab/documention.dart';
import 'LocationTabs/LocationScreen.dart';
class Dashboard extends StatefulWidget {
  final index;
  // final ChatModel? chat;

  const Dashboard({this.index});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
      PayrollPage(),//PayrollPage(),
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
