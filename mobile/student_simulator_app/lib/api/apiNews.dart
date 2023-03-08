import 'dart:convert';
import 'package:http/http.dart' as http;
import '../main/Model/newsModel.dart';

List<NewsModel> getResNews = [];
var response;
bool isDataNews = false;
Future getNews() async {
  String url = "http://94.154.11.154/api/posts/News.php";
  var res = await http.get(Uri.parse(url));
  try {
    response = jsonDecode(res.body);
    if (res.statusCode == 200) {
      isDataNews = true;
      getResNews = newsModelFromJson(res.body);
      print("getNews: ${getResNews[0].id}");
    } else {
      isDataNews = false;
      print("Not getNews");
    }
  } catch (e) {
    isDataNews = false;
    print("excep(getNews) = $e");
    print("Recorted(getNews): ${res.statusCode}");
  }
}

List<NewsModel> getResNewsImage = [];
var response1;
bool isDataNewsImage = false;
Future getNewsImage() async {
  String url = "http://94.154.11.154/api/posts/NewsImage.php";
  var res = await http.get(Uri.parse(url));
  try {
    response1 = jsonDecode(res.body);
    if (res.statusCode == 200) {
      isDataNewsImage = true;
      getResNewsImage = newsModelFromJson(res.body);
      print("getNewsImage: ${getResNewsImage[0].id}");
    } else {
      isDataNewsImage = false;
      print("Not getNewsImage");
    }
  } catch (e) {
    isDataNewsImage = false;
    print("excep(getNewsImage) = $e");
    print("Recorted(getNewsImage): ${res.statusCode}");
  }
}

Future postNews(String name, String desc, DateTime time) async {
  String url = "http://94.154.11.154/api/posts/News.php";
  var res = await http.post(Uri.parse(url), body: {
    "name_n": name,
    "description_n": desc,
    "timestamp_n": time,
  });
  try {
    if (res.statusCode == 201) {
      print("PostNews: ${res.statusCode.toString()}");
    } else {
      print("Not PostNews: ${res.statusCode.toString()}");
    }
  } catch (e) {
    print("excep(PostNews) = $e");
    print("Recorted(PostNews): ${res.statusCode}");
  }
}

Future deleteNews(int id) async {
  String url = "http://94.154.11.154/api/posts/deleteNews.php";
  var res = await http.post(Uri.parse(url), body: {'id': id});
  try {
    if (res.statusCode == 202) {
      print("deleteNews: ${res.statusCode.toString()}");
    } else {
      print("Not deleteNews: ${res.statusCode.toString()}");
    }
  } catch (e) {
    print("excep(deleteNews) = $e");
    print("Recorted(deleteNews): ${res.statusCode}");
  }
}

Future updateNews(int id, String name, String desc) async {
  String url = "http://94.154.11.154/api/posts/updateNews.php";
  var res = await http.post(Uri.parse(url), body: {
    "id": id,
    "name_n": name,
    "description_n": desc,
  });
  try {
    if (res.statusCode == 202) {
      print("updateNews: ${res.statusCode.toString()}");
    } else {
      print("Not updateNews: ${res.statusCode.toString()}");
    }
  } catch (e) {
    print("excep(updateNews) = $e");
    print("Recorted(updateNews): ${res.statusCode}");
  }
}
