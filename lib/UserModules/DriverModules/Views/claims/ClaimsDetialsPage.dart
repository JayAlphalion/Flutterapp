import 'package:alpha_app/Universals/HelperViews/VideoPlayerPage.dart';
import 'package:alpha_app/Universals/utils/AppColors.dart';
import 'package:alpha_app/Universals/HelperViews/ImagePreviewScreen.dart';
import 'package:alpha_app/UserModules/DriverModules/widgets/CaursalSliderWidget.dart';
import 'package:alpha_app/UserModules/DriverModules/widgets/VideoCard.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import '../../Model/responses/GetPreviousClaim.dart';

class ClaimsDetailsPage extends StatefulWidget {
  final ClaimData claim;
  ClaimsDetailsPage({required this.claim});

  @override
  State<ClaimsDetailsPage> createState() => _ClaimsDetailsPageState();
}

class _ClaimsDetailsPageState extends State<ClaimsDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.chatBgScreenColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: Text(
          'Claim No. ${widget.claim.id.toString()}',
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width / 1,
              height: Get.height / 3,
              child: CaursalSliderWidget(
                imageUrl: widget.claim.sceneImage,
                isInBackground: false,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Text(
                widget.claim.extraNotes,
                style: const TextStyle(color: Colors.black87, fontSize: 16),
              ),
            ),
            Divider(
              height: 3,
              color: Colors.black45,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Column(
                children: [
                  textValueWidget(
                      title: 'Claim No. :', value: widget.claim.id.toString()),
                  const SizedBox(
                    height: 10,
                  ),
                  textValueWidget(
                      title: '2nd Party Driver Name :',
                      value: widget.claim.driverName.toString()),
                  SizedBox(
                    height: 10,
                  ),
                  textValueWidget(
                      title: '2nd Party Phone No. :',
                      value: widget.claim.driverPhNo.toString()),
                  SizedBox(
                    height: 20,
                  ),
                  imageWithTitle(
                      title: '2nd Party Insurance Photos: ',
                      imageUrl: widget.claim.driverInsurance),
                  const SizedBox(
                    height: 20,
                  ),
                  imageWithTitle(
                      title: '2nd Party Drivery Licence Photos: ',
                      imageUrl: widget.claim.driverDl),
                  const SizedBox(
                    height: 20,
                  ),
                  imageWithTitle(
                      title: 'Police Report Photos: ',
                      imageUrl: widget.claim.policeReportDoc),
                  const SizedBox(
                    height: 20,
                  ),
                  imageWithTitle(
                      title: 'Other Photos: ', imageUrl: widget.claim.otherDoc),
                  const SizedBox(
                    height: 20,
                  ),
                  videoWithTitle(
                      title: 'Scene Video: ', videoUrl: widget.claim.video),
                  const SizedBox(
                    height: 20,
                  ),
                  audioWithTitle(
                      title: 'Voice Message:', audioUrl: widget.claim.audio),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        elevation: 0.0,
        color: Colors.transparent,
        child: Container(
          height: 50,
          decoration: const BoxDecoration(
              color: AppColors.chatBgScreenColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: Get.width / 2.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(width: 1, color: AppColors.primaryColor),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.call,
                      size: 20,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Call Us",
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                height: 40,
                width: Get.width / 2.3,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.edit,
                      size: 20,
                      color: AppColors.whiteColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Edit Claim",
                      style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget imageWithTitle(
      {required String title, required List<String> imageUrl}) {
    return Container(
      width: Get.width / 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                ),
              ),
              imageUrl.length == 0
                  ? const Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'N/A',
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Wrap(direction: Axis.horizontal, children: [
            for (int i = 0; i < imageUrl.length; i++)
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: InkWell(
                  onTap: () {
                    Get.to(ImagePrivewScreen(url: imageUrl[i]));
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 1, color: Colors.black38),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl[i],
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Icon(
                        Icons.image,
                        size: 100,
                        color: Colors.black26,
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.image,
                        size: 100,
                        color: Colors.black26,
                      ),
                    ),
                  ),
                ),
              ),
          ]),
        ],
      ),
    );
  }

  Widget videoWithTitle(
      {required String title, required List<String> videoUrl}) {
    return Container(
      width: Get.width / 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                ),
              ),
              videoUrl.length == 0
                  ? const Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'N/A',
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Wrap(direction: Axis.horizontal, children: [
            for (int i = 0; i < videoUrl.length; i++)
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: InkWell(
                    onTap: () {
                      Get.to(VideoPlayerPage(url: videoUrl[i],));
                    },
                    child: VideoCard(
                      url: videoUrl[i],
                    )),
              ),
          ]),
        ],
      ),
    );
  }

  Widget textValueWidget({required String title, required String value}) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.black87, fontSize: 15),
        ),
        Text(
          value,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ],
    );
  }

  Widget audioWithTitle(
      {required String title, required List<String> audioUrl}) {
    return Container(
      // width: Get.width / 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                ),
              ),
              audioUrl.length == 0
                  ? const Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'N/A',
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Wrap(direction: Axis.vertical, children: [
            for (int i = 0; i < audioUrl.length; i++)
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: InkWell(
                  onTap: () {
                    Get.to(ImagePrivewScreen(url: audioUrl[i]));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Container(
                      width: Get.width / 1.125,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 1, color: Colors.black38),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Icon(
                              Icons.play_arrow,
                              size: 25,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Audio Sound",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ]),
        ],
      ),
    );
  }
}
