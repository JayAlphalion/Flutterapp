import 'dart:convert';
import 'dart:developer';

import 'package:alpha_app/UserModules/BrokerModule/Model/responses/DriverProfileDataResponse%202.dart';
import 'package:alpha_app/UserModules/BrokerModule/views/mainPage/ChatTabs/BrokerGroupListScreen.dart';
import 'package:alpha_app/UserModules/BrokerModule/views/mainPage/DispatchScreens/BrokerDispatchScreen.dart';
import 'package:alpha_app/UserModules/DriverModules/bloc/ProfileDataBloc.dart';
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

import 'DispatchScreens/Load_Details.dart';
import 'LocationTab/DriverLocationScreen.dart';

class BrokerDashboard extends StatefulWidget {
  final index;
  // final ChatModel? chat;

  const BrokerDashboard({this.index});

  @override
  _BrokerDashboardState createState() => _BrokerDashboardState();
}

class _BrokerDashboardState extends State<BrokerDashboard> {
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

    _selectedIndex = widget.index;
    pages = [
      BrokerGroupScreen(),
      BrokerDispatchHomePage(),
      DriverLocation()
    ];
  }

  _checkPermissions() async {
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
}
