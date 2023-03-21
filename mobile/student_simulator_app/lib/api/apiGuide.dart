import 'dart:convert';

import 'package:http/http.dart' as http;

import '../guide/Model/guideModel.dart';

var getResGuide;
var response;
bool isData = false;
Future getGuide() async {
  String url = "http://94.154.11.154/api/posts/Guide.php";
  var res = await http.get(Uri.parse(url));
  try {
    response = jsonDecode(res.body);
    if (res.statusCode == 200) {
      getResGuide = guideModelFromJson(res.body);
      guides.clear();
      print("getGuide: ${getResGuide.toString()}");
      isData = true;
    } else {
      isData = false;
      print("Not getGuide");
    }
  } catch (e) {
    isData = false;
    print("excep(getGuide) = $e");
    print("Recorted(getGuide): ${res.statusCode}");
  }
}

Future postGuide(String name, String desc) async {
  String url = "http://94.154.11.154/api/posts/Guide.php";
  var res = await http.post(Uri.parse(url), body: {
    "name_g": name,
    "description_g": desc,
  });
  try {
    if (res.statusCode == 201) {
      print("PostGuide: ${res.statusCode.toString()}");
    } else {
      print("Not PostGuide: ${res.statusCode.toString()}");
    }
  } catch (e) {
    print("excep(PostGuide) = $e");
    print("Recorted(PostGuide): ${res.statusCode}");
  }
}

Future deleteGuide(String id) async {
  String url = "http://94.154.11.154/api/posts/deleteGuide.php";
  var res = await http.post(Uri.parse(url), body: {
    'id': id
  });
  try {
    if (res.statusCode == 202) {
      print("deleteGuide: ${res.statusCode.toString()}");
    } else {
      print("Not deleteGuide: ${res.statusCode.toString()}");
    }
  } catch (e) {
    print("excep(deleteGuide) = $e");
    print("Recorted(deleteGuide): ${res.statusCode}");
  }
}

Future updateGuide(String id, String name, String desc) async {
  String url = "http://94.154.11.154/api/posts/updateGuide.php";
  var res = await http.post(Uri.parse(url), body: {
    "id": id,
    "name_g": name,
    "description_g": desc,
  });
  try {
    if (res.statusCode == 202) {
      print("updateGuide: ${res.statusCode.toString()}");
    } else {
      print("Not updateGuide: ${res.statusCode.toString()}");
    }
  } catch (e) {
    print("excep(updateGuide) = $e");
    print("Recorted(updateGuide): ${res.statusCode}");
  }
}