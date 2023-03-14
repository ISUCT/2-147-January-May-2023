import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:student_simulator/news/Widgets/newsVideo.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
// import 'package:shimmer/shimmer.dart';
import '../../components/time.dart';
import '../detalNewPage.dart';
import 'CustomListTile.dart';

class News extends StatefulWidget {
  const News(
      {required this.id,
      required this.name,
      required this.desc,
      required this.image,
      required this.time,
      super.key});
  final int? id;
  final String? name;
  final String? desc;
  final String? image;
  final DateTime time;

  static final customCacheManager = CacheManager(
    Config(
      'customCacheKey',
      stalePeriod: const Duration(days: 15),
      maxNrOfCacheObjects: 100,
    ),
  );

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  late CachedVideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.image != null && widget.image!.contains('mp4')) {
      _controller = CachedVideoPlayerController.network(widget.image!)
        ..initialize().then((value) {
          setState(() {
            _controller.seekTo(Duration(seconds: 50));
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
    Size size = MediaQuery.of(context).size;
    return CustomListTile(
        route: DetalNewPage(
          id: widget.id!,
          name: widget.name!,
          desc: widget.desc!,
          image: widget.image,
          time: widget.time,
        ),
        // leading: Image.network(image),
        title: SizedBox(
          width: widget.image != null ? size.width - 180 : null,
          child: Text(
            widget.name!,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: Text(
          timeToStr(widget.time),
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        trailing: widget.image != null &&
                (widget.image!.contains('png') || widget.image!.contains('jpg'))
            ? CachedNetworkImage(
                height: 100,
                width: 150,
                cacheManager: News.customCacheManager,
                key: UniqueKey(),
                imageUrl: widget.image!,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[400],
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[400],
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
              )
            : widget.image != null && widget.image!.contains('mp4')
                ? Container(
                    color: Colors.grey[400],
                    height: 100,
                    width: 150,
                    child: CachedVideoPlayer(_controller))
                : const SizedBox()
        // subtitle: Text(desc!),
        );
  }
}
