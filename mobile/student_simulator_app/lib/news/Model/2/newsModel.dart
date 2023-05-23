// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

// String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
    NewsModel({
        required this.count,
        required this.data,
    });

    String count;
    List<Datum> data;

    factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        count: json["count"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    // Map<String, dynamic> toJson() => {
    //     "count": count,
    //     "data": List<dynamic>.from(data!.map((x) => x!.toJson())),
    // };
}

class Datum {
    Datum({
        required this.idNews,
        required this.title,
        required this.text,
        required this.image,
        required this.creatingDate,
    });

    String? idNews;
    String? title;
    String? text;
    String? image;
    DateTime? creatingDate;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idNews: json["id_News"]! ?? '',
        title: json["Tittle"]! ?? '',
        text: json["Text"]! ?? '',
        image: "http://80.90.188.52/${json["Image"]}",
        // image: json["Image"]! ?? '',
        creatingDate: DateTime.parse(json["Creating_date"]! ?? '19000101'),
    );

    // Map<String, dynamic> toJson() => {
    //     "id_News": idNews.toString(),
    //     "Tittle": title,
    //     "Text": text,
    //     "Image": image,
    //     "Creating_date": "${creatingDate!.year.toString().padLeft(4, '0')}-${creatingDate!.month.toString().padLeft(2, '0')}-${creatingDate!.day.toString().padLeft(2, '0')}",
    // };
}
