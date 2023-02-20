import 'dart:io';

import 'package:alpha_app/Universals/widgets/ImagePreviewScreen.dart';
import 'package:alpha_app/Universals/utils/AppColors.dart';
import 'package:alpha_app/UserModules/DriverModules/Views/DrawersPage/drawer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'Ow_Op_DriverDrocuments.dart';

class OwOpDocuments extends StatefulWidget {
  const OwOpDocuments({Key? key}) : super(key: key);

  @override
  State<OwOpDocuments> createState() => _OwOpDocumentsState();
}

class _OwOpDocumentsState extends State<OwOpDocuments> {
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
          centerTitle: true,
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
                _buildTruckNameContainer('Truck A'),
                _buildTruckNameContainer('Truck B'),
                _buildTruckNameContainer('Truck C'),
                _buildTruckNameContainer('Truck D'),
                _buildTruckNameContainer('Truck E'),
              ],
            )),
      ),
    );
  }

  Widget _buildTruckNameContainer(String truckName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const OwOpDriverDocuments()));
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(width: 2, color: AppColors.primaryColor)),
        title: Text(
          truckName,
          style: const TextStyle(
              color: AppColors.primaryColor, fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: AppColors.primaryColor,
        ),
      ),
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
