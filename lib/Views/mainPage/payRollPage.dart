import 'dart:async';

import 'package:alpha_app/Dialogs/DispachRequestDialog.dart';
import 'package:alpha_app/utils/AppColors.dart';
import 'package:alpha_app/widgets/drawer.dart';
import 'package:flutter/material.dart';

class PayrollPage extends StatefulWidget {
  const PayrollPage({Key? key}) : super(key: key);

  @override
  State<PayrollPage> createState() => _PayrollPageState();
}

class _PayrollPageState extends State<PayrollPage> {

// Timer? time;
// void callAlertDialog(){
//  time= Timer(Duration(seconds: 3), (){
//   time!.cancel();
//  showDialog<String>(
//         context: context,
//         //barrierColor: Colors.white.withOpacity(0),
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return DispachRequestDialog(
           
            
//           );
//         });
//   });
  
// }


@override
  void initState() {
    // callAlertDialog();
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          title: const Text('Payroll'),
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.more_vert),
            ),
          ],
          backgroundColor: AppColors.primaryColor
        ),
        body: Container());
  }
}
