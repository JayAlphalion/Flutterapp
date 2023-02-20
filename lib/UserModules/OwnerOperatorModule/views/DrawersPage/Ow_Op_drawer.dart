import 'dart:convert';
import 'dart:developer';

import 'package:alpha_app/AuthModules/AuthPages/OTPLogin.dart';
import 'package:alpha_app/UserModules/OwnerOperatorModule/views/DrawersPage/Ow_Op_ProfilePage.dart';
import 'package:alpha_app/Universals/helper/LocationTrackerHelper.dart';
import 'package:alpha_app/Universals/networking/NetworkConstant.dart';
import 'package:alpha_app/Universals/networking/SocketHelper.dart';
import 'package:alpha_app/Universals/utils/ImageUtils.dart';
import 'package:alpha_app/Universals/utils/SharedPrefConstant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OwOp_Drawer extends StatefulWidget {
  @override
  State<OwOp_Drawer> createState() => _OwOp_DrawerState();
}

class _OwOp_DrawerState extends State<OwOp_Drawer> {
  Future logOut(context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    SocketService().disconnectSocket();
    Get.offAll(OTPLogin());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 64),
        child: FloatingActionButton(
          backgroundColor: const Color(0xff1C5AA3),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: SizedBox(
        width: Get.width,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 180,
                color: const Color(0xff1C5AA3),
                width: Get.width / 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, top: 30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://images.unsplash.com/photo-1500462918059-b1a0cb512f1d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1000&q=80'[
                                  0],
                          placeholder: (context, url) =>
                              const Icon(Icons.image),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              height: 80,
                              width: 80,
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
                      const SizedBox(width: 30),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'driverName',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'driverLicenceno',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              Container(
                height: 40,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OwOpProfilePage()));
                  },
                  child: const ListTile(
                    leading: Icon(
                      Icons.person_outline,
                      size: 20,
                      color: Colors.black,
                    ),
                    title: Text(
                      "Profile",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_sharp,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Container(
                height: 40,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const ListTile(
                    leading: Icon(
                      Icons.add_home_outlined,
                      size: 20,
                      color: Colors.black,
                    ),
                    title: Text(
                      "Claims",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_sharp,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Container(
                height: 40,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const ListTile(
                    leading: Icon(
                      Icons.settings,
                      size: 20,
                      color: Colors.black,
                    ),
                    title: Text(
                      "Settings",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_sharp,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              // Container(
              //   height: 40,
              //   child: InkWell(
              //     onTap: () {
              //       // Navigator.push(
              //       //     ccontext, MaterialPageRoute(builder: (context) => GetInTouch()));
              //     },
              //     child: ListTile(
              //       leading: const Icon(
              //         Icons.phone,
              //         size: 20,
              //         color: Colors.black,
              //       ),
              //       title: Text(
              //         "Contact Us",
              //         style: TextStyle(fontSize: 16, color: Colors.black),
              //       ),
              //     ),
              //   ),
              // ),

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
        ),
      ),
    );
  }
}
