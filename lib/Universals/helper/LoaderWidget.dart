


import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';



class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({required this.loadingMessage});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: SimpleDialog(
          key: key,
          backgroundColor: Colors.transparent,
          children: const [Center(child: CircularProgressIndicator())],
        ));
  }
}

class NetworkDialog {
  static Future<void> showLoadingDialog(
    
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
       // barrierColor: Colors.grey.withOpacity(0.5),
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                
                key: key,
                // shape: ShapeBorder,
              //  shape: BoxShape.circle,
                backgroundColor: Colors.white,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    //  SizedBox(height: 20,),
                      Container(
                        height: 50,
                        width: 50,
                        child: Center(
                          child: CircularProgressIndicator(
                            
                            color: Colors.blue,
                          ),
                        ),
                      ),

                      SizedBox(height: 10,),
                      Text("Please Wait...",
                      style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                     //  SizedBox(height: 20,),
                    ],
                  )
                ],
              ));
        });
  }
}