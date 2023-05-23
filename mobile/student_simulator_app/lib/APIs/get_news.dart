import 'dart:convert';
// получение get-запроса новостей
import 'package:http/http.dart' as http;
import '../news/Model/2/newsModel.dart';

var getResNews;
List<Datum> listNews= [];
List<Datum> listNewsImage = [];
bool isDataNews = true;
bool isDataNewsLoading = true;
Future getNews() async {
  isDataNews = true;
  String url = "http://80.90.188.52/api/news";
  http.Response res = await http.get(Uri.parse(url));
  try {
    if (res.statusCode == 200) {
      // var response = jsonDecode(res.body);
      isDataNews = false;
      isDataNewsLoading = false;

      // List<NewsModel> tempList = [];
      // var getn;
      getResNews = newsModelFromJson(res.body);
      listNews = getResNews.data;
      // listNewsImage = lis; 
      // listNewsImage = List.generate(5, (index) => listNews[index], growable: true); 

      // for(var v in getResNews){
      // tempList.add(v);
      // }
      // getResNews = response as List;
      // print("getNews: ${getResNews[0].id}");
      print("getNews: ${res.statusCode}");
      print("resNews: ${getResNews.data.first.idNews.toString()}");
      print("resListNews: ${listNews.first.idNews.toString()}");
      // Future.delayed(Duration(seconds: 3), () {
      //   getn = getResNews;
      // });
      // return NewsModel.newsSnapshot(tempList).toList();
      return listNews;
    } else {
      isDataNews = true;
      isDataNewsLoading = true;
      print("Not getNews");
      // return [];
    }
  } catch (e) {
    isDataNews = true;
    isDataNewsLoading = true;
    print("excep(getNews) = $e");
    print("Recorted(getNews): ${res.statusCode}");
    // return [];
    // return [];
  }
}
