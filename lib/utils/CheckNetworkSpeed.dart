import 'dart:io';

// import 'package:flutter_architecture/widgets/ToastWidget.dart';
// import 'StringUtils.dart';

/**
 * This function will check your internet speed.
 */
Future<bool> checkNetworkSpeed({bool showPopUp = true}) async{
  try{
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty){
      return true;
    }
    else{
      return false;
    }
  }
  on SocketException catch (_) {
    if(showPopUp){
      // showErrorToast(AppLocalizations().getText('No Internet Connection'));
    }
    return false;
  }
}