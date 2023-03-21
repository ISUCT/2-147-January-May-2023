import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:student_simulator/api/apiGuide.dart';
import 'package:student_simulator/guide/editorGuides.dart';

import '../data/Users.dart';

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

class _detalGuidePageState extends State<detalGuidePage> {
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
                icon: Icon(Icons.edit),
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
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    bool isChecked = false;
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Подтвердить?"),
                          content: Text(
                              "Вы хотите удалить этот гайд навсегда?\nid: ${widget.id}"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Нет")),
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
                                child: Text("Да"))
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
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Опубликована ${DateFormat('HH.mm dd.MM.yyyy').format(widget.time!)}",
              style: const TextStyle(
                  color: Colors.grey, fontStyle: FontStyle.italic),
              textAlign: TextAlign.right,
            ),
            const SizedBox(
              height: 10,
            ),
            widget.url.first != null
                ? Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: CarouselSlider.builder(
                          carouselController: _controller,
                          itemCount: widget.url.length,
                          options: CarouselOptions(
                              enableInfiniteScroll: false,
                              viewportFraction: 1,
                              autoPlay: widget.url.length > 1 ? true : false,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  activePage = index;
                                });
                              }),
                          itemBuilder: (context, index, realIndex) =>
                              CachedNetworkImage(
                            imageUrl: widget.url[index]!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
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
                              )
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: widget.url.asMap().entries.map((entry) {
                              //     return GestureDetector(
                              //       onTap: () => _controller.animateToPage(entry.key),
                              //       child: Container(
                              //         width: 6.0,
                              //         height: 6.0,
                              //         margin: EdgeInsets.symmetric(
                              //             vertical: 8.0, horizontal: 4.0),
                              //         decoration: BoxDecoration(
                              //             shape: BoxShape.circle,
                              //             color: Colors.white
                              //                 .withOpacity(
                              //                     activePage == entry.key ? 0.9 : 0.4)),
                              //       ),
                              //     );
                              //   }).toList(),
                              // ),
                              )
                          : SizedBox(),
                    ],
                  )
                : const SizedBox(),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.desc!,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
      // ),
    );
  }
}
