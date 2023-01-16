import 'dart:convert';
import 'dart:developer';

import 'package:alpha_app/Model/responses/DriverProfileDataResponse.dart';
import 'package:alpha_app/Views/claims/ClaimsHomePage.dart';
import 'package:alpha_app/Views/mainPage/ProfilePage.dart';
import 'package:alpha_app/helper/LocationTrackerHelper.dart';
import 'package:alpha_app/networking/NetworkConstant.dart';
import 'package:alpha_app/networking/SocketHelper.dart';
import 'package:alpha_app/utils/ImageUtils.dart';
import 'package:alpha_app/utils/SharedPrefConstant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Views/login.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  Future logOut(context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    SocketService().disconnectSocket();
    // LocationTrackerHelper().timer?.cancel();
    Get.offAll(Login());
    // Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(builder: (BuildContext context) => Login()),
    //     (Route<dynamic> route) => false);
  }

  DriverProfileDataResponse? driverProfileDataResponse;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getProfileData();
  }

  _getProfileData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? driverData = await sharedPreferences
        .getString(SharedPrefConstant.DRIVER_INFORMATION);
    driverProfileDataResponse =
        DriverProfileDataResponse.fromJson(json.decode(driverData!));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 120,
            color: Color(0xff1C5AA3),
            width: Get.width / 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: driverProfileDataResponse == null
                        ? Container()
                        : CachedNetworkImage(
                            imageUrl: driverProfileDataResponse!
                                .driver.driverLicence[0],
                            placeholder: (context, url) => Icon(Icons.image),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.fill),
                                ),
                              );
                            },
                          ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        driverProfileDataResponse == null
                            ? ''
                            : driverProfileDataResponse!.driver.driverName,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                     const SizedBox(
                        height: 5,
                      ),
                      Text(
                        driverProfileDataResponse == null
                            ? ''
                            : driverProfileDataResponse!.driver.driverLicenceno,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),

          // Container(
          //   height: 40,
          //   child: InkWell(
          //     onTap: () {
          //       // Navigator.push(
          //       //     context,
          //       //     MaterialPageRoute(builder: (context) => AddAmount()));
          //     },
          //     child: ListTile(
          //       leading: const Text(" ",
          //           style: TextStyle(fontSize: 16, color: Colors.black)),
          //       title: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           const Text("Withdraw Money",
          //               style: TextStyle(fontSize: 16, color: Colors.black)),
          //           // ElevatedButton(
          //           //   shape: RoundedRectangleBorder(
          //           //       borderRadius: BorderRadius.circular(5)),
          //           //   textColor: Colors.white,
          //           //   color: const Color(0xff3E66FB),
          //           //   child: Text(
          //           //     // ignore: unrelated_type_equality_checks
          //           //     '+Buy',
          //           //
          //           //   ),
          //           //   onPressed: () {
          //           //     Navigator.push(
          //           //         context,
          //           //         MaterialPageRoute(
          //           //             builder: (context) => AddAmount()));
          //           //   },
          //           // )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),

          // Container(
          //   height: 40,
          //   child: InkWell(
          //     // onTap: () {
          //     //   Navigator.push(
          //     //       context,
          //     //       MaterialPageRoute(builder: (context) => ChoosePlan()));
          //     // },
          //     child: ListTile(
          //       leading: const Icon(
          //         Icons.analytics_outlined,
          //         color: Colors.black,
          //         size: 20,
          //       ),
          //       title: Text(
          //         "Choose Plan",
          //         style: k16F87Black600HT,
          //       ),
          //     ),
          //   ),
          // ),
          // Container(
          //   height: 40,
          //   child: InkWell(
          //     onTap: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(builder: (context) => SettingPage()));
          //     },
          //     child: ListTile(
          //       leading: const Icon(
          //         Icons.settings,
          //         size: 20,
          //         color: Colors.black,
          //       ),
          //       title: Text(
          //         "Setting",
          //         style: k16F87Black600HT,
          //       ),
          //     ),
          //   ),
          // ),
          // Container(
          //   height: 40,
          //   child: InkWell(
          //     onTap: () {
          //       // Navigator.push(
          //       //     context, MaterialPageRoute(builder: (context) => SettingPage()));
          //     },
          //     child: ListTile(
          //       leading: const Icon(
          //         Icons.info_outline,
          //         size: 20,
          //         color: Colors.black,
          //       ),
          //       title: Text(
          //         "About",
          //         style: k16F87Black600HT,
          //       ),
          //     ),
          //   ),
          // ),

          Container(
            height: 40,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
              child: const ListTile(
                leading:  Icon(
                  Icons.person_outline,
                  size: 20,
                  color: Colors.black,
                ),
                title: Text(
                  "Profile",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ),
          ),
          Container(
            height: 40,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ClaimsHomePage()));
              },
              child: const ListTile(
                leading:  Icon(
                  Icons.add_home_outlined,
                  size: 20,
                  color: Colors.black,
                ),
                title: Text(
                  "Claims",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ),
          ),

          Container(
            height: 40,
            child: InkWell(
              onTap: () {
                // Navigator.push(
                //     ccontext, MaterialPageRoute(builder: (context) => GetInTouch()));
              },
              child: ListTile(
                leading: const Icon(
                  Icons.phone,
                  size: 20,
                  color: Colors.black,
                ),
                title: Text(
                  "Contact Us",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ),
          ),

          Container(
            height: 40,
            child: InkWell(
              onTap: () => logOut(context),
              // DocumentInformationPage
              child: const ListTile(
                leading: Icon(
                  Icons.logout,
                  size: 20,
                  color: Colors.red,
                ),
                title: Text(
                  "LogOut",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
