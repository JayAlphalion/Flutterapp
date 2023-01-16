import 'package:alpha_app/utils/AppColors.dart';
import 'package:flutter/material.dart';

class DownloadIconWidget extends StatefulWidget {
  final String downloadedPercentage;
  final bool isDownloaded;
  DownloadIconWidget(
      {required this.downloadedPercentage, required this.isDownloaded});

  @override
  State<DownloadIconWidget> createState() => _DownloadIconWidgetState();
}

class _DownloadIconWidgetState extends State<DownloadIconWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.isDownloaded == true
        ? Container()
        : Container(
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(width: 1, color: AppColors.primaryColor)),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: widget.downloadedPercentage == '-1'
                  ? Icon(
                      Icons.download,
                      size: 35,
                      color: AppColors.primaryColor,
                    )
                  : Text(
                      widget.downloadedPercentage,
                      style: TextStyle(
                          color: AppColors.primaryColor, fontSize: 15),
                    ),
            ),
          );
  }
}
