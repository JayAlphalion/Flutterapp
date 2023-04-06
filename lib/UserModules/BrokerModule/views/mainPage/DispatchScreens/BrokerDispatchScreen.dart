import 'package:alpha_app/UserModules/BrokerModule/Model/responses/GetCurrentLoadDispatchResponse%202.dart';
import 'package:alpha_app/UserModules/BrokerModule/Model/responses/GetPastDispatchLoadsHistoryAPI%202.dart';
import 'package:alpha_app/UserModules/BrokerModule/Model/responses/UpcomingLoadDispatchApiResponse%202.dart';
import 'package:alpha_app/UserModules/BrokerModule/views/DrawersPage/broker_drawer.dart';
import 'package:alpha_app/UserModules/DriverModules/bloc/DispatchDataBloc.dart';
import 'package:alpha_app/Universals/helper/ServerErrorHelper.dart';
import 'package:alpha_app/Universals/networking/NetworkConstant.dart';
import 'package:alpha_app/Universals/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'DispatchCurrentTabScreen.dart';
import 'DispatchPassTab.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

class BrokerDispatchHomePage extends StatefulWidget {
  const BrokerDispatchHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<BrokerDispatchHomePage> createState() => _BrokerDispatchHomePageState();
}

class _BrokerDispatchHomePageState extends State<BrokerDispatchHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  int _selectedIndex = 0;
  late DispatchDataBloc _dispatchDataBloc;
  // bool isLoading = true;
  List<Widget> pageList = [
    Tab(
      text: 'Current',
    ),
    Tab(
      text: 'Past',
    ),
  ];
  GetCurrentLoadDispatchResponse? currentLoadDispatchResponse;
  UpcomingLoadDispatchApiResponse? upcomingLoadDispatchApiResponse;
  // List<GetCurrentLoadDispatchResponse>pastLoadsList=[];
  GetPastDispatchLoadApiResponse? pastDispatchLoadApiResponse;
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dispatchDataBloc = DispatchDataBloc();
    callRefreshApi();

    _handleCurrentDispatchLoadRequestResponse();
    _handleUpcomingDispatchLoadRequestResponse();
    _handlePastDispatchLoadRequestResponse();
    // Create TabController for getting the index of current tab
    _controller = TabController(length: pageList.length, vsync: this);

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      print("Selected Index: " + _controller.index.toString());
    });
  }

  _handleCurrentDispatchLoadRequestResponse() {
    _dispatchDataBloc.currentLoadDispatchDataStream.listen((event) {
      if (event != NetworkConstant.FAILURE) {
        currentLoadDispatchResponse =
            GetCurrentLoadDispatchResponse.fromJson(event);
      } else {
        ServerErrorHelper.openDialog(onRetry: () {
          Get.back();
          _callGetCurrentLoadRequestApi();
        });
      }
    });
  }

  _handleUpcomingDispatchLoadRequestResponse() {
    _dispatchDataBloc.upcomingLoadControllerDataStream.listen((event) {
      if (event != NetworkConstant.FAILURE) {
        upcomingLoadDispatchApiResponse =
            UpcomingLoadDispatchApiResponse.fromJson(event);
      } else {
        ServerErrorHelper.openDialog(onRetry: () {
          Get.back();
          _callGetCurrentLoadRequestApi();
        });
      }
    });
  }

  _handlePastDispatchLoadRequestResponse() {
    _dispatchDataBloc.pastLoadControllerDataStream.listen((event) {
      if (event != NetworkConstant.FAILURE) {
        pastDispatchLoadApiResponse =
            GetPastDispatchLoadApiResponse.fromJson(event);
      } else {
        ServerErrorHelper.openDialog(onRetry: () {
          Get.back();
          _callGetCurrentLoadRequestApi();
        });
      }
      // DispatchLoadingController().updateLoading();
      setState(() {
        isLoading = false;
      });
    });
  }

  _callGetCurrentLoadRequestApi() async {
    _dispatchDataBloc.callGetCurrentDispatchApi();
  }

  _callGetUpcomingLoadRequestApi() async {
    _dispatchDataBloc.callGetUpcommingLoadDispatchApi();
  }

  _callGetPasLoadRequestApi() async {
    _dispatchDataBloc.callGetPastLoadDispatchApi();
  }

  void callRefreshApi() {
    if (isLoading == false) {
      setState(() {
        isLoading = true;
      });
    }
    _callGetCurrentLoadRequestApi();
    _callGetUpcomingLoadRequestApi();
    _callGetPasLoadRequestApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          drawer: BrokerDrawer(),
          // backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: AppColors.primaryColor,
            // leading: Container(),
            centerTitle: true,
            title: Text(
              "Dispatch",
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: InkWell(
                  onTap: () {
                    callRefreshApi();
                  },
                  child: Icon(
                    Icons.refresh,
                    size: 30,
                  ),
                ),
              )
            ],
          ),
          body: Container(
            height: Get.height / 1,
            width: Get.width / 1,
            decoration: BoxDecoration(
                // color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(25.0)),
                    child: TabBar(
                        labelStyle: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                        controller: _controller,
                        indicator: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: _selectedIndex == 0
                                  ? Radius.circular(25)
                                  : Radius.circular(0),
                              bottomLeft: _selectedIndex == 0
                                  ? Radius.circular(25)
                                  : Radius.circular(0),
                              topRight: _selectedIndex == 1
                                  ? Radius.circular(25)
                                  : Radius.circular(0),
                              bottomRight: _selectedIndex == 1
                                  ? Radius.circular(25)
                                  : Radius.circular(0),
                            )),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        tabs: pageList),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                    child: isLoading == true
                        ? Center(
                            child: Text("Loading..."),
                          )
                        : TabBarView(
                            controller: _controller,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: DispatchCurrentTab(
                                  currentLoadDispatchResponse:
                                      currentLoadDispatchResponse,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: DispatchPastTab(
                                  pastDispatchLoadApiResponse:
                                      pastDispatchLoadApiResponse,
                                ),
                              ),
                            ],
                          ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
