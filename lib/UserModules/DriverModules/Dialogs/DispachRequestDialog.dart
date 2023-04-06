import 'dart:convert';
import 'dart:developer';

import 'package:alpha_app/UserModules/DriverModules/Dialogs/AlertDialogBox.dart';
import 'package:alpha_app/UserModules/DriverModules/Model/responses/NewLoadRequestResponse.dart';
import 'package:alpha_app/UserModules/DriverModules/bloc/LoadRequestDataBloc.dart';
import 'package:alpha_app/Universals/helper/LoaderWidget.dart';
import 'package:alpha_app/Universals/helper/ToastHelper.dart';
import 'package:alpha_app/Universals/networking/NetworkConstant.dart';
import 'package:alpha_app/Universals/utils/SharedPrefConstant.dart';
import 'package:alpha_app/Universals/utils/SharedPrefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DispachRequestDialog extends StatefulWidget {
  final NewLoadRequestionResponse newLoadRequestionResponse;
  DispachRequestDialog({required this.newLoadRequestionResponse});
  @override
  State<DispachRequestDialog> createState() => _DispachRequestDialogState();
}

class _DispachRequestDialogState extends State<DispachRequestDialog> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  late LoadRequestDataBloc loadRequestDataBlocLoadRequestDataBloc;

  void callAcceptRejectMethod(bool decision) async {
    // debugger();
    String? token = await SharedPref().getUserToken();
    NetworkDialog.showLoadingDialog(context, _keyLoader);
    Map data = {
      NetworkConstant.API_PARAM_DRIVER_TOKEN: token,
      NetworkConstant.API_PARAM_LOAD_NO:
          widget.newLoadRequestionResponse.loadNumber.toString(),
      NetworkConstant.API_PARAM_ACCEPT: decision.toString()
    };
    // debugger();
    // print(data);
    loadRequestDataBlocLoadRequestDataBloc.callAcceptRejectLoadRequest(data);
  }

  @override
  void initState() {
    // TODO: implement initState
    loadRequestDataBlocLoadRequestDataBloc = LoadRequestDataBloc();
    loadRequestDataBlocLoadRequestDataBloc.loadRequestAcceptRejectDataStream
        .listen((event) {
      Navigator.pop(context);

      print(event);
      try {
        var res = json.decode(event);

        if (res['response'] == 'sucess') {
          ToastHelper().showToast(message: 'Successfully done');
          Navigator.pop(context);
        } else {
          ToastHelper().showErrorToast(message: res['response']);
        }
      } catch (e) {
        print(e);
      }
    });

    super.initState();
  }

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
        backgroundColor: Colors.white,
        children: [
          Container(
            width: Get.width / 1,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Column(
                // mainAxisAlignment: m,
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: Text('Dispatch Request',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                  const Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: Text(
                        "You have new Dispatch Request, Would you like to Accept it?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Text(
                          "Pickup Time : ",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff1C5AA3), //font color
                          ),
                        ),
                        Text(
                          widget.newLoadRequestionResponse.PUDate +
                              ' ' +
                              widget.newLoadRequestionResponse.PUTime,
                          style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff1C5AA3),
                              fontWeight: FontWeight.bold //font color
                              ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Shipment Location: ",
                        style: TextStyle(
                          fontSize: 16,

                          color: Colors.black, //font color
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.newLoadRequestionResponse.shipperAddress[0] +
                              ', ' +
                              widget.newLoadRequestionResponse.shipperCity[0] +
                              ', ' +
                              widget.newLoadRequestionResponse.shipperState[0] +
                              ', ' +
                              widget.newLoadRequestionResponse.shipperZip[0],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black, //font color
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Text(
                        "Delivery Time: ",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff1C5AA3), //font color
                        ),
                      ),
                      Text(
                        widget.newLoadRequestionResponse.deliveryDate +
                            ' ' +
                            widget.newLoadRequestionResponse.deliveryTime,
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff1C5AA3),
                            fontWeight: FontWeight.bold //font color
                            ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Delivery Location: ",
                        style: TextStyle(
                          fontSize: 16,

                          color: Colors.black, //font color
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.newLoadRequestionResponse.receiverAddress[0] +
                              ', ' +
                              widget.newLoadRequestionResponse.receiverCity[0] +
                              ', ' +
                              widget
                                  .newLoadRequestionResponse.receiverState[0] +
                              ', ' +
                              widget.newLoadRequestionResponse.receiverZip[0],
                          //  widget.newLoadRequestionResponse.receiverAddress[0],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black, //font color
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        "Commodity: "
                        //+
                        //  widget.newLoadRequestionResponse.carrierRC[0].
                        ,
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff1C5AA3), //font color
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "Pick Type: " +
                            widget.newLoadRequestionResponse.loadType,
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff1C5AA3), //font color
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "Delivery Type: " +
                            widget.newLoadRequestionResponse.DropType,
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff1C5AA3), //font color
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          // callAlertDialog("Accept");

                          callAcceptRejectMethod(true);
                          // Navigator.pop(context);
                        },
                        child: Container(
                          height: 45,
                          width: 120,
                          decoration: BoxDecoration(
                              color: Color(0xff1C5AA3),
                              borderRadius: BorderRadius.circular(8)),
                          alignment: Alignment.center,
                          child: Text(
                            "Accept",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white, //font color
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // callAlertOnReject("Reject");
                          callAcceptRejectMethod(false);
                          // Navigator.pop(context);
                        },
                        child: Container(
                          height: 45,
                          width: 120,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8)),
                          alignment: Alignment.center,
                          child: Text(
                            "Reject",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white, //font color
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void callAlertDialog(String? title) {
    // debugger();
    showDialog<String>(
        context: context,
        //barrierColor: Colors.white.withOpacity(0),
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialogBox(
            title: title!,
            onAccept: () {
              Navigator.pop(context);
              // Get.back();
              callAcceptRejectMethod(true);
            },
            onReject: () {
              Navigator.pop(context);
              // debugger();
              //  Get.back();
              // callAcceptRejectMethod(false);
            },
          );
        });
  }

  void callAlertOnReject(String? title) {
    // debugger();
    showDialog<String>(
        context: context,
        //barrierColor: Colors.white.withOpacity(0),
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialogBox(
            title: title!,
            onAccept: () {
              Navigator.pop(context);
              // Get.back();
              callAcceptRejectMethod(false);
            },
            onReject: () {
              Navigator.pop(context);
              // debugger();
              //  Get.back();
              // callAcceptRejectMethod(false);
            },
          );
        });
  }
}
