import 'package:alpha_app/Universals/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool fingerprintAccess = false;
  bool faceAccess = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.chatBgScreenColor,
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_sharp),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Settings'),
          backgroundColor: AppColors.primaryColor),
      body: SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(children: [
          Platform.isIOS
              ? Container()
              : Container(
                  height: 40,
                  child: InkWell(
                    onTap: () {},
                    child: ListTile(
                      leading: Icon(
                        Icons.fingerprint,
                        size: 20,
                        color: Colors.black,
                      ),
                      title: Text(
                        "Fingerprint Unlock",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      trailing: Switch(
                        activeColor: Colors.green,
                        inactiveThumbColor: Colors.red,
                        value: fingerprintAccess,
                        onChanged: (value) =>
                            setState(() => fingerprintAccess = value),
                      ),
                    ),
                  ),
                ),
          Container(
            height: 40,
            child: InkWell(
              onTap: () {},
              child: ListTile(
                leading: const Icon(
                  Icons.center_focus_weak_outlined,
                  size: 20,
                  color: Colors.black,
                ),
                title: const Text(
                  "Face Unlock",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                trailing: Switch(
                  activeColor: Colors.green,
                  inactiveThumbColor: Colors.red,
                  value: faceAccess,
                  onChanged: (value) => setState(() => faceAccess = value),
                ),
              ),
            ),
          ),
        ]),
      )),
    );
  }
}
