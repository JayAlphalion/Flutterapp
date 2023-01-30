import 'package:alpha_app/DriverModules/Dialogs/AlertDialogBox.dart';
import 'package:alpha_app/DriverModules/Model/responses/GetPastDispatchLoadsHistoryAPI.dart';
import 'package:flutter/material.dart';

class DispatchPastTab extends StatefulWidget {
  final GetPastDispatchLoadApiResponse? pastDispatchLoadApiResponse;
  DispatchPastTab({this.pastDispatchLoadApiResponse});

  @override
  State<DispatchPastTab> createState() => _DispatchPastTabState();
}

class _DispatchPastTabState extends State<DispatchPastTab> {
  @override
  Widget build(BuildContext context) {
    return 
    widget.pastDispatchLoadApiResponse == null
        ? Center(
            child: Text("No Loads Assigned Yet "),
          )
        : 
    ListView.builder(
      itemCount: widget.pastDispatchLoadApiResponse!.data.length,
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
                        widget.pastDispatchLoadApiResponse!.data[index].PUDate +
                            ' ' +
                            widget.pastDispatchLoadApiResponse!.data[index]
                                .PUTime,
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
                    Text(
                      widget.pastDispatchLoadApiResponse!.data[index]
                          .shipperAddress[0],
                      //   "California,lockmark,\nStreet 50",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, //font color
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
                          widget.pastDispatchLoadApiResponse!.data[index]
                              .DELDate +
                          ' ' +
                          widget
                              .pastDispatchLoadApiResponse!.data[index].DELTime,
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
                      "Delivery Location: ",
                      style: TextStyle(
                        fontSize: 16,

                        color: Colors.black, //font color
                      ),
                    ),
                    Text(
                      widget.pastDispatchLoadApiResponse!.data[index]
                          .receiverAddress[0],
                      //"California,lockmark,\nStreet 50",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, //font color
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
                      "Commodity: " +
                          widget.pastDispatchLoadApiResponse!.data[index]
                              .LoadType,
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
                          widget.pastDispatchLoadApiResponse!.data[index]
                              .LoadType,
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
                          widget.pastDispatchLoadApiResponse!.data[index]
                              .dropType,
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
                      widget
                          .pastDispatchLoadApiResponse!.data[index].loadNumber,
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
                  children: [
                    Text(
                      "Status : ",
                      style: TextStyle(
                        fontSize: 16,

                        color: Colors.black, //font color
                      ),
                    ),
                    Text(
                      widget.pastDispatchLoadApiResponse!.data[index].status,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green, //font color
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
}
