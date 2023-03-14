import 'package:http/http.dart' as http;

Future postFGuide(String url_f, String type, String guide_id, String thumbnail) async {
  String url = "http://94.154.11.154/api/posts/FGuide.php";
  var res = await http.post(Uri.parse(url), body: {
    "url_f": url_f,
    "type": type,
    "guide_id": guide_id,
    "thumbnail": thumbnail
  });
  try {
    if (res.statusCode == 201) {
      print("PostFGuide: ${res.statusCode.toString()}");
    } else {
      print("Not PostFGuide: ${res.statusCode.toString()}");
    }
  } catch (e) {    
    print("excep(PostFGuide) = $e");
    print("Recorted(PostFGuide): ${res.statusCode}");
  }
}

Future deleteFGuide(int id) async {
  String url = "http://94.154.11.154/api/posts/deleteFGuide.php";
  var res = await http.post(Uri.parse(url), body: {
    'id': id    
  });
  try {  
    if (res.statusCode == 202) {
      print("deleteFGuide: ${res.statusCode.toString()}");
    } else {
      print("Not deleteFGuide: ${res.statusCode.toString()}");
    }
  } catch (e) {
    print("excep(deleteFGuide) = $e");
    print("Recorted(deleteFGuide): ${res.statusCode}");
  }
}

Future updateFGuide(String id, String url_f, String thumbnail) async {
  String url = "http://94.154.11.154/api/posts/updateFGuide.php";
  var res = await http.post(Uri.parse(url), body: {
    "id": id,
    "url_f": url_f,
    "thumbnail": thumbnail
  });
  try {
    if (res.statusCode == 202) {
      print("updateFGuide: ${res.statusCode.toString()}");
    } else {
      print("Not updateFGuide: ${res.statusCode.toString()}");
    }
  } catch (e) {
    print("excep(updateFGuide) = $e");
    print("Recorted(updateFGuide): ${res.statusCode}");
  }
}