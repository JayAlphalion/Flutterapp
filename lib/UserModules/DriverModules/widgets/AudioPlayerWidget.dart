import 'dart:developer';
import 'dart:io';

import 'package:alpha_app/Universals/utils/AppColors.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AudioPlayerWidget extends StatefulWidget {
  final List<File> audioFiles;
  final int index;
  AudioPlayerWidget({required this.audioFiles, required this.index});
  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final _player = AudioPlayer();
  bool isPlaying = false;

  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    setupPlayerListener();
    setAudio(widget.audioFiles[widget.index]);
    // TODO: implement initState
    super.initState();
  }

//players setup.

  void setupPlayerListener() {
    _player.onPlayerStateChanged.listen((state) {
      isPlaying = state == PlayerState.playing;
      changeState();
    });

    _player.onDurationChanged.listen((event) {
      duration = event;
      changeState();
    });

    _player.onPositionChanged.listen((event) {
      position = event;
      changeState();
    });
  }

  void changeState() {
    setState(() {});
  }

  Future setAudio(File path) async {
    try {
      _player.setReleaseMode(ReleaseMode.stop);
      final file = path;
      _player.setSourceDeviceFile(file.path);
    } catch (e) {
      // debugger();
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: Colors.black26),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
                onTap: () {
                  if (isPlaying == true) {
                    _player.pause();
                  } else {
                    _player.resume();
                  }
                },
                child: Icon(
                  isPlaying == true ? Icons.pause : Icons.play_arrow,
                  size: 35,
                  color: AppColors.primaryColor,
                )),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Row(
                        children: [
                          Slider(
                            
                              min: 0,
                              max: duration.inSeconds.toDouble(),
                              value: position.inSeconds.toDouble(),
                              onChanged: (value) async {
                                final position =
                                    Duration(seconds: value.toInt());
                                await _player.seek(position);
                                await _player.resume();
                              }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(position.inSeconds.toString()+' : '),
                              Text((duration - position).inSeconds.toString()+' Sec'),
                            ],
                          )
                        ],
                      )
                   
                      
                      )
          ],
        ),
      ),
    );
  }
}
