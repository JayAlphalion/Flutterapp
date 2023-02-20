import 'package:alpha_app/UserModules/OwnerOperatorModule/views/mainPage/DispatchScreens/Ow_Op_DipatchHome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'mainPage/ChatTabs/ChatTabScreen.dart';
import 'mainPage/DispatchScreens/DispatchHomeScreen.dart';
import 'mainPage/DocumentsTab/Ow_Op_DriverDrocuments.dart';
import 'mainPage/DocumentsTab/Ow_Op_documention.dart';
import 'mainPage/LocationTabs/Ow_Op_LocationScreen.dart';
import 'mainPage/LocationTabs/Truck_Location.dart';
import 'mainPage/PayrollTab/Ow_Op_PayrollPage.dart.dart';

class TruckDashboard extends StatefulWidget {
  final index;
  final String groupId;
  final String groupName;
  const TruckDashboard(
      {Key? key, this.index, required this.groupId, required this.groupName})
      : super(key: key);

  @override
  State<TruckDashboard> createState() => _TruckDashboardState();
}

class _TruckDashboardState extends State<TruckDashboard> {
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
      ChatTabScreen(
        groupId: widget.groupId,
        groupName: widget.groupName,
      ),
      OwOpDriverDispatchHome(),
      OwOpDriverDocuments(),
      OwOpPayrollPage(),
      TruckLocation()
    ];
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
            label: 'Chat',
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
}
