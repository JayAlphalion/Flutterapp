import 'package:alpha_app/DriverModules/Dialogs/AlertDialogBox.dart';
import 'package:alpha_app/DriverModules/Model/responses/UpcomingLoadDispatchApiResponse.dart';
import 'package:flutter/material.dart';

class DispatchUpcommingTab extends StatefulWidget {
  final UpcomingLoadDispatchApiResponse? upcomingLoadDispatchApiResponse;
  DispatchUpcommingTab({this.upcomingLoadDispatchApiResponse});

  @override
  State<DispatchUpcommingTab> createState() => _DispatchUpcommingTabState();
}

class _DispatchUpcommingTabState extends State<DispatchUpcommingTab> {
  @override
  Widget build(BuildContext context) {
    return widget.upcomingLoadDispatchApiResponse == null
        ? Center(
            child: Text("No Loads Assigned"),
          )
        : ListView.builder(
            itemCount: 1,
            itemBuilder: (BuildContext context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    // mainAxisAlignment: m,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.min,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Text(
                              "Shipment Time : ",
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xff1C5AA3), //font color
                              ),
                            ),
                            Text(
                              widget.upcomingLoadDispatchApiResponse!
                                      .shipperDetails.PUDate +
                                  ' ' +
                                  widget.upcomingLoadDispatchApiResponse!
                                      .shipperDetails.PUTime,
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
                            "Shipment Location:",
                            style: TextStyle(
                              fontSize: 16,

                              color: Colors.black, //font color
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              widget.upcomingLoadDispatchApiResponse!
                                  .shipperDetails.shipperAddress,
                              //   "California,lockmark,\nStreet 50",
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
                            "Delivery Time: " +
                                widget.upcomingLoadDispatchApiResponse!
                                    .receiverDetails.deliveryDate +
                                ' ' +
                                widget.upcomingLoadDispatchApiResponse!
                                    .receiverDetails.deliveryTime,
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff1C5AA3), //font color
                            ),
                          ),
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
                            "Delivery Location:",
                            style: TextStyle(
                              fontSize: 16,

                              color: Colors.black, //font color
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              widget.upcomingLoadDispatchApiResponse!
                                  .receiverDetails.receiverAddress,
                              //"California,lockmark,\nStreet 50",
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
                            "Pick Type: " +
                                widget.upcomingLoadDispatchApiResponse!
                                    .shipperDetails.PUType,
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
                                widget.upcomingLoadDispatchApiResponse!
                                    .receiverDetails.DropType,
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pickup No : ",
                            style: TextStyle(
                              fontSize: 16,

                              color: Colors.black, //font color
                            ),
                          ),
                          Text(
                            widget.upcomingLoadDispatchApiResponse!.PUNumber,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, //font color
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Check In : ",
                            style: TextStyle(
                              fontSize: 16,

                              color: Colors.black, //font color
                            ),
                          ),
                          Text(
                            "Alpha Lion Trucking LLC",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, //font color
                            ),
                          ),
                        ],
                      ),

                      // Padding(
                      //   padding: const EdgeInsets.only(left: 30, right: 30, top: 0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Padding(
                      //         padding: const EdgeInsets.only(top: 25),
                      //         child: Column(
                      //           children: [
                      //      bolUploaded==true?    Icon(Icons.circle,size:30,color:Colors.red):       Lottie.asset(ImageUtils.Blink_DOT,
                      //                 height: 30, width: 30),
                      //             SizedBox(
                      //               height: 10,
                      //             ),
                      //             Text(
                      //               "BOL",
                      //               style: TextStyle(
                      //                   color: Colors.black45,
                      //                   fontSize: 15,
                      //                   fontWeight: FontWeight.w500),
                      //             )
                      //           ],
                      //         ),
                      //       ),
                      //       Container(
                      //         width: Get.width / 2.3,
                      //         height: 2,
                      //         color: Colors.red,
                      //       ),
                      //       Padding(
                      //         padding: const EdgeInsets.only(top: 25),
                      //         child: Column(
                      //           children: [
                      //       podUploaded==true?    Icon(Icons.circle,size:30,color:Colors.red):   Lottie.asset(ImageUtils.Blink_DOT,
                      //                 height: 30, width: 30),
                      //             SizedBox(
                      //               height: 10,
                      //             ),
                      //             Text(
                      //               "POD",
                      //               style: TextStyle(
                      //                   color: Colors.black45,
                      //                   fontSize: 15,
                      //                   fontWeight: FontWeight.w500),
                      //             )
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),

// SizedBox(height: 20,),
// Bounce(
//   duration: Duration(milliseconds: 110),
//   onPressed:bolUploaded==true &&podUploaded==true?(){}: (){
// takeImage();
//   },
//   child:
//   bolUploaded==true &&podUploaded==true?getUploadBotttotn(false):
//   getUploadBotttotn(true),
// ),

                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }

  void callAlertDialog(String? title) {
    //  showDialog<String>(
    //       context: context,
    //       //barrierColor: Colors.white.withOpacity(0),
    //       barrierDismissible: false,
    //       builder: (BuildContext context) {
    //         return AlertDialogBox(
    //           title: title!,

    //         );
    //       });
  }
}
