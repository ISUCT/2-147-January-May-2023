import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// import 'package:shimmer/shimmer.dart';
import '../../components/time.dart';
import '../detalNewPage.dart';
import 'CustomListTile.dart';

class News extends StatelessWidget {
  const News(
      {required this.name,
      required this.desc,
      required this.image,
      required this.time,
      super.key});
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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CustomListTile(
        route: DetalNewPage(
          name: name!,
          desc: desc!,
          image: image,
          time: time,
        ),
        // leading: Image.network(image),
        title: SizedBox(
          width: image != null ? size.width - 180 : null,
          child: Text(
            name!,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: Text(
          timeToStr(time),
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        trailing: image != null
            ? CachedNetworkImage(
                height: 100,
                width: 150,
                cacheManager: customCacheManager,
                key: UniqueKey(),
                imageUrl: image!,
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
            : const SizedBox()
        // subtitle: Text(desc!),
        );
  }
}
