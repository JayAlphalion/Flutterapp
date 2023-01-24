import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';

class CaursalSliderWidget extends StatefulWidget {
  final List<String> imageUrl;
  CaursalSliderWidget({required this.imageUrl});

  @override
  State<CaursalSliderWidget> createState() => _CaursalSliderWidgetState();
}

class _CaursalSliderWidgetState extends State<CaursalSliderWidget> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
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
        // onPageChanged: (){},
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
                    fit: BoxFit.cover, opacity: 0.5, image: NetworkImage(i)),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
