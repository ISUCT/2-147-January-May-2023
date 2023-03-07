import 'dart:convert';

import 'package:http/http.dart' as http;

import '../guide/Model/guideModel.dart';

var getResGuide;
// var map_get;
var response;
bool isData = false;
Future getGuide() async {
  String url = "http://185.251.89.150/api/post/getGuides.php";
  var res = await http.get(Uri.parse(url));
  try {
    // List<GuideModel> list;
    response = jsonDecode(res.body);
    if (res.statusCode == 200) {
      isData = true;
      getResGuide = guideModelFromJson(res.body);
      guides.clear();
      print("Json: ${getResGuide.toString()}");
    } else {
      isData = false;
      print("Not res");
    }

    // print("RES: ${}");
  } catch (e) {
    isData = false;
    print("excep = $e");
    print("Recorted: ${res.statusCode}");
  }
}
