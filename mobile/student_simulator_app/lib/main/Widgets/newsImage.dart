// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// import 'package:shimmer/shimmer.dart';

class NewsImage extends StatelessWidget {
  const NewsImage(
      {required this.name,
      required this.desc,
      required this.image,
      required this.time,
      required this.route,
      super.key});
  final String? name;
  final String? desc;
  final String image;
  final DateTime time;
  final Widget route;

  static final customCachedImage = CacheManager(Config(
    'customCacheKey1',
    stalePeriod: const Duration(days: 15),
    maxNrOfCacheObjects: 10,
  ));
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => route));
      },
      child: Stack(alignment: Alignment.center, fit: StackFit.expand, children: [
        CachedNetworkImage(
          cacheManager: customCachedImage,
          key: UniqueKey(),
          imageUrl: image,
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
        ),
        Positioned(
            bottom: 5,
            left: 10,
            right: 10,
            child: Text(
              name!,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ))
      ]),
    );
  }
}
