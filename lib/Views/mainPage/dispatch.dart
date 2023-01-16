// import 'package:alpha_app/Dialogs/DispachRequestDialog.dart';
// import 'package:alpha_app/utils/AppColors.dart';
// import 'package:alpha_app/widgets/dwarer.dart';
// import 'package:flutter/material.dart';

// class DispatchPage extends StatefulWidget {
//   const DispatchPage({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<DispatchPage> createState() => _DispatchPageState();
// }      

// class _DispatchPageState extends State<DispatchPage> {



// void callDispachRequestDialogApi(){
//    showDialog<String>(
//         context: context,
//         //barrierColor: Colors.white.withOpacity(0),
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return DispachRequestDialog(
            
//           );
//         });
// }








//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: MyDrawer(),
//       appBar: AppBar(
//         leading: Builder(
//           builder: (context) => IconButton(
//             icon: new Icon(Icons.menu),
//             onPressed: () => Scaffold.of(context).openDrawer(),
//           ),
//         ),
//         title: const Text('Dispatch'),
//         actions:  [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16),
//             child: InkWell(
//               onTap: (){
// callDispachRequestDialogApi();
//               },
//               child: Icon(Icons.more_vert)),
//           ),
//         ],
//         backgroundColor: AppColors.primaryColor
//       ),
//       body: Column(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Card(
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const Text(
//                       "Walmart DC",
//                       style: TextStyle(
//                         fontSize: 26,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black, //font color
//                       ),
//                     ),
//                     const Text(
//                       "Load No: 9180",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xff1C5AA3), //font color
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(5),
//                           alignment: Alignment.center,
//                           decoration: const BoxDecoration(
//                             color: Colors.orange,
//                             // Set border width
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(10.0)),
//                           ),
//                           child: const Text(
//                             "intransit",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black, //font color
//                             ),
//                           ),
//                         ),
//                         Container(
//                           padding: const EdgeInsets.all(5),
//                           alignment: Alignment.center,
//                           decoration: const BoxDecoration(
//                             color: Colors.yellow,
//                             // Set border width
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(10.0)),
//                           ),
//                           child: const Text(
//                             "ETA- 12:09 AM",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black, //font color
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       children: const [
//                         Text(
//                           "Shipment Time: 01:30 AM",
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Color(0xff1C5AA3), //font color
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: const [
//                         Text(
//                           "Shipment Location: ",
//                           style: TextStyle(
//                             fontSize: 16,

//                             color: Colors.black, //font color
//                           ),
//                         ),
//                         Text(
//                           "California,lockmark,\nStreet 50",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black, //font color
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     Row(
//                       children: const [
//                         Text(
//                           "Delivery Time: 01:45 AM ",
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: Color(0xff1C5AA3), //font color
//                           ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: const [
//                         Text(
//                           "Delivery Location: ",
//                           style: TextStyle(
//                             fontSize: 16,

//                             color: Colors.black, //font color
//                           ),
//                         ),
//                         Text(
//                           "California,lockmark,\nStreet 50",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black, //font color
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     const Text(
//                       "Commodity: Liquor",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black, //font color
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     const Text(
//                       "Pick Type: Live Load",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black, //font color
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     const Text(
//                       "Delivery Type: Live UnLoad",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black, //font color
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
