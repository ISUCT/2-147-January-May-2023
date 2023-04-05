// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// import 'package:shimmer/shimmer.dart';

class NewsImage extends StatefulWidget {
  const NewsImage(
      {required this.name,
      required this.desc,
      required this.image,
      required this.time,
      required this.route,
      super.key});
  final String? name;
  final String? desc;
  final String? image;
  final DateTime? time;
  final Widget? route;

  static final customCachedImage = CacheManager(Config(
    'customCacheKey1',
    stalePeriod: const Duration(days: 15),
    maxNrOfCacheObjects: 10,
  ));

  @override
  State<NewsImage> createState() => _NewsImageState();
}

class _NewsImageState extends State<NewsImage> {
  late CachedVideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.image!.contains('mp4')) {
      _controller = CachedVideoPlayerController.network(widget.image!)
        ..initialize().then((value) {
          setState(() {
            _controller.seekTo(const Duration(seconds: 50));
          });
        });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return 
    widget.route != null ?
    InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => widget.route!));
      },
      child: widget.image!.contains('mp4')
          ? CachedVideoPlayer(_controller)
          : CachedNetworkImage(
              cacheManager: NewsImage.customCachedImage,
              key: UniqueKey(),
              imageUrl: widget.image!,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Theme.of(context).backgroundColor,
              ),
              errorWidget: (context, url, error) => Container(
                color: Theme.of(context).backgroundColor,
                alignment: Alignment.center,
                child: const Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              ),
            ),
    ): SizedBox()
    ;
  }
}
