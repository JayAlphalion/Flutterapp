// @dart=2.9
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:io' as io;
import 'package:alpha_app/bloc/ClaimDataBloc.dart';
import 'package:alpha_app/helper/ImagePickerHelper.dart';
import 'package:alpha_app/helper/LoaderWidget.dart';
import 'package:alpha_app/helper/LocationTrackerHelper.dart';
import 'package:alpha_app/helper/SuccessDialogHelper.dart';
import 'package:alpha_app/helper/ToastHelper.dart';
import 'package:alpha_app/networking/NetworkConstant.dart';
import 'package:alpha_app/utils/AppColors.dart';
import 'package:alpha_app/utils/Constants.dart';
import 'package:alpha_app/utils/ImageUtils.dart';
import 'package:alpha_app/widgets/BottonWidget.dart';
import 'package:alpha_app/widgets/IconWithTitle.dart';
import 'package:alpha_app/widgets/TextFIeldWidget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddClaimsPage extends StatefulWidget {
  const AddClaimsPage({Key key}) : super(key: key);

  @override
  State<AddClaimsPage> createState() => _AddClaimsPageState();
}

class _AddClaimsPageState extends State<AddClaimsPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController secondPartyLoanNumber = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController secondPartyDriverNameController =
      TextEditingController();
  TextEditingController extraNotestController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<File> secondPartyLicenceImage = [];
  List<File> secondPartyInsuranceImage = [];
  List<File> policeReportImage = [];
  List<File> sceneImages = [];
  List<String> sceneImageUrl = [];
  List<File> otherImages = [];
  List<dynamic> _uploadTasks = [];
  List<String> secondPartyInsuranceImageUrl = [];
  List<String> secondPartyLicenceImageUrl = [];
  List<String> policeReportImageUrl = [];
  List<String> otherImagesUrl = [];
  ClaimDataBloc claimDataBloc;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  @override
  void initState() {
    claimDataBloc = ClaimDataBloc();

    _handleAddClaimsResponse();

    // TODO: implement initState
    super.initState();
  }

  void _handleAddClaimsResponse() {
    claimDataBloc.addClaimDataStream.listen((event) {
      Navigator.pop(context);
      if (event != NetworkConstant.FAILURE) {
        // ToastHelper().showToast(message: 'Claim Added Successfully Done');
        SuccessDialogHelper.openDialog(
            onDone: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            title: 'Claim Added',
            description:
                'Congratulations, Your Claim Added Successfully Done.\nWe will help you soon');
      } else {
        SuccessDialogHelper.openDialog(
            onDone: () {
              Navigator.pop(context);
              // Navigator.pop(context);
            },
            title: 'Request Failed',
            description:
                'Request Faild Due to Server Error, Please Try Again!.');
      }
    });
  }

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
                  title: 'Claim Title  (Optional)',
                  hintText: 'Enter here...',
                  controller: titleController),
              const SizedBox(
                height: 20,
              ),
              textFieldWidget(
                  title: '2nd Party Driver Name  (Optional)',
                  hintText: 'Enter here...',
                  controller: secondPartyDriverNameController),
              const SizedBox(
                height: 20,
              ),
              textFieldWidget(
                  title: '2nd Party Insurance No.  (Optional)',
                  hintText: 'Enter here...',
                  controller: secondPartyLoanNumber),
              const SizedBox(
                height: 20,
              ),
              textFieldWidget(
                  title: '2nd Party Phone No.  (Optional)',
                  hintText: 'Enter here...',
                  controller: phoneNo),
              const SizedBox(
                height: 20,
              ),
              textFieldWidget(
                  title: 'Messaage (Optional)',
                  hintText: 'Enter here...',
                  controller: extraNotestController),
              const SizedBox(
                height: 20,
              ),
              imageUploadWidget(
                  hintText: 'Please Select Scene Photo...',
                  title: 'Scene Photo  (Required)',
                  key: Constant.SceneImage,
                  imagesFiles: sceneImages),
              const SizedBox(
                height: 20,
              ),
              imageUploadWidget(
                  hintText: 'Please Select 2nd Party Drivary Lincence Photo...',
                  title: '2nd Party Drivery Licence Image  (Optional)',
                  key: Constant.LicenceImage,
                  imagesFiles: secondPartyLicenceImage),
              const SizedBox(
                height: 20,
              ),
              imageUploadWidget(
                  hintText: 'Please Select 2nd Party  Insurance photo...',
                  title: '2nd Party Insurance Image  (Optional)',
                  key: Constant.InsuranceImage,
                  imagesFiles: secondPartyInsuranceImage),
              const SizedBox(
                height: 20,
              ),
              imageUploadWidget(
                  hintText: 'Please Select Police Report Photo...',
                  title: 'Police Report  (Optional)',
                  key: Constant.PoliceImage,
                  imagesFiles: policeReportImage),
              const SizedBox(
                height: 20,
              ),
              imageUploadWidget(
                  hintText: 'Please Select Others Image if require...',
                  title: 'Others  (Optional)',
                  key: Constant.OthersImage,
                  imagesFiles: otherImages),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                  onTap: () {
                    submitClaim();
                  },
                  child: bottonWidget(title: 'Submit')),
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
      {String title, String hintText, String key, List<File> imagesFiles}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: Get.width / 1.5,
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
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
      case Constant.PoliceImage:
        policeReportImage.add(file);
        break;
      case Constant.SceneImage:
        sceneImages.add(file);
        break;
    }
    setState(() {});
    handleUploadTask(PickedFile(file.path), key);
  }

  void addUrl(String key, String url) {
    switch (key) {
      case Constant.LicenceImage:
        secondPartyLicenceImageUrl.add(url);
        break;
      case Constant.InsuranceImage:
        secondPartyInsuranceImageUrl.add(url);
        break;
      case Constant.OthersImage:
        otherImagesUrl.add(url);
        break;
      case Constant.PoliceImage:
        policeReportImageUrl.add(url);
        break;
      case Constant.SceneImage:
        sceneImageUrl.add(url);
        break;
    }
  }

  // void uploadImageToTheFirebase(File file, String key) {}

  Widget imageBox(String hintText, File file) {
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

/**
 * This Method is responsible for Upload files to the server.
 * [file] required parameter is file which you want to upload.
 *  */
  Future<firebase_storage.UploadTask> uploadImageToTheFirebase(
      PickedFile file, String key) async {
    if (file == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No file was selected'),
      ));
    }

    firebase_storage.UploadTask uploadTask;
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('claimsDoc')
        .child('/' + file.path.split('/').last);

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path});

    if (kIsWeb) {
      uploadTask = ref.putData(await file.readAsBytes(), metadata);
    } else {
      uploadTask = ref.putFile(io.File(file.path), metadata);

      return Future.value(uploadTask);
    }
  }

