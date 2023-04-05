import 'dart:io';

import 'package:cached_video_player/cached_video_player.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_simulator/APIs_draft/apiFNews.dart';
import 'package:student_simulator/APIs_draft/apiNews.dart';
import 'package:student_simulator/news/Model/1/newsModel.dart';
import 'package:student_simulator/news/newsPage.dart';
import 'package:video_player/video_player.dart';
import 'package:uuid/uuid.dart';

import '../data/textNews.dart';
import '../functions/showImage.dart';

class EditorNews extends StatefulWidget {
  const EditorNews(
      {this.id, this.name, this.desc, this.thumbnail, this.file, super.key});
  final String? id;
  final String? name;
  final String? desc;
  final String? thumbnail;
  final String? file;

  static final _formKey = GlobalKey<FormState>();

  @override
  State<EditorNews> createState() => _EditorNewsState();
}

class _EditorNewsState extends State<EditorNews> {
  bool isLoading = false;

  late CachedVideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      controllerName.text = widget.name!;
      controllerdesc.text = widget.desc!;
    }
    // controllerName.text = widget.text!;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    controllerName.dispose();
    controllerdesc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Редактор новостей'),
      ),
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: EditorNews._formKey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFormField(
                    controller: controllerName,
                    cursorColor: Colors.blue,
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      label: const Text(
                        "Название новости",
                        style: TextStyle(fontSize: 16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Введите текстовое поле";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: controllerdesc,
                    cursorColor: Colors.blue,
                    style: const TextStyle(fontSize: 16),
                    maxLines: 10,
                    decoration: InputDecoration(
                      label: const Text(
                        "Описание новости",
                        style: TextStyle(fontSize: 16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Введите текстовое поле";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: ElevatedButton(
                              onPressed: () {
                                getImage();
                              },
                              child: const Icon(BoxIcons.bx_image_add)),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: ElevatedButton(
                              onPressed: () {
                                getVideo();
                              },
                              child: const Icon(BoxIcons.bx_video_plus)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  isImage || isVideo
                      ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            height: 105,
                            child: Align(
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  isImage
                                      ? InkWell(
                                          onTap: () => Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      showImage(
                                                          imageFile:
                                                              imageFile))),
                                          child: ClipRRect(
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Stack(
                                                children: [
                                                  SizedBox(
                                                      height: 100,
                                                      width: 150,
                                                      child: Image.file(
                                                        imageFile!,
                                                        fit: BoxFit.cover,
                                                      )),
                                                  const Positioned(
                                                    left: 4,
                                                    bottom: 0,
                                                    child: Icon(
                                                      BoxIcons.bx_image,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                  Positioned(
                                                    right: 4,
                                                    top: 0,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          isImage = false;
                                                        });
                                                      },
                                                      child: const Icon(
                                                        Icons.close,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )),
                                        )
                                      : const SizedBox(),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  isVideo
                                      ? ClipRRect(
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Stack(
                                            children: [
                                              SizedBox(
                                                height: 100,
                                                width: 150,
                                                child: AspectRatio(
                                                  aspectRatio: _controller
                                                      .value.aspectRatio,
                                                  child: CachedVideoPlayer(
                                                    _controller,
                                                    // fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              const Positioned(
                                                left: 4,
                                                bottom: 0,
                                                child: Icon(
                                                  BoxIcons.bx_video,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              Positioned(
                                                right: 4,
                                                top: 0,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      isVideo = false;
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Icons.close,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ))
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(
                          height: 5,
                        ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 50,
                    width: size.width,
                    // color: Colors.amber,
                    child: ElevatedButton(
                        autofocus: true,
                        onPressed: isLoading
                            ? null
                            : () {
                                if (EditorNews._formKey.currentState!
                                    .validate()) {
                                  if (widget.id == null) {
                                    // FocusScope.of(context).requestFocus(FocusNode());
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    postNews(controllerName.text,
                                        controllerdesc.text);
                                    setState(() {
                                      // getNews();
                                      isLoading = true;
                                    });
                                    Future<void>.delayed(
                                        const Duration(seconds: 2), () {});

                                    setState(() {
                                      getNews();
                                    });
                                    Future<void>.delayed(
                                        const Duration(seconds: 3), () {
                                      setState(() {
                                        isLoading = false;
                                      });
                                    });
                                    print("Successed");
                                    if (isImage) {
                                      sendImage(getResNews.first.id
                                          .toString()); // Тут должна быть отправка изображени по
                                    }
                                    if (isVideo) {
                                      sendVideo(getResNews.first.id.toString());
                                    }
                                    if (!isPostNews) {
                                      controllerName.clear();
                                      controllerdesc.clear();
                                      Navigator.of(context).pop();
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: Text("Ошибка"),
                                                content: Text(
                                                    "Не удалось добавить новость, проверьте на правильность заполнения нового гайда."),
                                              ));
                                    }
                                  } else {
                                    updateNew(widget.id!, controllerName.text,
                                        controllerdesc.text);
                                    setState(() {
                                      isLoading = true;
                                    });
                                    Future<void>.delayed(
                                        const Duration(seconds: 2), () {});
                                    setState(() {
                                      getNews();
                                    });
                                    Future<void>.delayed(
                                        const Duration(seconds: 3), () {
                                      setState(() {
                                        isLoading = false;
                                      });
                                    });
                                    print("Updated");
                                    Navigator.of(context).pop();
                                  }
                                }
                              },
                        child: isLoading
                            ? CircularProgressIndicator(
                                // color: Colors.amber,
                                )
                            : Text("Сохранить"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            disabledBackgroundColor:
                                Theme.of(context).appBarTheme.backgroundColor)),
                  )
                ],
              ),
            ),
          )),
    );
  }

  File? imageFile;
  String? xFileNameI;
  String? fileNameI;
  bool isImage = false;
  Future getImage() async {
    ImagePicker _picker = ImagePicker();
    await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        setState(() {
          imageFile = File(xFile.path);
          xFileNameI = xFile.name;
          fileNameI = xFileNameI!.split("image_picker").last;
          isImage = true;
        });
      }
    });
  }

  File? videoFile;
  String? xFileNameV;
  String? fileNameV;
  bool isVideo = false;
  Future getVideo() async {
    ImagePicker _picker = ImagePicker();
    await _picker.pickVideo(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        setState(() {
          videoFile = File(xFile.path);
          xFileNameV = xFile.name;
          fileNameV = xFileNameV!.split("image_picker").last;
          isVideo = true;
          _controller = CachedVideoPlayerController.file(videoFile!)
            ..initialize().then((value) {
              setState(() {
                // _controller.seekTo(Duration(seconds: 50));
              });
            });
        });
      }
    });
  }

  String? thumbnail;
  Future sendImage(String id) async {
    String fileName = Uuid().v1();
    int status = 1;
    var img =
        FirebaseStorage.instance.ref().child('News').child('${fileName}.png');
    var uploadTask = await img.putFile(imageFile!).catchError((error) async {
      status = 0;
    });
    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();
      if (isVideo) {
        thumbnail = imageUrl;
      } else {
        postFNews(imageUrl, 'img', id, 'null');
      }
      print("Изображение: $imageUrl");
    }
  }

  Future sendVideo(String id) async {
    String fileName = Uuid().v1();
    int status = 1;
    var mp4 =
        FirebaseStorage.instance.ref().child('News').child('${fileName}.mp4');
    var uploadTask = await mp4.putFile(videoFile!).catchError((error) async {
      status = 0;
    });
    if (status == 1) {
      String videoUrl = await uploadTask.ref.getDownloadURL();
      postFNews(videoUrl, 'mp4', id, thumbnail!);
      // postFNews(imageUrl, 'img', getResNews.first.id!, 'null');
      print("Видео: $videoUrl");
    }
  }
}
