import 'dart:async';
import 'dart:io';

import 'package:alpha_app/AuthModules/AuthRepository.dart';
import 'package:alpha_app/UserModules/DriverModules/repository/ClaimsRepository.dart';

import '../../../Universals/networking/Response.dart';

class ClaimDataBloc {
  late ClaimsRepository claimsRepository;
  late StreamController<dynamic> streamController;
  late StreamController<dynamic> previousClaimStreamController;
  
  StreamSink<dynamic> get addClaimDataSink =>
      streamController.sink;

  Stream<dynamic> get addClaimDataStream =>
      streamController.stream;

   StreamSink<dynamic> get previousClaimDataSink =>
      previousClaimStreamController.sink;

  Stream<dynamic> get previousClaimDataStream =>
      previousClaimStreamController.stream;
  ClaimDataBloc() {
    streamController = StreamController<dynamic>();
    previousClaimStreamController=StreamController<dynamic>();
     claimsRepository = ClaimsRepository();
  }

  callAddClaims(Map parameter) async {
    try {
      dynamic chuckCats = await claimsRepository.callAddClaimsApi(parameter);
      addClaimDataSink.add(chuckCats);
    } catch (e) {
      addClaimDataSink.add(e.toString());
      print(e);
    }
  }


 callGetPreviousClaim(Map parameter) async {
    try {
      dynamic chuckCats = await claimsRepository.getPreviousClaimData(parameter);
      previousClaimDataSink.add(chuckCats);
    } catch (e) {
      previousClaimDataSink.add(e.toString());
      print(e);
    }
  }
  
  dispose() {
    streamController.close();
  }
}