/**
 * This Method is Resonsible for Handle Files or images uploading task.
 * [file] Required parameter is file which you want to upload.
 */
  Future<dynamic> handleUploadTask(PickedFile file, String key) async {
    try {
      firebase_storage.UploadTask task =
          await uploadImageToTheFirebase(file, key);
      if (task != null) {
        if (mounted) {
          setState(() {
            _uploadTasks = [..._uploadTasks, task];
          });
        }

        uploadImageToTheFirebase(file, key);

        task.whenComplete(() async {
          String finalUrl = await getUrl(task.snapshot.ref);

          addUrl(key, finalUrl);
        });
      }
    } catch (e) {
      debugger();
    }
  }

/**
 * This Method is Responsible for get File or Image Url.
 * [ref] Refrence is a required parameter.
 */
  Future<String> getUrl(firebase_storage.Reference ref) async {
    try {
      final link = await ref.getDownloadURL();
      return link;
    } catch (e) {
      getUrl(ref);
    }
  }

  void submitClaim() {
    if (sceneImageUrl.isEmpty) {
      ToastHelper().showErrorToast(message: 'Please Add Scene Photo');
    } else {
      submitData();
    }
  }

  void submitData() async {
    NetworkDialog.showLoadingDialog(context, _keyLoader);
    Position position = await LocationTrackerHelper().getUserCurrentLocation();
    Map location = {
      'latitude': position.latitude,
      'lontitude': position.longitude
    };
    Map data = {
      'driver_dl': secondPartyLicenceImageUrl.toString(),
      'driver_insurance': secondPartyInsuranceImageUrl.toString(),
      'other_doc': otherImagesUrl.toString(),
      'police_report_doc': policeReportImageUrl.toString(),
      'location': json.encode(location),
      'notes_data': titleController.text,
      'driver_ph_no': phoneNo.text,
      'driver_name': secondPartyDriverNameController.text,
      'extra_notes': extraNotestController.text,
      'scene_image': sceneImageUrl.toString()
    };
    claimDataBloc.callAddClaims(data);
  }
}
