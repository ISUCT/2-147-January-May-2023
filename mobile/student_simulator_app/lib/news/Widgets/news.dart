import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:video_player/video_player.dart';
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
  final int id;
  final String name;
  final String desc;
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
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.image != null && widget.image!.contains('mp4')) {
      _controller = VideoPlayerController.network(widget.image!)
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
    if (widget.image != null && widget.image!.contains('mp4')) {
    _controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CustomListTile(
        route: DetalNewPage(
          id: widget.id,
          name: widget.name,
          desc: widget.desc,
          image: widget.image,
          time: widget.time,
        ),
        // leading: Image.network(image),
        title: SizedBox(
          width: widget.image != null ? size.width - 200 : null,
          child: Text(
            widget.name,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge!.backgroundColor),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: Row(
          children: [
            Icon(
              EvaIcons.clock_outline,
              size: 20,
              color: Theme.of(context).textTheme.bodySmall!.backgroundColor,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              timeToStr(widget.time),
              style: TextStyle(
                  fontSize: 16,
                  color:
                      Theme.of(context).textTheme.bodySmall!.backgroundColor),
            ),
          ],
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
              )
            : widget.image != null && widget.image!.contains('mp4')
                ? Stack(children: [
                    Container(
                        color: Theme.of(context).backgroundColor,
                        height: 100,
                        width: 150,
                        child: VideoPlayer(_controller)),
                    Positioned(
                        bottom: 0, left: 3, child: Icon(BoxIcons.bxs_video, color: Theme.of(context).textTheme.bodySmall!.backgroundColor,))
                  ])
                : const SizedBox()
        // subtitle: Text(desc!),
        );
  }
}
