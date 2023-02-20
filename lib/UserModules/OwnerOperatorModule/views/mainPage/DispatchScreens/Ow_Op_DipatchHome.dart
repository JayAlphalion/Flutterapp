import 'package:alpha_app/UserModules/OwnerOperatorModule/views/DrawersPage/Ow_Op_drawer.dart';
import 'package:alpha_app/Universals/utils/AppColors.dart';
import 'package:flutter/material.dart';

import 'DispatchHomeScreen.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

class OwOpDispatchHomePage extends StatefulWidget {
  const OwOpDispatchHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<OwOpDispatchHomePage> createState() => _OwOpDispatchHomePageState();
}

class _OwOpDispatchHomePageState extends State<OwOpDispatchHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: OwOp_Drawer(),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.primaryColor,
        // leading: Container(),
        centerTitle: true,
        title: Text(
          "Dispatch",
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () {},
              child: Icon(
                Icons.refresh,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 00),
                _buildTruckNameContainer('Truck A'),
                _buildTruckNameContainer('Truck B'),
                _buildTruckNameContainer('Truck C'),
                _buildTruckNameContainer('Truck D'),
                _buildTruckNameContainer('Truck E'),
              ],
            )),
      ),
    );
  }

  Widget _buildTruckNameContainer(String truckName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const OwOpDriverDispatchHome()));
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(width: 2, color: AppColors.primaryColor)),
        title: Text(
          truckName,
          style: const TextStyle(
              color: AppColors.primaryColor, fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
