import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../data/Users.dart';
import '../detalGuidePage.dart';

class Guides extends StatefulWidget {
  const Guides(
      {required this.id,
      required this.name,
      required this.desc,
      required this.url_f,
      required this.time,
      super.key});
  final int? id;
  final String? name;
  final String? desc;
  final List<String?> url_f;
  final DateTime time;
  @override
  State<Guides> createState() => _GuidesState();
}

class _GuidesState extends State<Guides> {
  static final cachedImage = CacheManager(Config(
    'cache1',
    stalePeriod: const Duration(days: 15),
    maxNrOfCacheObjects: 100,
  ));

  // late CachedVideoPlayerController _controller;

  // @override
  // void initState() {
  //   super.initState();
  //   if (widget.url_f[0]!.contains('mp4')) {
  //     _controller = CachedVideoPlayerController.network(widget.url_f[0]!)
  //       ..initialize().then((value) {
  //         setState(() {
  //           _controller.seekTo(const Duration(seconds: 50));
  //         });
  //       });
  //   }
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _controller.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).appBarTheme.backgroundColor,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => detalGuidePage(
                    id: widget.id,
                    name: widget.name,
                    desc: widget.desc,
                    url: widget.url_f,
                    time: widget.time,
                    user: users[index_user].username)),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundColor:
                        Theme.of(context).appBarTheme.backgroundColor,
                    backgroundImage: NetworkImage(users[0].avatar_url),
                    foregroundImage: NetworkImage(users[0].avatar_url),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        // width: ,
                        child: Text(
                          users[0].username,
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .backgroundColor),
                        ),
                      ),
                      if (users[0].verifed)
                        const Icon(
                          BoxIcons.bxs_badge_check,
                          color: Colors.blue,
                          size: 19,
                        ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
              child: Text(
                // '',
                widget.name!,
                style: TextStyle(
                    color:
                        Theme.of(context).textTheme.bodyLarge!.backgroundColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            widget.url_f[0] != null && (widget.url_f[0]!.contains('png') || widget.url_f[0]!.contains('jpg') || widget.url_f[0]!.contains('images'))
                ? AspectRatio(
                    aspectRatio: 4 / 3,
                    child: CachedNetworkImage(
                      cacheManager: cachedImage,
                      imageUrl: widget.url_f[0] == null ? '' : widget.url_f[0]!,
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
                  )
                // : widget.url_f[0] != null && widget.url_f[0]!.contains('mp4')
                //     ? AspectRatio(
                //         aspectRatio: 4 / 3,
                //         child: CachedVideoPlayer(_controller),
                //       )
                    : Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8, bottom: 16),
                        child: Text(
                          // '',
                          widget.desc!,
                          style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .backgroundColor),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
