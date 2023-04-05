// ignore_for_file: file_names, unused_local_variable, avoid_print, use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:student_simulator/APIs_draft/apiGuide.dart';
import 'package:student_simulator/guide/editorGuides.dart';

import '../functions/showImage.dart';
import '../functions/showVideo.dart';

// ignore: camel_case_types
class detalGuidePage extends StatefulWidget {
  const detalGuidePage(
      {required this.id,
      required this.name,
      required this.desc,
      required this.time,
      required this.url,
      required this.user,
      super.key});
  final int? id;
  final String? name;
  final String? desc;
  final List<String?> url;
  final DateTime? time;
  final String? user;

  @override
  State<detalGuidePage> createState() => _detalGuidePageState();
}

// ignore: camel_case_types
class _detalGuidePageState extends State<detalGuidePage> {
  late CachedVideoPlayerController _controllerVideo;

  @override
  void initState() {
    super.initState();
    if (widget.url.last != null && widget.url.last!.contains('mp4')) {
      _controllerVideo = CachedVideoPlayerController.network(widget.url.last!)
        ..initialize().then((value) {
          setState(() {
            _controllerVideo.seekTo(const Duration(seconds: 50));
          });
        });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controllerVideo.dispose();
  }

  int activePage = 0;
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Подробности"),
        actions: [
          // if (users[index_user].status == "admin")
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditorGuides(
                            id: widget.id.toString(),
                            name: widget.name,
                            desc: widget.desc,
                          )));
                },
              ),
              IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    bool isChecked = false;
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            "Подтвердить?",
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .backgroundColor),
                          ),
                          content: Text(
                              "Вы хотите удалить этот гайд навсегда?\nid: ${widget.id}",
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .backgroundColor)),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Нет")),
                            TextButton(
                                onPressed: () async {
                                  setState(() {
                                    deleteGuide(widget.id.toString());
                                    if (widget.url[0] != null) {
                                      for (int i = 0;
                                          i < widget.url.length;
                                          i++) {
                                        try {
                                          FirebaseStorage.instance
                                              .refFromURL(widget.url[i]!)
                                              .delete();
                                        } catch (e) {
                                          print("exp: $e");
                                        }
                                      }
                                    }
                                  });

                                  // getNews();
                                  await Future<void>.delayed(
                                      const Duration(seconds: 3), () {
                                    // getNews();
                                  });
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: const Text("Да"))
                          ],
                        );
                      },
                    );
                  })
            ],
          ),
        ],
      ),
      body:
          // SingleChildScrollView(
          //   child:
          Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.name!,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color:
                      Theme.of(context).textTheme.bodyLarge!.backgroundColor),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Опубликована ${DateFormat('HH:mm dd.MM.yyyy').format(widget.time!)}",
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodySmall!.backgroundColor,
                  fontStyle: FontStyle.italic),
              textAlign: TextAlign.right,
            ),
            const SizedBox(
              height: 10,
            ),
            widget.url.first != null
                ? Stack(
                    children: [
                      // AspectRatio(
                      // aspectRatio: 16 / 9,
                      CarouselSlider.builder(
                          carouselController: _controller,
                          itemCount: widget.url.length,
                          options: CarouselOptions(
                              height: 250,
                              enableInfiniteScroll: false,
                              viewportFraction: 1,
                              autoPlay: widget.url.length > 1 ? true : false,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  activePage = index;
                                });
                              }),
                          itemBuilder: (context, index, realIndex) => ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: InkWell(
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => showImage(
                                              imageURL: widget.url[index]!))),
                                  child: widget.url[index] != null && (widget.url[index]!.contains('png') || widget.url[index]!.contains('jpg') || widget.url[index]!.contains('images'))
                                      ? CachedNetworkImage(
                                          imageUrl: widget.url[index]!,
                                          // height: 250,
                                          fit: BoxFit.cover,
                                        )
                                      : widget.url[index] != null &&
                                              widget.url[index]!.contains("mp4")
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: InkWell(
                                                onTap: () => Navigator.of(
                                                        context)
                                                    .push(MaterialPageRoute(
                                                        builder: (context) =>
                                                            showVideo(
                                                                videoURL: widget
                                                                        .url[
                                                                    index]))),
                                                child: AspectRatio(
                                                    aspectRatio:
                                                        _controllerVideo
                                                            .value.aspectRatio,
                                                    child: CachedVideoPlayer(
                                                        _controllerVideo)),
                                              ),
                                            )
                                          : const SizedBox(),
                                ),
                              )),
                      // ),
                      widget.url.length > 1
                          ? Positioned(
                              bottom: 5,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: AnimatedSmoothIndicator(
                                  activeIndex: activePage,
                                  count: widget.url.length,
                                  // textDirection: TextDirection(),
                                  effect: WormEffect(
                                      dotColor: Colors.white.withOpacity(0.4),
                                      activeDotColor:
                                          Colors.white.withOpacity(0.9),
                                      dotWidth: 6,
                                      dotHeight: 6),
                                ),
                              ))
                          : const SizedBox(),
                    ],
                  )
                : const SizedBox(),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.desc!,
              style: TextStyle(
                  fontSize: 18,
                  color:
                      Theme.of(context).textTheme.bodyLarge!.backgroundColor),
            ),
          ],
        ),
      ),
      // ),
    );
  }
}
