import 'dart:io';

import 'package:alpha_app/helper/ImagePickerHelper.dart';
import 'package:alpha_app/utils/AppColors.dart';
import 'package:alpha_app/utils/Constants.dart';
import 'package:alpha_app/utils/ImageUtils.dart';
import 'package:alpha_app/widgets/BottonWidget.dart';
import 'package:alpha_app/widgets/IconWithTitle.dart';
import 'package:alpha_app/widgets/TextFIeldWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';

class AddClaimsPage extends StatefulWidget {
  const AddClaimsPage({Key? key}) : super(key: key);

  @override
  State<AddClaimsPage> createState() => _AddClaimsPageState();
}

class _AddClaimsPageState extends State<AddClaimsPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController secondPartyLoanNumber = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<File> secondPartyLicenceImage = [];
  List<File> secondPartyInsuranceImage = [];
  List<File> otherImages = [];

  List<String> secondPartyInsuranceImageUrl = [];
  List<String> secondPartyLicenceImageUrl = [];
  List<String> otherImagesUrl = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.chatBgScreenColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: const Text(
          "Add New Claims",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              textFieldWidget(
                  title: 'Claim Title',
                  hintText: 'Enter here...',
                  controller: titleController),
              const SizedBox(
                height: 20,
              ),
              textFieldWidget(
                  title: '2nd Party Insurance No.',
                  hintText: 'Enter here...',
                  controller: secondPartyLoanNumber),
              const SizedBox(
                height: 20,
              ),
              textFieldWidget(
                  title: '2nd Party Phone No',
                  hintText: 'Enter here...',
                  controller: phoneNo),
              const SizedBox(
                height: 20,
              ),
              imageUploadWidget(
                  hintText: 'Please Select 2nd Party Drivary Lincence Photo...',
                  title: '2nd Party Drivery Licence Image',
                  key: Constant.LicenceImage,
                  imagesFiles: secondPartyLicenceImage),
              const SizedBox(
                height: 20,
              ),
              imageUploadWidget(
                  hintText: 'Please Select 2nd Party  Insurance photo...',
                  title: '2nd Party Insurance Image',
                  key: Constant.InsuranceImage,
                  imagesFiles: secondPartyInsuranceImage),
              const SizedBox(
                height: 20,
              ),
              imageUploadWidget(
                  hintText: 'Please Select Others Image if require...',
                  title: 'Others',
                  key: Constant.OthersImage,
                  imagesFiles: otherImages),
              const SizedBox(
                height: 20,
              ),
              bottonWidget(title: 'Submit'),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget imageUploadWidget(
      {required String title,
      required String hintText,
      required String key,
      required List<File> imagesFiles}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            InkWell(
              onTap: () {
                selectImage(
                  key,
                );
              },
              child: const Icon(
                Icons.add_circle_outline_sharp,
                size: 35,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        imagesFiles.isEmpty ? imageBox(hintText, null) : Container(),
        for (int i = 0; i < imagesFiles.length; i++)
          Padding(
            padding: EdgeInsets.only(top: i == 0 ? 0 : 10),
            child: imageBox(hintText, imagesFiles[i]),
          )
      ],
    );
  }

  void selectImage(String key) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
          child: Wrap(
            children: [
              InkWell(
                onTap: () async {
                  Navigator.pop(context);
                  var file = await ImagePickerHelper().getImageFromGallery();
                  addImage(key, file);
                },
                child: Row(
                  children: const [
                    Icon(
                      Icons.image,
                      size: 25,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Gallery',
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () async {
                  Navigator.pop(context);
                  var file = await ImagePickerHelper().getImageFromCamera();
                  addImage(key, file);
                  // scanImageFromCamera();
                },
                child: Row(
                  children: const [
                    Icon(
                      Icons.camera_alt_outlined,
                      size: 25,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Camera',
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      },
    );
  }

  void addImage(String key, File file) {
    switch (key) {
      case Constant.LicenceImage:
        secondPartyLicenceImage.add(file);
        break;
      case Constant.InsuranceImage:
        secondPartyInsuranceImage.add(file);
        break;
      case Constant.OthersImage:
        otherImages.add(file);
        break;
    }
    setState(() {});
    uploadImageToTheFirebase(file, key);
  }

  void uploadImageToTheFirebase(File file, String key) {}

  Widget imageBox(String hintText, File? file) {
    return Container(
      height: 150,
      width: Get.width / 1,
      decoration: file == null
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1, color: Colors.black26),
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1, color: Colors.black26),
              image: DecorationImage(image: FileImage(file), fit: BoxFit.fill)),
      alignment: Alignment.center,
      child: file == null
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                hintText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.black54),
              ),
            )
          : Container(),
    );
  }
}
