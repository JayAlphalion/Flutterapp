import 'package:alpha_app/helper/ScanController.dart';
import 'package:alpha_app/networking/SocketHelper.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
            onPressed: () {
              openScanningProcess();
            },
            icon: Icon(
              Icons.add,
              size: 50,
            )),
      ),
    );
  }

/**
 * This Method is Responsible for Open & Scan Features.
 */
  void openScanningProcess() async {
    SocketService().connectSocket();
  SocketService().sendDriverLocation(lat: '123.23', long: '1233.45');
  }
}



