import 'dart:convert';

import 'package:alpha_app/UserModules/DriverModules/Model/responses/DriverProfileDataResponse.dart';
import 'package:alpha_app/Universals/utils/AppColors.dart';
import 'package:alpha_app/Universals/utils/ImageUtils.dart';
import 'package:alpha_app/Universals/utils/SharedPrefConstant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DriverProfileDataResponse? driverProfileDataResponse;
  bool loading = true;

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
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: loading == true
          ? Container()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(width: 1, color: AppColors.primaryColor),
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
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.contain),
                                ),
                              );
                            },
                          ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  listItemWidget(
                      field: 'Name',
                      value: driverProfileDataResponse!.driver.driverName),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // listItemWidget(field: 'Sex', value:  driverProfileDataResponse!.driver.),
                  SizedBox(
                    height: 10,
                  ),
                  listItemWidget(
                      field: 'Address',
                      value: driverProfileDataResponse!.driver.driverState),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // listItemWidget(field: 'Date Of Birth', value:  driverProfileDataResponse!.driver.),
                  SizedBox(
                    height: 10,
                  ),
                  listItemWidget(
                      field: 'Driver License No.',
                      value: driverProfileDataResponse!.driver.driverLicenceno),
                  SizedBox(
                    height: 10,
                  ),
                  listItemWidget(
                      field: 'Driver License Expire Date',
                      value:
                          driverProfileDataResponse!.driver.driverLicenseEXP),
                  SizedBox(
                    height: 10,
                  ),
                  listItemWidget(
                      field: 'Company Name',
                      value: driverProfileDataResponse!.truck.truckCompany),
                  SizedBox(
                    height: 10,
                  ),
                  listItemWidget(
                      field: 'Contact No.',
                      value: driverProfileDataResponse!.truck.truckPhone),
                  SizedBox(
                    height: 10,
                  ),
                  listItemWidget(
                      field: 'Issue Date',
                      value: driverProfileDataResponse!.driver.driverLicenceno),
                ],
              ),
            ),
    );
  }

  Widget listItemWidget({required String field, required String value}) {
    return Container(
      width: Get.width / 1,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              field,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              value,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 1,
              color: Colors.black12,
              width: Get.width / 1,
            ),
          ],
        ),
      ),
    );
  }
}
