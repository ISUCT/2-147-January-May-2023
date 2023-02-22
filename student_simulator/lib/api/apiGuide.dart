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

      List<GuideModel> list;
    response = jsonDecode(res.body);
    if (res.statusCode == 200) {
      isData = true;
      // print(response);
      // final models = response.keys.map((key) {
      //   final subData = response[key.toString()];
      //   return guideModelFromJson(subData[key.toString()]);
      // });
      // list = (json.decode(response.body) as List)
      //     .map((data) => new Photo.fromJson(data))
      //     .toList();
      // if (guideModelFromJson(res.body) != null){
        // if (response.length)
      getResGuide = guideModelFromJson(res.body);
      print("Recorted: ${res.statusCode}");
      print("Json: ${getResGuide.toString()}");
      // print("Json: ${response.length}");
      
      // list = getResGuide.toList();
      // list = getResGuide.entries.map( (entry) => GuideModel(entry.key, entry.value)).toList();
      // print("Json: ${list[0].id}");
      // // }
      // print(guideModel.['1'].id);
// print(guideModel.nameG["666"].s);

      // models.forEach((guide) {R
      //   print("FAQ: ${guide} \n ");
      // });
      // getResGuide = guideModelFromJson(res.body);
      // map_get = getResGuide;
    } else {
      print("Not res");
    }

    // print("RES: ${}");
  } catch (e) {
    print("excep = $e");
    print("Recorted: ${res.statusCode}");
  }
}
