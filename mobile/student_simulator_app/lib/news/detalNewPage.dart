// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:student_simulator/api/apiNews.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Описание новости"),
        actions: [
          if (users[index_user].status == "admin")
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
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
                                "Вы хотите удалить эту новость навсегда?\nid: ${widget.id}"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Нет")),
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

                                    getNews();
                                    await Future<void>.delayed(
                                        const Duration(seconds: 3), () {
                                      getNews();
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
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Опубликована ${DateFormat('HH.mm dd.MM.yyyy').format(widget.time)}",
                style: const TextStyle(
                    color: Colors.grey, fontStyle: FontStyle.italic),
                textAlign: TextAlign.right,
              ),
              const SizedBox(
                height: 10,
              ),
              widget.image != null
                  ? CachedNetworkImage(
                      imageUrl: widget.image!,
                      height: 250,
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.desc,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
