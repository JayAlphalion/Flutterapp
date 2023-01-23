//  @dart=2.9
import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:alpha_app/GetXController/VideoRecordingController.dart';
import 'package:alpha_app/utils/AppColors.dart';
import 'package:alpha_app/utils/Constants.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:video_player/video_player.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RecordVideoPage extends StatefulWidget {
  @override
  _RecordVideoPageState createState() {
    return _RecordVideoPageState();
  }
}

class _RecordVideoPageState extends State<RecordVideoPage> {
  CameraController controller;
  String videoPath;

  List<CameraDescription> cameras;
  int selectedCameraIdx;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int percent = 0;
  Timer timer;
  File videFile;

  String recordingState = Constant.NonStart;
  @override
  void initState() {
    super.initState();

    // Get the listonNewCameraSelected of available cameras.
    // Then set the first camera as selected.
    availableCameras().then((availableCameras) {
      cameras = availableCameras;

      if (cameras.length > 0) {
        setState(() {
          selectedCameraIdx = 0;
        });
        if (controller != null) {
          controller.dispose();
        }
        _onCameraSwitched(cameras[selectedCameraIdx]).then((void v) {});
      }
    }).catchError((err) {
      print('Error: $err.code\nError Message: $err.message');
    });
  }

  void startRecording() {
    _startVideoRecording().then((value) {
      startTimer();
    });
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (time) {
      if (percent == 20) {
        timer.cancel();
        completeRecording();
      } else {
        if(mounted){
          setState(() {
          percent++;
        });
        }
      }
    });
  }

  void pauseRecording() {
    setState(() {
      recordingState = Constant.Pause;
    });
    _pushVideoRecording().then((value) {
      timer.cancel();
    });
  }

  void completeRecording() {
    _completeRecording().then((value) {
      if (value != null) {
        Navigator.pop(context, File(value.path));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // appBar: AppBar(
      //   title: const Text('Camera example'),
      // ),
      body: Container(
        width: Get.width / 1,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(height: Get.height / 1, child: _cameraPreviewWidget()),
            Positioned(
              bottom: 70,
              left: 30,
              child: InkWell(
                  onTap: () {
                    _onSwitchCamera();
                  },
                  child: const Icon(
                    Icons.flip_camera_ios_rounded,
                    size: 45,
                    color: AppColors.primaryColor,
                  )),
            ),
             Positioned(
              bottom: 70,
              right: 30,
              child: InkWell(
                  onTap: () {
                    completeRecording();
                  },
                  child: const Icon(
                    Icons.done,
                    size: 45,
                    color: AppColors.primaryColor,
                  )),
            ),
            Positioned(
                bottom: 30,
                child: Row(
                  children: [
                    CircularPercentIndicator(
                      radius: 60.0,
                      lineWidth: 10.0,
                      percent: percent / 20,
                      center: InkWell(
                        onTap: recordingState == Constant.NonStart
                            ? () {
                                startRecording();
                              }
                            : recordingState == Constant.Pause
                                ? () {
                                    _resumeRecroding();
                                  }
                                : recordingState == Constant.Recording
                                    ? () {
                                        pauseRecording();
                                      }
                                    : () {
                                        debugger();
                                        print(recordingState);
                                        // newController.startRecording();
                                      },
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.blue[100], shape: BoxShape.circle),
                          alignment: Alignment.center,
                          child: Icon(
                            recordingState == Constant.Pause
                                ? Icons.pause
                                : Icons.videocam,
                            color: AppColors.primaryColor,
                            size: 45,
                          ),
                        ),
                      ),
                      progressColor: Colors.red,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  IconData _getCameraLensIcon(CameraLensDirection direction) {
    switch (direction) {
      case CameraLensDirection.back:
        return Icons.camera_rear;
      case CameraLensDirection.front:
        return Icons.camera_front;
      case CameraLensDirection.external:
        return Icons.camera;
      default:
        return Icons.device_unknown;
    }
  }

  // Display 'Loading' text when the camera is still loading.
  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'Loading',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w900,
        ),
      );
    }

    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: CameraPreview(controller),
    );
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  Future<void> _onCameraSwitched(CameraDescription cameraDescription) async {
    controller = CameraController(cameraDescription, ResolutionPreset.high);

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }

      if (controller.value.hasError) {
        Fluttertoast.showToast(
            msg: 'Camera error ${controller.value.errorDescription}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            // timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white);
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  void _onSwitchCamera() {
    selectedCameraIdx =
        selectedCameraIdx < cameras.length - 1 ? selectedCameraIdx + 1 : 0;
    CameraDescription selectedCamera = cameras[selectedCameraIdx];

    _onCameraSwitched(selectedCamera);

    setState(() {
      selectedCameraIdx = selectedCameraIdx;
    });
  }

  Future<String> _startVideoRecording() async {
    if (!controller.value.isInitialized) {
      Fluttertoast.showToast(
          msg: 'Please wait',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          // timeInSecForIos: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white);

      return null;
    }
    setState(() {
      recordingState = Constant.Recording;
    });

    // Do nothing if a recording is on progress
    if (controller.value.isRecordingVideo) {
      return null;
    }

    final Directory appDirectory = await getApplicationDocumentsDirectory();
    final String videoDirectory = '${appDirectory.path}/Videos';
    await Directory(videoDirectory).create(recursive: true);
    final String currentTime = DateTime.now().millisecondsSinceEpoch.toString();
    final String filePath = '$videoDirectory/${currentTime}.mp4';

    try {
      await controller.startVideoRecording();
      videoPath = filePath;
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }

    return filePath;
  }

  Future<void> _pushVideoRecording() async {
    if (!controller.value.isRecordingVideo) {
      return null;
    }

    try {
      await controller.pauseVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  Future<void> _resumeRecroding() async {
    if (!controller.value.isRecordingVideo) {
      return null;
    }
    setState(() {
      recordingState = Constant.Recording;
    });
    startTimer();

    try {
      await controller.resumeVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  Future<XFile> _completeRecording() async {
    if (!controller.value.isRecordingVideo) {
      return null;
    }

    try {
      XFile video = await controller.stopVideoRecording();
      return video;
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  void _showCameraException(CameraException e) {
    String errorText = 'Error: ${e.code}\nError Message: ${e.description}';
    print(errorText);

    Fluttertoast.showToast(
        msg: 'Error: ${e.code}\n${e.description}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        // timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }
}
