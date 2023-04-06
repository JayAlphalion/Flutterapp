import 'package:alpha_app/Universals/utils/AppColors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CaursalSliderWidget extends StatefulWidget {
  final List<String> imageUrl;
  final bool isInBackground;
  CaursalSliderWidget({required this.imageUrl, required this.isInBackground});

  @override
  State<CaursalSliderWidget> createState() => _CaursalSliderWidgetState();
}

class _CaursalSliderWidgetState extends State<CaursalSliderWidget> {
  int currenctIndex = 0;
  @override
  Widget build(BuildContext context) {
    return widget.isInBackground == true
        ? CarouselSlider(
            options: CarouselOptions(
              height: 400,
              aspectRatio: 16 / 8,
              viewportFraction: 1.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0,
              scrollDirection: Axis.horizontal,
            ),
            items: widget.imageUrl.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 0.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          opacity: 0.5,
                          image: NetworkImage(i)),
                    ),
                  );
                },
              );
            }).toList(),
          )
        : Container(
            width: Get.width / 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: Get.height / 3.3,
                    aspectRatio: 16 / 8,
                    viewportFraction: 1.0,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0,
                    onPageChanged: (val, reasion) {
                      setState(() {
                        currenctIndex = val;
                      });
                      print(currenctIndex);
                    },
                    scrollDirection: Axis.horizontal,
                  ),
                  items: widget.imageUrl.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return CachedNetworkImage(
  imageUrl: i,
  imageBuilder: (context, imageProvider) => Container(
    decoration: BoxDecoration(
      image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.fill,
          ),
    ),
  ),
  placeholder: (context, url) => Icon(Icons.image,size: 100,color: Colors.black26,),
  errorWidget: (context, url, error) => Icon(Icons.image,size: 100,color: Colors.black26,),
);
                        // return Container(
                        //   width: MediaQuery.of(context).size.width,
                        //   margin: EdgeInsets.symmetric(horizontal: 0.0),
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(
                        //         widget.isInBackground == true ? 10 : 0),
                        //     image: DecorationImage(
                        //         fit: BoxFit.cover,
                        //         opacity:
                        //             widget.isInBackground == true ? 0.5 : 1,
                        //         image: NetworkImage(i)),
                        //   ),
                        // );
                      },
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  width: Get.width / 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < widget.imageUrl.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(left: 3, right: 3),
                          child: Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: currenctIndex == i
                                    ? AppColors.primaryColor
                                    : Colors.blue[200]),
                          ),
                        )
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
