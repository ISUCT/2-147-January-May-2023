import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import 'fullScreenVideo.dart';

class BasicOverlayWidget extends StatefulWidget {
  final controller;
  const BasicOverlayWidget({required this.controller, super.key});

  @override
  State<BasicOverlayWidget> createState() => _BasicOverlayWidgetState();
}

class _BasicOverlayWidgetState extends State<BasicOverlayWidget> {
  bool tap = false;
  @override
  void initState() {
    super.initState();
    tap = false;
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => widget.controller.value.isPlaying
          ? widget.controller.pause()
          : widget.controller.play(),
      child: Stack(
        children: [
          buildPlay(),
          fullScreenVideo(),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: buildIndicator(),
          )
        ],
      ),
    );
  }

  Widget buildIndicator() => VideoProgressIndicator(
        widget.controller,
        allowScrubbing: true,
        colors: VideoProgressColors(playedColor: Colors.blue),
      );
  Widget buildPlay() => widget.controller.value.isPlaying
      ? Container()
      : Container(
          alignment: Alignment.center,
          color: Colors.black26,
          child: Icon(
            Icons.play_arrow,
            color: Colors.white,
            size: 80,
          ));
  Widget fullScreenVideo() => Align(
        alignment: Alignment.bottomRight,
        child: IconButton(
          icon: Icon(Icons.fullscreen, color: Colors.white),
          onPressed: () {
            if (tap == false) {
              tap = true;
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.landscapeRight,
                DeviceOrientation.landscapeLeft,
              ]);
            } else {
              tap = false;
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
                DeviceOrientation.portraitDown,
              ]);
            }
          },
        ),
      );
}
