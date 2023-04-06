import 'package:alpha_app/UserModules/DriverModules/Views/mainPage/ChatTabs/ChatTabScreen.dart';
import 'package:alpha_app/Universals/utils/AppColors.dart';
import 'package:alpha_app/Universals/utils/ImageUtils.dart';
import 'package:alpha_app/Universals/utils/SharedPrefConstant.dart';
import 'package:alpha_app/UserModules/DriverModules/Views/DrawersPage/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupListScreen extends StatefulWidget {
  const GroupListScreen({Key? key}) : super(key: key);

  @override
  State<GroupListScreen> createState() => _GroupListScreenState();
}

class _GroupListScreenState extends State<GroupListScreen> {
  String groupId = '';

  @override
  void initState() {
    getGroupId();
    // TODO: implement initState
    super.initState();
  }

  void getGroupId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    groupId = prefs.getString(SharedPrefConstant.GROUP_ID)!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.chatBgScreenColor,
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: Text(
          "Groups",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GroupCardWidget(groupName: 'XPO Logistics'),
            GroupCardWidget(groupName: 'Alpha lion Customer Support'),
            GroupCardWidget(groupName: 'Payroll Team')
          ],
        ),
      ),
    );
  }

  Widget GroupCardWidget({required String groupName}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
      child: Bounce(
        onPressed: () {
          Get.to(ChatTabScreen(
            groupId: groupId,
            groupName: groupName,
          ));
        },
        duration: Duration(milliseconds: 110),
        child: Container(
          height: 100,
          width: Get.width / 1,
          decoration: BoxDecoration(
            color: AppColors.chatBgColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    //  color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                        image: AssetImage(ImageUtils.Logo),
                        fit: BoxFit.contain)),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      groupName,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 50,
                      width: Get.width / 1,
                      child: const Text(
                        'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words',
                        style: TextStyle(
                            color: Colors.black45,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                    Expanded(
                        child: Container(
                      alignment: Alignment.bottomRight,
                      child: const Text(
                        '08:10 pm',
                        style: TextStyle(
                            color: AppColors.chatDateTimeColor, fontSize: 8),
                      ),
                    ))
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
