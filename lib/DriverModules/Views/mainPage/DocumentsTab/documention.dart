import 'dart:io';

import 'package:alpha_app/DriverModules/Views/Previews/ImagePreviewScreen.dart';
import 'package:alpha_app/Universals/utils/AppColors.dart';
import 'package:alpha_app/DriverModules/Views/DrawersPage/drawer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool textScanning = false;

  XFile? imageFile;

  String scannedText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.chatBgScreenColor,
      drawer: MyDrawer(),
      appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
              icon: new Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          title: Text('Documents'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.refresh,
                size: 30,
              ),
            ),
          ],
          backgroundColor: AppColors.primaryColor),
      body: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 00),
                _buildDataContainer(),
                _buildDataContainer(),
                _buildDataContainer(),
              ],
            )),
      ),
    );
  }

  Container _buildDataContainer() {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: AppColors.greyColor)),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: _buildDataColumn({
        'Load No.:  ': '123123',
        'Delivery Date: ': '123123',
        'Pickup Date: ': '123123',
      }, {
        'BOI':
            'https://images.unsplash.com/photo-1500462918059-b1a0cb512f1d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1000&q=80',
        'EOD':
            'https://images.unsplash.com/photo-1500462918059-b1a0cb512f1d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1000&q=80',
        'LUMPUR':
            'https://images.unsplash.com/photo-1500462918059-b1a0cb512f1d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1000&q=80'
      }),
    );
  }

  Widget _buildDataColumn(
      Map<String, String> infoVals, Map<String, String> imageSubtitleMap) {
    List<Widget> returnableItems = [];
    infoVals.forEach(
      (key, value) {
        returnableItems.add(
          Container(
            margin: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  key,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xff1C5AA3), //font color
                  ),
                ),
                Expanded(
                  child: Text(
                    value,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Color(0xff1C5AA3),
                        fontWeight: FontWeight.bold //font color
                        ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    List<Widget> rowItems = [];
    imageSubtitleMap.forEach(
      (key, value) {
        rowItems.add(Column(
          children: [
            GestureDetector(
              onTap: () {
                Get.to(ImagePrivewScreen(url: value));
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                height: Get.height * 0.12,
                width: Get.height * 0.1,
                child: CachedNetworkImage(
                  imageUrl: value,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Container(
                    height: 20,
                    width: 20,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress),
                  ),
                  errorWidget: (context, url, error) => Container(
                      height: 20,
                      width: 20,
                      alignment: Alignment.center,
                      child: Icon(Icons.error)),
                ),
              ),
            ),
            Text(
              key,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ));
      },
    );

    returnableItems.add(Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: rowItems,
      ),
    ));

    // items.add(
    //   Container(
    //       margin: const EdgeInsets.symmetric(vertical: 10),
    //       height: 100,
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         children: imgItems.map((e) {
    //           return GestureDetector(
    //             onTap: () {
    //               Get.to(ImagePrivewScreen(url: e));
    //             },
    //             child: Container(
    //               margin: const EdgeInsets.symmetric(horizontal: 2),
    //               height: 100,
    //               width: 100,
    //               child: CachedNetworkImage(
    //                 imageUrl: e,
    //                 fit: BoxFit.cover,
    //                 progressIndicatorBuilder:
    //                     (context, url, downloadProgress) => Container(
    //                   height: 20,
    //                   width: 20,
    //                   alignment: Alignment.center,
    //                   child: CircularProgressIndicator(
    //                       value: downloadProgress.progress),
    //                 ),
    //                 errorWidget: (context, url, error) => Container(
    //                     height: 20,
    //                     width: 20,
    //                     alignment: Alignment.center,
    //                     child: Icon(Icons.error)),
    //               ),
    //             ),
    //           );
    //         }).toList(),
    //       )),
    // );
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: returnableItems,
    );
  }

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        setState(() {});
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      scannedText = "Error occured while scanning";
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
  }
}
