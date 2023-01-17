import 'dart:async';
import 'dart:io';

import 'package:alpha_app/repository/AuthRepository.dart';
import 'package:alpha_app/repository/ClaimsRepository.dart';

import '../networking/Response.dart';

class ClaimDataBloc {
  late ClaimsRepository claimsRepository;
  late StreamController<dynamic> streamController;

  
  StreamSink<dynamic> get addClaimDataSink =>
      streamController.sink;

  Stream<dynamic> get addClaimDataStream =>
      streamController.stream;

 
  ClaimDataBloc() {
    streamController = StreamController<dynamic>();
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

  
  dispose() {
    streamController.close();
  }
}
