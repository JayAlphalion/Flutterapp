import 'dart:async';
import 'dart:developer';

import 'package:alpha_app/networking/SocketHelper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationTrackerHelper extends GetxController {
  var lattitude = ''.obs;
  var longtitude = ''.obs;
  var locationPermission = false.obs;
  Timer? timer;

  void updateLocation({required String lat, required String long}) {
    lattitude.value = lat;
    longtitude.value = long;
  }

  Future<void> sentLocationToTheServer() async {
    SocketService socketHelper = new SocketService();
    var location = await getUserCurrentLocation();
    
      updateLocation(
          lat: location.latitude.toString(),
          long: location.longitude.toString());
      SocketService()
          .sendDriverLocation(lat: lattitude.value, long: longtitude.value);
    
  }

// created method for getting user current location
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value) {
      //print(value);
      if (value == LocationPermission.always ||
          value == LocationPermission.whileInUse) {
        locationPermission.value = true;
        //fetchLocation();
      }
    }).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<Position?> fetchLocation() async {
    if (locationPermission.value==true) {
     
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
     
      
    } else {
      print("access is denied");
    }
  }

  void updateCycleOfLocation() async {
    await sentLocationToTheServer();

    timer = Timer.periodic(const Duration(seconds: 1), (timer)async {
     var location=await fetchLocation();
      updateLocation(
          lat: location!.latitude.toString(),
          long: location.longitude.toString());
     if (lattitude.value == location.latitude.toString() &&
        longtitude.value == location.longitude.toString()) {
      print("location not changed");
      /**
       * i'll comment it
       */
        // SocketService()
        //   .sendDriverLocation(lat: lattitude.value, long: longtitude.value);
   
    } else {
    
      SocketService()
          .sendDriverLocation(lat: lattitude.value, long: longtitude.value);
    }
    });
  }

  @override
  void onClose() {
    timer?.cancel();
    // TODO: implement onClose
    super.onClose();
  }
}
