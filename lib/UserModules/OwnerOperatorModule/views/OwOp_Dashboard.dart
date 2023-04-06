import 'package:alpha_app/UserModules/OwnerOperatorModule/views/mainPage/DocumentsTab/Ow_Op_documention.dart';
import 'package:alpha_app/UserModules/OwnerOperatorModule/views/mainPage/LocationTabs/Ow_Op_LocationScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'mainPage/ChatTabs/Ow_Op_GroupListScreen.dart';
import 'mainPage/DispatchScreens/Ow_Op_DipatchHome.dart';
import 'mainPage/DispatchScreens/DispatchHomeScreen.dart';
import 'mainPage/PayrollTab/Ow_Op_PayrollPage.dart.dart';

class OwOpDashboard extends StatefulWidget {
  final index;
  // final ChatModel? chat;

  const OwOpDashboard({this.index});

  @override
  _OwOpDashboardState createState() => _OwOpDashboardState();
}

class _OwOpDashboardState extends State<OwOpDashboard> {
  int pageIndex = 0;

  late final List pages;
  @override
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void initState() {
    _selectedIndex = widget.index;
    pages = [
      OwOpGroupListScreen(),
      // OwOpDispatchHomePage(),
      // OwOpDocuments(),
      // OwOpPayrollPage(),
      OwOpLocation()
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
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.data_exploration_outlined,
          //   ),
          //   // ignore: deprecated_member_use
          //   label: 'Dispatch',
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.menu_book,
          //   ),
          //   // ignore: deprecated_member_use
          //   label: 'Documents',
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.currency_exchange,
          //   ),
          //   // ignore: deprecated_member_use
          //   label: 'Payroll',
          // ),
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
