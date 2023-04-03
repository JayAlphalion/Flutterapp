import 'dart:convert';

import 'package:alpha_app/UserModules/DriverModules/Model/responses/GetPreviousClaim.dart';
import 'package:alpha_app/UserModules/DriverModules/Views/claims/AddClaimsPage.dart';
import 'package:alpha_app/UserModules/DriverModules/bloc/ClaimDataBloc.dart';
import 'package:alpha_app/Universals/networking/NetworkConstant.dart';
import 'package:alpha_app/Universals/utils/AppColors.dart';
import 'package:alpha_app/UserModules/DriverModules/widgets/CaursalSliderWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClaimsHomePage extends StatefulWidget {
  const ClaimsHomePage({Key? key}) : super(key: key);

  @override
  State<ClaimsHomePage> createState() => _ClaimsHomePageState();
}

class _ClaimsHomePageState extends State<ClaimsHomePage> {
  late ClaimDataBloc claimDataBloc;
  bool isloading = true;

  GetPreviousClaimApiResponse? getPreviousClaimData;

  @override
  void initState() {
    claimDataBloc = ClaimDataBloc();
    // TODO: implement initState
    super.initState();
    _handleGetPreviousClaimResponse();
    getAllPreviousClaim();
  }

  void _handleGetPreviousClaimResponse() {
    claimDataBloc.previousClaimDataStream.listen((event) {
      print(event);

      if (event != NetworkConstant.FAILURE) {
        getPreviousClaimData = GetPreviousClaimApiResponse.fromJson(event);
      }
      setState(() {
        isloading = false;
      });
    });
  }

  void getAllPreviousClaim() {
    Map parameter = {};
    claimDataBloc.callGetPreviousClaim(parameter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.chatBgScreenColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: const Text(
          "Claims",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: isloading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: getPreviousClaimData!.claims.length,
              itemBuilder: (BuildContext context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: InkWell(
                      onTap: () {
//   var jsonList = getPreviousClaimData!.data[index].claimData.sceneImage.split('[')[1].split(']')[0];
// print("jsonList: ${jsonList}");
                      },
                      // child: Container(
                      //   height: 130,
                      //   child:,
                      // )

                      child: Container(
                          padding: const EdgeInsets.all(0),
                          height: 200,
                          width: Get.width / 1,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            // image: const DecorationImage(
                            //     fit: BoxFit.cover,
                            //     opacity: 0.5,
                            //     image: NetworkImage(
                            //         'https://images.unsplash.com/photo-1500462918059-b1a0cb512f1d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1000&q=80')),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              CaursalSliderWidget(
                                  imageUrl: getPreviousClaimData!
                                      .claims[index].data.sceneImage,
                                      isInBackground: true,
                                      ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Claim Number : '+getPreviousClaimData!.claims[index].data.id.toString(),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 16),
                                          Text(
                                            'Claim Date : '+getPreviousClaimData!.claims[index].data.date,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Status:  ',
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            getPreviousClaimData!.claims[index].data.status,
                                            style: const TextStyle(
                                                color: Colors.red,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ]),
                              ),
                            ],
                          ))
                      //   child:
                      //

                      ),
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const AddClaimsPage());
        },
        child: const Icon(
          Icons.add,
          size: 35,
          color: Colors.white,
        ),
      ),
    );
  }
}
