import 'package:http/http.dart' as http;

Future postFNews(String url_f, String type, DateTime news_id) async {
  String url = "http://94.154.11.154/api/posts/FNews.php";
  var res = await http.post(Uri.parse(url), body: {
    "url_f": url_f,
    "type": type,
    "news_id": news_id,
  });
  try {
    if (res.statusCode == 201) {
      print("PostFNews: ${res.statusCode.toString()}");
    } else {
      print("Not PostFNews: ${res.statusCode.toString()}");
    }
  } catch (e) {
    print("excep(PostFNews) = $e");
    print("Recorted(PostFNews): ${res.statusCode}");
  }
}

Future deleteFNews(int id) async {
  String url = "http://94.154.11.154/api/posts/deleteFNews.php";
  var res = await http.post(Uri.parse(url), body: {
    'id': id    
  });
  try {  
    if (res.statusCode == 202) {
      print("deleteFNews: ${res.statusCode.toString()}");
    } else {
      print("Not deleteFNews: ${res.statusCode.toString()}");
    }
  } catch (e) {
    print("excep(deleteFNews) = $e");
    print("Recorted(deleteFNews): ${res.statusCode}");
  }
}

Future updateFNews(int id, String url_f) async {
  String url = "http://94.154.11.154/api/posts/updateFNews.php";
  var res = await http.post(Uri.parse(url), body: {
    "id": id,
    "url_f": url_f,
  });
  try {
    if (res.statusCode == 202) {
      print("updateFNews: ${res.statusCode.toString()}");
    } else {
      print("Not updateFNews: ${res.statusCode.toString()}");
    }
  } catch (e) {
    print("excep(updateFNews) = $e");
    print("Recorted(updateFNews): ${res.statusCode}");
  }
}