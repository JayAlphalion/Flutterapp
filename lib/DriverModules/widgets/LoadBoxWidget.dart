import 'package:alpha_app/DriverModules/Model/LoadDataModel.dart';
import 'package:alpha_app/Universals/utils/AppColors.dart';
import 'package:flutter/material.dart';

class LoadBoxWidget extends StatefulWidget {
  final LoadModel loadModel;
  final bool isSelected;
  LoadBoxWidget({required this.loadModel, required this.isSelected});

  @override
  State<LoadBoxWidget> createState() => _LoadBoxWidgetState();
}

class _LoadBoxWidgetState extends State<LoadBoxWidget> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: widget.isSelected == true
                  ? AppColors.primaryColor
                  : Colors.black26,
            ),
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.loadModel.pickUpDate,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Load No. ' + widget.loadModel.loadNumber,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Icon(
                Icons.navigate_next_rounded,
                size: 20,
                color: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }
}
