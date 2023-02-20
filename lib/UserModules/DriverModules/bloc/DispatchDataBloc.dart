import 'dart:async';
import 'dart:io';

import 'package:alpha_app/AuthModules/AuthRepository.dart';
import 'package:alpha_app/UserModules/DriverModules/repository/DispatchDataRepository.dart';

import '../../../Universals/networking/Response.dart';

class DispatchDataBloc {
  late DispatchDataRepository dispatchDataRepository;
  late StreamController<dynamic> streamController;
late StreamController<dynamic> pastLoadController;
late StreamController<dynamic> upcomingLoadRequestController; 
  StreamSink<dynamic> get currentLoadDispatchDataSink =>
      streamController.sink;

  Stream<dynamic> get currentLoadDispatchDataStream =>
      streamController.stream;

  StreamSink<dynamic> get pastLoadControllerDataSink =>
      pastLoadController.sink;

  Stream<dynamic> get pastLoadControllerDataStream =>
      pastLoadController.stream;

  StreamSink<dynamic> get upcomingLoadControllerDataSink =>
      upcomingLoadRequestController.sink;

  Stream<dynamic> get upcomingLoadControllerDataStream =>
      upcomingLoadRequestController.stream;
 
  DispatchDataBloc() {
    streamController = StreamController<dynamic>();
    pastLoadController=StreamController<dynamic>();
     dispatchDataRepository = DispatchDataRepository();
     upcomingLoadRequestController=StreamController<dynamic>();
  }

  callGetCurrentDispatchApi() async {
    try {
      dynamic chuckCats = await dispatchDataRepository.callGetCurrentLoadDispatch();
      currentLoadDispatchDataSink.add(chuckCats);
    } catch (e) {
      currentLoadDispatchDataSink.add(e.toString());
      print(e);
    }
  }

callGetPastLoadDispatchApi() async {
    try {
      dynamic chuckCats = await dispatchDataRepository.callGetPastLoadDispatch();
      pastLoadControllerDataSink.add(chuckCats);
    } catch (e) {
      pastLoadControllerDataSink.add(e.toString());
      print(e);
    }
  }

callGetUpcommingLoadDispatchApi() async {
    try {
      dynamic chuckCats = await dispatchDataRepository.callGetUpcommingLoadRequestApi();
      upcomingLoadControllerDataSink.add(chuckCats);
    } catch (e) {
      upcomingLoadControllerDataSink.add(e.toString());
      print(e);
    }
  }
  
  dispose() {
    streamController.close();
  }
}
