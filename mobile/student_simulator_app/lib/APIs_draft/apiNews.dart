import 'dart:convert';
import 'package:http/http.dart' as http;
import '../news/Model/1/newsModel.dart';

List<NewsModel> getResNews = [];
bool isDataNews = true;
bool isDataNewsLoading = true;
Future <List<NewsModel>> getNews() async {
  isDataNews = true;
  String url = "http://94.154.11.154/api/posts/News.php";
  var res = await http.get(Uri.parse(url));
  try {
    if (res.statusCode == 200) {
      // var response = jsonDecode(res.body);
      isDataNews = false;
      isDataNewsLoading = false;
      // List<NewsModel> tempList = [];
      getResNews = newsModelFromJson(res.body);
      // for(var v in getResNews){
        // tempList.add(v);
      // }
      // getResNews = response as List;
      // print("getNews: ${getResNews[0].id}");
      print("getNews: ${res.statusCode}");
      print("resNews: ${getResNews.first.toJson()}");
      // return NewsModel.newsSnapshot(tempList).toList();
      return getResNews;
    } else {
      isDataNews = true;
      isDataNewsLoading = true;
      print("Not getNews");
      // return [];
      return [];
    }
  } catch (e) {
    isDataNews = true;
    isDataNewsLoading = true;
    print("excep(getNews) = $e");
    print("Recorted(getNews): ${res.statusCode}");
    // return [];
    return [];
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
bool isPostNews = false;
Future postNews(String name, String desc) async {
  isPostNews = false;
  String url = "http://94.154.11.154/api/posts/News.php";
  var res = await http.post(Uri.parse(url), body: {
    "name_n": name,
    "description_n": desc,
    // "timestamp_n": time,
  });
  try {
    if (res.statusCode == 201) {
      isPostNews = true;
      print("PostNews: ${res.statusCode.toString()}");
    } else {
      isPostNews = false;
      print("Not PostNews: ${res.statusCode.toString()}");
    }
  } catch (e) {
    isPostNews = false;
    print("excep(PostNews) = $e");
    print("Recorted(PostNews): ${res.statusCode}");
  }
}

Future deleteNews(String id) async {
  String url = "http://94.154.11.154/api/posts/deleteNew.php";
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

Future updateNew(String id, String name, String desc) async {
  String url = "http://94.154.11.154/api/posts/updateNew.php";
  var res = await http.post(Uri.parse(url), body: {
    "id": id,
    "name_n": name,
    "description_n": desc,
  });
  try {
    if (res.statusCode == 202) {
      print("updateNew: ${res.statusCode.toString()}");
    } else {
      print("Not updateNew: ${res.statusCode.toString()}");
    }
  } catch (e) {
    print("excep(updateNews) = $e");
    print("Recorted(updateNews): ${res.statusCode}");
  }
}
