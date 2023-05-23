
import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:student_simulator/APIs_draft/apiGuide.dart';

List<GuideModel> guides = [];
Map<String, GuideModel> guideModelFromJson(String str) =>
    Map.from(json.decode(str))
        .map((k, v) => MapEntry<String, GuideModel>(k, GuideModel.fromJson(v)));
// List<GuideModel> guideModelFromJson(String str) => List<GuideModel>.from(json.decode(str).map((x) => GuideModel.fromJson(x)));

// String guideModelToJson(Map<String, GuideModel> data) => json.encode(
//     Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));
// String guideModelToJson(List<GuideModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GuideModel {
  GuideModel({
    required this.id,
    required this.name_g,
    required this.description_g,
    required this.like_g,
    required this.timestamp_g,
    required this.url_f,
    required this.type,
    required this.thumbnail,
  });

  int? id;
  String? name_g;
  String? description_g;
  int? like_g;
  DateTime? timestamp_g;  
  String? thumbnail;
  List<String?> url_f;
  List<String?> type;

  factory GuideModel.fromJson(Map<String, dynamic> json) => GuideModel(
        id: json["id"],
        name_g: json["name_g"],
        description_g: json["description_g"],
        like_g: json["like_g"],
        timestamp_g: DateTime.tryParse(json["timestamp_g"].toString()),
        thumbnail: json["thumbnail"],
        url_f: List<String?>.from(json["url_f"]),
        type: List<String?>.from(json["type"])
      );
@override
  String toString() {
    // if(guides[guides.length-1].id != 1)
    guides.add(GuideModel(id: id, name_g: name_g, description_g: description_g, like_g: like_g, timestamp_g: timestamp_g, url_f: url_f, type: type, thumbnail: thumbnail));
    return "{name_g: $name_g, description_g: $description_g, like_g: $like_g, timestamp_g: ${timestamp_g.toString()}}";
  }
  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "name_g": nameG,
  //       "description_g": descriptionG,
  //       "like_g": likeG,
  //       "timestamp_g": timestampG,
  //       "url_f": List<dynamic>.from(urlF!.map((x) => x)),
  //       "type": List<dynamic>.from(type!.map((x) => x)),
  //     };
}
