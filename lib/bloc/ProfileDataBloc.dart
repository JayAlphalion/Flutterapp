import 'dart:async';
import 'dart:io';

import 'package:alpha_app/repository/AuthRepository.dart';
import 'package:alpha_app/repository/LoadRequestAcceptRejectRepository.dart';
import 'package:alpha_app/repository/ProfileDataRepository.dart';

import '../networking/Response.dart';

class ProfileDataBloc {
  late ProfileDataRepository profileDataRepository;
  late StreamController<dynamic> streamController;
  
  
  StreamSink<dynamic> get getProfileDataSink =>
      streamController.sink;

  Stream<dynamic> get getProfileDataStream =>
      streamController.stream;

 
  ProfileDataBloc() {
    streamController = StreamController<dynamic>();
     profileDataRepository = ProfileDataRepository();
  }

  callGetProfileData() async {
    try {
      dynamic chuckCats = await profileDataRepository.callGetProfileData();
      getProfileDataSink.add(chuckCats);
    } catch (e) {
      getProfileDataSink.add(e.toString());
      print(e);
    }
  }

  
  dispose() {
    streamController.close();
  }
}
