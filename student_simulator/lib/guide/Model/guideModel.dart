// To parse this JSON data, do

//     final guideModel = guideModelFromJson(jsonString);

// import 'package:meta/meta.dart';
// import 'dart:convert';

// List<GuideModel> guideModelFromJson(String str) => List<GuideModel>.from(json.decode(str).map((x) => GuideModel.fromJson(x)));

// String guideModelToJson(List<GuideModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class GuideModel {
//     GuideModel({
//         required this.id,
//         required this.nameG,
//         required this.descriptionG,
//         required this.likeG,
//         required this.timestampG,
//         required this.urlF,
//         required this.type,
//     });

//     int? id;
//     String? nameG;
//     String? descriptionG;
//     int? likeG;
//     DateTime? timestampG;
//     List<String>? urlF;
//     List<String>? type;

//     factory GuideModel.fromJson(Map<String, dynamic> json) => GuideModel(
//         id: json["id"],
//         nameG: json["name_g"],
//         descriptionG: json["description_g"],
//         likeG: json["like_g"],
//         timestampG: DateTime.parse(json["timestamp_g"]),
//         urlF: List<String>.from(json["url_f"].map((x) => x)),
//         type: List<String>.from(json["type"].map((x) => x)),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name_g": nameG,
//         "description_g": descriptionG,
//         "like_g": likeG,
//         "timestamp_g": timestampG!.toIso8601String(),
//         "url_f": List<dynamic>.from(urlF!.map((x) => x)),
//         "type": List<dynamic>.from(type!.map((x) => x)),
//     };
// }
// To parse this JSON data, do
//
//     final guideModel = guideModelFromJson(jsonString);
import 'package:meta/meta.dart';
import 'dart:convert';

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
  });

  int id;
  String name_g;
  String description_g;
  int like_g;
  String timestamp_g;
  List<String?> url_f;
  List<String?> type;

  factory GuideModel.fromJson(Map<String, dynamic> json) => GuideModel(
        id: json["id"]!,
        name_g: json["name_g"]!,
        description_g: json["description_g"]!,
        like_g: json["like_g"]!,
        timestamp_g: json["timestamp_g"]!,
        url_f: List<String?>.from(json["url_f"]!),
        type: List<String?>.from(json["type"]!)
      );
@override
  String toString() {
    // if(guides[guides.length-1].id != 1)
    guides.add(GuideModel(id: id, name_g: name_g, description_g: description_g, like_g: like_g, timestamp_g: timestamp_g, url_f: url_f, type: type));
    return "{name_g: $name_g, description_g: $description_g, like_g: $like_g, timestamp_g: $timestamp_g}";
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
