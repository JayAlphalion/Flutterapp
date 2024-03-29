import 'package:alpha_app/Universals/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DownloadIconWidget extends StatefulWidget {
  final String downloadedPercentage;
  final bool isDownloaded;
  final bool isDownloading;
  final double? radius;
  final double? iconSize;
  DownloadIconWidget(
      {required this.downloadedPercentage,
      required this.isDownloaded,
      required this.isDownloading,
       this.radius,
       this.iconSize
      });

  @override
  State<DownloadIconWidget> createState() => _DownloadIconWidgetState();
}

class _DownloadIconWidgetState extends State<DownloadIconWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.isDownloaded == true
        ? Container()
        : Container(
            child:  CircularPercentIndicator(
            
                  radius: widget.radius?? 30.0,
                  lineWidth: 4.0,
                  percent: widget.downloadedPercentage == '-1'
                      ? 0
                      : double.parse((int.parse(widget.downloadedPercentage
                                      .split("%")
                                      .first) /
                                  100)
                              .toString()),
                  center:  Icon(
                    Icons.download,
                    size: widget.iconSize??25,
                    color: Colors.blue,
                  ),
                  progressColor: Colors.green,
                ));
  }
}
