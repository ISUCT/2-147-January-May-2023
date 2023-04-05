// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_simulator/APIs_draft/apiNews.dart';
import 'package:student_simulator/functions/showImage.dart';
import 'package:student_simulator/functions/showVideo.dart';
import 'package:student_simulator/news/editorNews.dart';

import '../data/Users.dart';

class DetalNewPage extends StatefulWidget {
  const DetalNewPage(
      {required this.id,
      required this.name,
      required this.desc,
      required this.time,
      this.image,
      super.key});
  final int id;
  final String name;
  final String desc;
  final DateTime time;
  final String? image;

  @override
  State<DetalNewPage> createState() => _DetalNewPageState();
}

class _DetalNewPageState extends State<DetalNewPage> {
  late CachedVideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.image != null && widget.image!.contains('mp4')) {
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
    if (widget.image != null && widget.image!.contains('mp4')) {
      _controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back_ios),
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        // ),
        title: const Text("Описание новости"),
        actions: [
          if (users[index_user].status == "admin")
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditorNews(
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
                            title: const Text("Подтвердить?"),
                            content: Text(
                                "Вы хотите удалить эту новость навсегда?\nid: ${widget.id}"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Нет")),
                              TextButton(
                                  onPressed: () async {
                                    setState(() {
                                      deleteNews(widget.id.toString());
                                      if (widget.image != null) {
                                        try {
                                          FirebaseStorage.instance
                                              .refFromURL(widget.image!)
                                              .delete();
                                        } catch (e) {
                                          print("exp: $e");
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.name,
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
                "Опубликована ${DateFormat('HH.mm dd.MM.yyyy').format(widget.time)}",
                style: TextStyle(
                    color:
                        Theme.of(context).textTheme.bodySmall!.backgroundColor,
                    fontStyle: FontStyle.italic),
                textAlign: TextAlign.right,
              ),
              const SizedBox(
                height: 10,
              ),
              widget.image != null &&
                      (widget.image!.contains("png") ||
                          widget.image!.contains("jpg"))
                  ? AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      showImage(imageURL: widget.image))),
                          child: CachedNetworkImage(
                            imageUrl: widget.image!,
                            // height: 250,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  : widget.image != null && widget.image!.contains("mp4")
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        showVideo(videoURL: widget.image))),
                            child: AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                child: CachedVideoPlayer(_controller)),
                          ),
                        )
                      : const SizedBox(),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.desc,
                style: TextStyle(
                    fontSize: 18,
                    color:
                        Theme.of(context).textTheme.bodyLarge!.backgroundColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
