import 'dart:async';
import 'dart:developer';

import 'package:alpha_app/UserModules/OwnerOperatorModule/views/DrawersPage/Ow_Op_drawer.dart';
import 'package:alpha_app/Universals/utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OwOpLocation extends StatefulWidget {
  const OwOpLocation({Key? key}) : super(key: key);

  @override
  _OwOpLocationState createState() => _OwOpLocationState();
}

class _OwOpLocationState extends State<OwOpLocation> {
  Completer<GoogleMapController> _controller = Completer();
  Position? _currentPosition;

  Map<MarkerId, Marker> markersMap = <MarkerId, Marker>{};

// on below line we have specified camera position
  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(47.391530, -122.292900),
    zoom: 14,
  );

// on below line we have creat ed the list of markers
  final List<Marker> _markers = <Marker>[
    const Marker(
        markerId: MarkerId('1'),
        position: LatLng(20.42796133580664, 75.885749655962),
        infoWindow: InfoWindow(
          title: 'My Position',
        )),
  ];

// created method for getting user current location
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  _addMarker(LatLng positionCoordinates) {
    var markerIdVal = positionCoordinates.toString();
    final MarkerId markerId = MarkerId(markerIdVal);

    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: positionCoordinates,
      infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
    );

    setState(() {
      // adding a new marker to map
      markersMap[markerId] = marker;
    });
  }

  @override
  void initState() {
    findCurrentLocation();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: OwOp_Drawer(),
      appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          title: const Text('Location'),
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.more_vert),
            ),
          ],
          backgroundColor: AppColors.primaryColor),
      body: Container(
        child: SafeArea(
          // on below line creating google maps
          child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: _kGoogle,
                mapType: MapType.normal,
                myLocationEnabled: true,
                markers: Set<Marker>.of(markersMap.values),
                compassEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   children: [
              //     ElevatedButton(
              //       onPressed: () async {
              //         // getUserCurrentLocation().then((value) async {
              //         //   print("${value.latitude} ${value.longitude}");

              //         //   // marker added for current users location
              //         //   _markers.add(Marker(
              //         //     markerId: const MarkerId("2"),
              //         //     position: LatLng(value.latitude, value.longitude),
              //         //     infoWindow: const InfoWindow(
              //         //       title: 'My Current Location',
              //         //     ),
              //         //   ));

              //         //   // specified current users location
              //         //   CameraPosition cameraPosition = CameraPosition(
              //         //     target: LatLng(value.latitude, value.longitude),
              //         //     zoom: 17,
              //         //   );

              //         //   final GoogleMapController controller =
              //         //       await _controller.future;
              //         //   controller.animateCamera(
              //         //       CameraUpdate.newCameraPosition(cameraPosition));
              //         //   setState(() {});
              //         // });
              //         findCurrentLocation();
              //       },
              //       child: const Text("Find Your Current Location"),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
      // on pressing floating action button the camera will take to user current location
    );
  }

  void findCurrentLocation() {
    getUserCurrentLocation().then((value) async {
      // debugger();
      // print(value);
      print("${value.latitude} ${value.longitude}");

      // marker added for current users location
      // _markers.add(Marker(
      //   markerId: const MarkerId("2"),
      //   position: LatLng(value.latitude, value.longitude),
      //   infoWindow: const InfoWindow(
      //     title: 'My Current Location',
      //   ),
      // ));

      // specified current users location
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 17,
      );

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
    _addMarker(LatLng(40.84733691743749, -121.73924350692003));
    _addMarker(LatLng(40.68924626079369, -123.89256387641429));
    _addMarker(LatLng(39.34338709107285, -120.74397561631403));
    _addMarker(LatLng(42.40750457998922, -120.84935090524127));
    _addMarker(LatLng(38.58017304498502, -121.51988506067906));
  }
}
