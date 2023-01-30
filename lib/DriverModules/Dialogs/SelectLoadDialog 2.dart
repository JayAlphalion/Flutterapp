import 'dart:convert';
import 'dart:developer';

import 'package:alpha_app/DriverModules/Dialogs/AlertDialogBox.dart';
import 'package:alpha_app/DriverModules/Model/LoadDataModel.dart';
import 'package:alpha_app/DriverModules/Model/responses/NewLoadRequestResponse.dart';
import 'package:alpha_app/DriverModules/bloc/LoadRequestDataBloc.dart';
import 'package:alpha_app/Universals/helper/LoaderWidget.dart';
import 'package:alpha_app/Universals/helper/ToastHelper.dart';
import 'package:alpha_app/Universals/networking/NetworkConstant.dart';
import 'package:alpha_app/Universals/utils/AppColors.dart';
import 'package:alpha_app/Universals/utils/SharedPrefConstant.dart';
import 'package:alpha_app/DriverModules/widgets/LoadBoxWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectLoadDialog extends StatefulWidget {
  @override
  State<SelectLoadDialog> createState() => _SelectLoadDialogState();
}

class _SelectLoadDialogState extends State<SelectLoadDialog> {
  @override
  void initState() {
    super.initState();
  }

  final ScrollController _scrollController = ScrollController();

  int selectedLoad = 0;
  bool isSearchingOperation = false;

  List<LoadModel> loadList = [
    LoadModel(
        deliveryDate: '22/11/2022, 01:00 PM',
        pickUpDate: '20/11/2022, 02:00AM',
        loadNumber: '34445334533',
        shippersAddress: 'California,lockmark,\nStreet 50',
        reciverAddress: 'California,lockmark,\nStreet 50'),
    LoadModel( 
        deliveryDate: '21/11/2022, 01:00 PM', 
        pickUpDate: '19/11/2022, 02:00AM',
        loadNumber: '34445334533',
        shippersAddress: 'California,lockmark,\nStreet 50',
        reciverAddress: 'California,lockmark,\nStreet 50'),
    LoadModel(
        deliveryDate: '20/11/2022, 01:00 PM',
        pickUpDate: '18/11/2022, 02:00AM',
        loadNumber: '34445334533',
        shippersAddress: 'California,lockmark,\nStreet 50',
        reciverAddress: 'California,lockmark,\nStreet 50'),
    LoadModel(
        deliveryDate: '19/11/2022, 01:00 PM',
        pickUpDate: '17/11/2022, 02:00AM',
        loadNumber: '34445334533',
        shippersAddress: 'California,lockmark,\nStreet 50',
        reciverAddress: 'California,lockmark,\nStreet 50'),
    LoadModel(
        deliveryDate: '18/11/2022, 01:00 PM',
        pickUpDate: '16/11/2022, 02:00AM',
        loadNumber: '34445334533',
        shippersAddress: 'California,lockmark,\nStreet 50',
        reciverAddress: 'California,lockmark,\nStreet 50'),
    LoadModel(
        deliveryDate: '16/11/2022, 01:00 PM',
        pickUpDate: '14/11/2022, 02:00AM',
        loadNumber: '34445334533',
        shippersAddress: 'California,lockmark,\nStreet 50',
        reciverAddress: 'California,lockmark,\nStreet 50'),
    LoadModel(
        deliveryDate: '14/11/2022, 01:00 PM',
        pickUpDate: '12/11/2022, 02:00AM',
        loadNumber: '34445334533',
        shippersAddress: 'California,lockmark,\nStreet 50',
        reciverAddress: 'California,lockmark,\nStreet 50'),
    LoadModel(
        deliveryDate: '12/11/2022, 01:00 PM',
        pickUpDate: '10/11/2022, 02:00AM',
        loadNumber: '34445334533',
        shippersAddress: 'California,lockmark,\nStreet 50',
        reciverAddress: 'California,lockmark,\nStreet 50')
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: SimpleDialog(
        insetPadding: EdgeInsets.all(15),
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0.0,
        backgroundColor: AppColors.chatBgScreenColor,
        children: [
          Container(
            width: Get.width / 1,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            height: Get.height / 1.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: AppColors.primaryColor,
                  ),
                  height: 45,
                  width: Get.width / 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 30,
                          width: Get.width / 1.3,
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                            decoration: new InputDecoration.collapsed(
                                hintText: 'Search Loads...',
                                hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                              height: 40,
                              width: 40,
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.highlight_remove_rounded,
                                size: 25,
                                color: Colors.white,
                              )),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    // height: Get.height / 1.5,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Scrollbar(
                        isAlwaysShown: true,
                        controller: _scrollController,
                        child: ListView.builder(
                            controller: _scrollController,
                            shrinkWrap: true,
                            itemCount: loadList.length,
                            itemBuilder: (BuildContext context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(right: 18, left: 18),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedLoad = index;
                                    });
                                  },
                                  child: LoadBoxWidget(
                                      isSelected:
                                          selectedLoad == index ? true : false,
                                      loadModel: loadList[index]),
                                ),
                              );
                            }),
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 20, right: 20),
                //   child: InkWell(
                //     onTap: (){
                //       Navigator.pop(context,loadList[selectedLoad]);
                //     },
                //     child: Container(
                //       height: 45,
                //       decoration: BoxDecoration(
                //         color: AppColors.primaryColor,
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //       alignment: Alignment.center,
                //       child: Text(
                //         "Select",
                //         style: TextStyle(
                //             color: Colors.white,
                //             fontSize: 16,
                //             fontWeight: FontWeight.bold),
                //       ),
                //     ),
                //   ),
                // ),

                // SizedBox(
                //   height: 1,
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
