//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

List<NewsModel> newsModelFromJson(String str) => List<NewsModel>.from(json.decode(str).map((x) => NewsModel.fromJson(x)));

String newsModelToJson(List<NewsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewsModel {
    NewsModel({
        required this.id,
        required this.name_n,
        required this.description_n,
        required this.timestamp_n,
        required this.url_f,
        required this.type,
        required this.thumbnail,
    });

    int? id;
    String? name_n;
    String? description_n;
    DateTime? timestamp_n;
    String? url_f;
    String? thumbnail;
    String? type;

    factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        id: json["id"],
        name_n: json["name_n"],
        description_n: json["description_n"],
        timestamp_n: DateTime.parse(json["timestamp_n"]),
        url_f: json["url_f"],
        thumbnail: json["thumbnail"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name_n": name_n,
        "description_n": description_n,
        "timestamp_n": timestamp_n!.toIso8601String(),
        "url_f": url_f,
        "thumbnail": thumbnail,
        "type": type,
    };

    static List <NewsModel> newsSnapshot(List snapshot){
      return snapshot.map((e) => NewsModel.fromJson(e)).toList();
    }
}
