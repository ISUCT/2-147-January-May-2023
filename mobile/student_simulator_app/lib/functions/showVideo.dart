import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

import 'BasicOverlayWidget.dart';
import 'fullScreenVideo.dart';

class showVideo extends StatefulWidget {
  final videoURL;
  final videoFile;
  const showVideo({this.videoURL, this.videoFile, super.key});

  @override
  State<showVideo> createState() => _showVideoState();
}

class _showVideoState extends State<showVideo> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    if (widget.videoFile != null) {
      controller = VideoPlayerController.file(widget.videoFile)
        ..addListener(() => setState(() {}))
        ..setLooping(true)
        ..initialize().then((_) => controller.play());
    } else {
      controller = VideoPlayerController.network(widget.videoURL)
        ..addListener(() => setState(() {}))
        ..setLooping(true)
        ..initialize().then((_) => controller.play());
    }
    // _initializeVideoPlayerFuture = controller.initialize();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  share(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    if (widget.videoFile == null && widget.videoURL != null) {
      final uri = Uri.parse(widget.videoURL);
      final res = await http.get(uri);
      final bytes = res.bodyBytes;
      final temp = await getTemporaryDirectory();
      final path = '${temp.path}/video.mp4';
      File(path).writeAsBytesSync(bytes);
      Share.shareXFiles([XFile(path)]);
    } else {
      Share.shareXFiles([XFile(widget.videoFile)]);
    }
    sharePositionOrigin:
    box!.localToGlobal(Offset.zero) & box.size;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
          appBar: AppBar(
            backwardsCompatibility: true,
            actions: [
              IconButton(
                  onPressed: () => share(context),
                  icon: const Icon(
                    Icons.share,
                  ))
            ],
            backgroundColor: Colors.transparent,
          ),
        backgroundColor: Colors.transparent,
        body: Container(
          height: size.height,
          width: size.width,
          child: InteractiveViewer(
            child: controller.value.isInitialized
                ? Center(
                    child: AspectRatio(
                        aspectRatio: controller.value.aspectRatio,
                        child: buildVideo()),
                  )
                : Center(
                    child: Container(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  )),
          ),
        ),
      ),
    );
  }

  Widget buildVideo() => Stack(
        children: [
          buildVideoPlayer(),
          Positioned.fill(child: BasicOverlayWidget(controller: controller)),
        ],
      );
  Widget buildVideoPlayer() => Center(
        child: VideoPlayer(controller),
      );
}
