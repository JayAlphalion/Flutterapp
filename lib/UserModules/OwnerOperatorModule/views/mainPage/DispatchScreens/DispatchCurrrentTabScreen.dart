import 'dart:io';

import 'package:alpha_app/UserModules/DriverModules/Dialogs/AlertDialogBox.dart';
import 'package:alpha_app/UserModules/DriverModules/Model/responses/GetCurrentLoadDispatchResponse.dart';
import 'package:alpha_app/Universals/widgets/LocalImagePreviewScreen.dart';
import 'package:alpha_app/Universals/utils/AppColors.dart';
import 'package:alpha_app/Universals/utils/ImageUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class OwOpDispatchCurrentTab extends StatefulWidget {
  // const DispatchCurrentTab({super.key});
  final GetCurrentLoadDispatchResponse? currentLoadDispatchResponse;
  OwOpDispatchCurrentTab({this.currentLoadDispatchResponse});
  @override
  State<OwOpDispatchCurrentTab> createState() => _OwOpDispatchCurrentTabState();
}

class _OwOpDispatchCurrentTabState extends State<OwOpDispatchCurrentTab> {
  bool bolUploaded = false;
  bool podUploaded = false;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return widget.currentLoadDispatchResponse == null
        ? Center(
          child: Text("No Load available"),
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
                              widget.currentLoadDispatchResponse!.PUDate +
                                  ' ' +
                                  widget.currentLoadDispatchResponse!.PUTime,
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
                            widget
                                .currentLoadDispatchResponse!.shipperAddress[0],
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
                                widget.currentLoadDispatchResponse!.DELDate +
                                ' ' +
                                widget.currentLoadDispatchResponse!.DELTime,
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
                            widget.currentLoadDispatchResponse!
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
                                widget.currentLoadDispatchResponse!.LoadType,
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
                                widget.currentLoadDispatchResponse!.LoadType,
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
                                widget.currentLoadDispatchResponse!.dropType,
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
                            widget.currentLoadDispatchResponse!.loadNumber,
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

  void takeImage() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            children: [
              ListTile(
                onTap: () {
                  takeImageFromCamera();
                },
                leading: Icon(Icons.camera_alt_rounded),
                title: Text('Camera'),
              ),
              ListTile(
                onTap: () {
                  takeImageFromGallery();
                },
                leading: Icon(Icons.image),
                title: Text('Gallery'),
              ),
            ],
          ),
        );
      },
    );
  }

  void takeImageFromCamera() {}

  void takeImageFromGallery() async {
    Navigator.pop(context);
    var pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    print(pickedImage);
    Get.to(LocalImagePreviewScreen(
      imageFilee: File((pickedImage!.path)),
    ))!
        .then((value) {
      if (bolUploaded == false) {
        if (value != null) {
          setState(() {
            bolUploaded = true;
          });
        }
      } else {
        if (value != null) {
          setState(() {
            podUploaded = true;
          });
        }
      }
    });
  }

  Widget getUploadBotttotn(
    bool enable,
  ) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: enable == false ? Colors.black26 : AppColors.primaryColor,
          ),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            enable == false
                ? Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Icon(
                      Icons.image,
                      size: 25,
                      color: Colors.black26,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Lottie.asset(
                      ImageUtils.Upload_Blink,
                      height: 35,
                    ),
                  ),
            Text(
              enable == false
                  ? 'BOL & POD Uploaded'
                  : bolUploaded == true
                      ? 'Upload POD'
                      : " Upload BOL",
              style: TextStyle(
                  color: enable == false ? Colors.black26 : Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
