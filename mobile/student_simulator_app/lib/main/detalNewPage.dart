// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetalNewPage extends StatelessWidget {
  const DetalNewPage(
      {required this.name,
      required this.desc,
      required this.time,
      this.image,
      super.key});
  final String name;
  final String desc;
  final DateTime time;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Описание новости"),
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
                name,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Опубликована ${DateFormat('HH.mm dd.MM.yyyy').format(time)}",
                style: const TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                textAlign: TextAlign.right,
              ),
              const SizedBox(
                height: 10,
              ),
              image != null ? CachedNetworkImage(imageUrl: image!, height: 250,) : const SizedBox(),
              const SizedBox(
                height: 20,
              ),
              Text(
                desc,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
