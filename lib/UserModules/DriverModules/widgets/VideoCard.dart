// @dart=2.9
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoCard extends StatefulWidget {
  final String url;
  VideoCard({this.url});
  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  VideoPlayerController _controller;
  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        if (mounted) {
          setState(() {});
        }
      });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 1, color: Colors.black38),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 0,
              child: Container(
                  width: 95, height: 95, child: VideoPlayer(_controller))),
          Icon(
            Icons.play_arrow,
            size: 25,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
