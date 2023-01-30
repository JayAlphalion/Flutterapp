import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class AlertDialogBox extends StatefulWidget {
  final String title;
  final Function onReject;
  final Function onAccept;
  AlertDialogBox({required this.title, required this.onReject, required this.onAccept});

  @override
  State<AlertDialogBox> createState() => _AlertDialogBoxState();
}

class _AlertDialogBoxState extends State<AlertDialogBox> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: SimpleDialog(
        insetPadding: EdgeInsets.all(15),
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        children: [
          Container(
            width: Get.width / 1,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding:  EdgeInsets.only(left: 25,right: 25),
              child: Column(
                // mainAxisAlignment: m,
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                 
                   Padding(
                    padding:  EdgeInsets.only(
                        top: 30),
                    child: Text(
                        "Are You Sure you want to "+widget.title+" It?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500)),
                  ),
                  
 const SizedBox(
                      height: 30,
                    ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     InkWell(
  onTap: (){
    
    widget.onAccept();
    
  },
   child:
                         Container(
                          height: 45,
                          width: 120,
                          decoration: BoxDecoration(
                            color:  Color(0xff1C5AA3),
                            borderRadius: BorderRadius.circular(8)
                          ),
                          alignment: Alignment.center,
                          child: Text("Yes",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white, //font color
                            ),
                          ),
                        ),
                      ),
 InkWell(
  onTap: (){
    widget.onReject();
  },
   child: Container(
                          height: 45,
                          width: 120,
                          decoration: BoxDecoration(
                            color:  Colors.red,
                            borderRadius: BorderRadius.circular(8)
                          ),
                          alignment: Alignment.center,
                          child: Text("No",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white, //font color
                            ),
                          ),
                        ),
 ),



                    ],
                  ),
 const SizedBox(
                      height: 35,
                    ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
