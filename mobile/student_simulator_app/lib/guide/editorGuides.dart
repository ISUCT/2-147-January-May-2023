import 'dart:io';

import 'package:cached_video_player/cached_video_player.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_simulator/APIs_draft/apiFGuide.dart';
import 'package:student_simulator/APIs_draft/apiGuide.dart';
import 'package:student_simulator/guide/Model/guideModel.dart';
import 'package:uuid/uuid.dart';

import '../data/textGuide.dart';
import '../functions/showImage.dart';

class EditorGuides extends StatefulWidget {
  const EditorGuides(
      {this.id, this.name, this.desc, this.thumbnail, this.file, super.key});
  final String? id;
  final String? name;
  final String? desc;
  final String? thumbnail;
  final String? file;

  static final _formKey = GlobalKey<FormState>();

  @override
  State<EditorGuides> createState() => _EditorGuidesState();
}

class _EditorGuidesState extends State<EditorGuides> {
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
        title: const Text('Редактор гайдов'),
      ),
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: EditorGuides._formKey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFormField(
                    controller: controllerName,
                    cursorColor: Colors.blue,
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      label: const Text(
                        "Название гайда",
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
                        "Описание гайда",
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
                    child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () async {
                                if (EditorGuides._formKey.currentState!
                                    .validate()) {
                                  if (widget.id == null) {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    postGuide(controllerName.text,
                                        controllerdesc.text);
                                    setState(() {
                                      isLoading = true;
                                    });
                                    await Future<void>.delayed(
                                        const Duration(seconds: 2), () {});
                                    setState(() {
                                      getGuide();
                                    });
                                    await Future<void>.delayed(
                                        const Duration(seconds: 3), () {
                                      setState(() {
                                        isLoading = false;
                                      });
                                    });
                                    print("Successed");
                                    print("ID guide: ${guides.first.id}");
                                    if (isImage) {
                                      sendImage(guides.first.id
                                          .toString()); // Тут должна быть отправка изображени по
                                    }
                                    if (isVideo) {
                                      sendVideo(guides.first.id.toString());
                                    }
                                    if (isPostGuide) {
                                      controllerName.clear();
                                      controllerdesc.clear();
                                      Navigator.of(context).pop();
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (context) => const AlertDialog(
                                                title: Text("Ошибка"),
                                                content: Text(
                                                    "Не удалось добавить новый гайд, проверьте на правильность заполнения нового гайда."),
                                              ));
                                    }
                                  } else {
                                    updateGuide(widget.id!, controllerName.text,
                                        controllerdesc.text);
                                    setState(() {
                                      isLoading = true;
                                    });
                                    await Future<void>.delayed(
                                        const Duration(seconds: 2), () {});
                                    setState(() {
                                      getGuide();
                                    });
                                    await Future<void>.delayed(
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
      } else {
        getImage();
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
      } else {
        getVideo();
      }
    });
  }

  String? thumbnail;
  Future sendImage(String id) async {
    String fileName = Uuid().v1();
    int status = 1;
    var img =
        FirebaseStorage.instance.ref().child('Guides').child('${fileName}.png');
    var uploadTask = await img.putFile(imageFile!).catchError((error) async {
      status = 0;
    });
    print("Problem: $uploadTask");
    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();
      if (isVideo) {
        thumbnail = imageUrl;
      } else {
        postFGuide(imageUrl, 'img', id, 'null');
      }
      print("Изображение: $imageUrl");
    }
  }

  Future sendVideo(String id) async {
    String fileName = Uuid().v1();
    int status = 1;
    var mp4 =
        FirebaseStorage.instance.ref().child('Guides').child('${fileName}.mp4');
    var uploadTask = await mp4.putFile(videoFile!).catchError((error) async {
      status = 0;
    });
    if (status == 1) {
      String videoUrl = await uploadTask.ref.getDownloadURL();
      postFGuide(videoUrl, 'mp4', id, thumbnail!);
      // postFGuide(imageUrl, 'img', getResGuide.first.id!, 'null');
      print("Видео: $videoUrl");
    }
  }
}
