import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class NewsVideo extends StatefulWidget {
  const NewsVideo(
      {required this.name,
      required this.desc,
      required this.video,
      required this.time,
      required this.route,
      super.key});
  final String? name;
  final String? desc;
  final String video;
  final DateTime time;
  final Widget route;

  @override
  State<NewsVideo> createState() => _NewsVideoState();
}

class _NewsVideoState extends State<NewsVideo> {
  late CachedVideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = CachedVideoPlayerController.network(widget.video)
      ..initialize().then((value) {
        setState(() {
          _controller.seekTo(Duration(seconds: 50));
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? InkWell(
            onTap: () {
              // setState(() {
              //   _controller.value.isPlaying
              //       ? _controller.pause()
              //       : _controller.play();
              // });
            },
            child: CachedVideoPlayer(_controller),
            // child: Stack(
            //   children: [
            // Positioned(
            //   left: 0,
            //   right: 0,
            //   bottom: 0,
            //   top: 0,
            //   child: Center(
            //     child: Icon(
            //       _controller.value.isPlaying
            //           ? Icons.pause
            //           : Icons.play_arrow,
            //       color: Colors.white,
            //     ),
            //   ),
            // )
            // ],
            // ),
          )
        : Container(
            color: Colors.grey[400],
          );
  }
}
// floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             setState(() {
//               _controller.value.isPlaying
//                   ? _controller.pause()
//                   : _controller.play();
//             });
//           },
//           child: Icon(
//             _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//           ),
//         ),