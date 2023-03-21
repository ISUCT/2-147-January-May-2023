// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:student_simulator/Styles/Colors.dart';
import 'package:student_simulator/news/Model/newsModel.dart';
import 'package:student_simulator/news/Widgets/CustomListTile.dart';
import 'package:student_simulator/news/Widgets/newsVideo.dart';
import 'package:student_simulator/news/Widgets/shimmerWidget.dart';
import 'package:student_simulator/news/Widgets/news.dart';
import 'package:student_simulator/news/Widgets/newsImage.dart';
import 'package:student_simulator/news/detalNewPage.dart';
import '../api/apiNews.dart';
import '../data/Users.dart';
import 'Widgets/loadingWidget.dart';
import 'editorNews.dart';

int countSendEmail = 0;

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  
  @override
  void initState() {
    // setState(() {
    getNews();
    getNewsImage();
    // });
    super.initState();
  }

  // @override
  // void didChangeDependencies() async {
  //   getNews();
  //   // getNews();
  //   super.didChangeDependencies();
  // }

  // Future<void> getNews() async {
  //   newsList.clear();
  //   newsList = await getNews();
  //   // newsList = await getNews();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var brightness = Theme.of(context).brightness;
    return Scaffold(
      // appBar:
      body: SafeArea(
        child: NestedScrollView(
          // floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              forceElevated: innerBoxIsScrolled,
              // pinned: false,
              // floating: true,
              // snap: false,
              // elevation: 5,
              // backgroundColor: Colors.white,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: InkWell(
                      customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  insetPadding: const EdgeInsets.all(5),
                                  title: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Theme.of(context).backgroundColor,
                                        backgroundImage: NetworkImage(
                                            users[index_user].avatar_url),
                                        foregroundImage: NetworkImage(
                                            users[index_user].avatar_url),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      SizedBox(
                                          width: size.width - 150,
                                          child: Text(
                                            users[index_user].username,
                                            maxLines: 2,
                                          ))
                                    ],
                                  ),
                                ));
                      },
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).backgroundColor,
                        backgroundImage:
                            NetworkImage(users[index_user].avatar_url),
                        // child: Icon(Icons.person)),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
          body: FutureBuilder(
              future: getNews(),
              builder: (context, snapshot) {
                // print(getResNews.length);
                return SizedBox(
                  width: size.width,
                  child: Visibility(
                      visible: isDataNews,
                      child: LoadingList(),
                      replacement: RefreshIndicator(
                          onRefresh: () {
                            getNewsImage();
                            getNews();
                            return Future<void>.delayed(
                                const Duration(seconds: 3), () {});
                          },
                          child:
      
                              // isDataNews
                              //     ?
                              ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: getResNews.length + 1,
                                  itemBuilder: (context, index) {
                                    Future.delayed(
                                        const Duration(seconds: 1), () {});
                                    if (index == 0) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 8.0, right: 8, bottom: 8),
                                            child: Text(
                                              "Новости",
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .backgroundColor),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          AspectRatio(
                                            aspectRatio: 16 / 9,
                                            child: FutureBuilder(
                                                future: getNewsImage(),
                                                builder: (context, snapshot) {
                                                  return PageView.builder(
                                                    physics:
                                                        const BouncingScrollPhysics(),
                                                    itemCount:
                                                        getResNewsImage.length,
                                                    itemBuilder:
                                                        (context, index) =>
                                                            Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 16.0,
                                                          vertical: 8),
                                                      child: Material(
                                                          clipBehavior: Clip
                                                              .antiAliasWithSaveLayer,
                                                          elevation: 5,
                                                          // color: Colors.grey[400],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          child: Stack(
                                                            alignment:
                                                                Alignment.center,
                                                            fit: StackFit.expand,
                                                            children: [
                                                              getResNewsImage[index]
                                                                          .url_f!
                                                                          .contains(
                                                                              'png') ||
                                                                      getResNewsImage[
                                                                              index]
                                                                          .url_f!
                                                                          .contains(
                                                                              'jpg')
                                                                  ? NewsImage(
                                                                      route:
                                                                          DetalNewPage(
                                                                        id: getResNewsImage[
                                                                                index]
                                                                            .id!,
                                                                        name: getResNewsImage[
                                                                                index]
                                                                            .name_n!,
                                                                        desc: getResNewsImage[
                                                                                index]
                                                                            .description_n!,
                                                                        time: getResNewsImage[
                                                                                index]
                                                                            .timestamp_n!,
                                                                        image: getResNewsImage[
                                                                                index]
                                                                            .url_f!,
                                                                      ),
                                                                      name: getResNewsImage[
                                                                              index]
                                                                          .name_n!,
                                                                      desc: getResNewsImage[
                                                                              index]
                                                                          .description_n!,
                                                                      time: getResNewsImage[
                                                                              index]
                                                                          .timestamp_n!,
                                                                      image: getResNewsImage[
                                                                              index]
                                                                          .url_f!,
                                                                    )
                                                                  : getResNewsImage[
                                                                              index]
                                                                          .url_f!
                                                                          .contains(
                                                                              'mp4')
                                                                      ? NewsImage(
                                                                          route:
                                                                              DetalNewPage(
                                                                            id: getResNewsImage[index]
                                                                                .id!,
                                                                            name:
                                                                                getResNewsImage[index].name_n!,
                                                                            desc:
                                                                                getResNewsImage[index].description_n!,
                                                                            time:
                                                                                getResNewsImage[index].timestamp_n!,
                                                                            image:
                                                                                getResNewsImage[index].url_f!,
                                                                          ),
                                                                          name: getResNewsImage[index]
                                                                              .name_n!,
                                                                          desc: getResNewsImage[index]
                                                                              .description_n!,
                                                                          time: getResNewsImage[index]
                                                                              .timestamp_n!,
                                                                          image: getResNewsImage[index]
                                                                              .thumbnail!,
                                                                        )
                                                                      : SizedBox(),
                                                              Positioned(
                                                                  bottom: 5,
                                                                  left: 10,
                                                                  right: 10,
                                                                  child: Text(
                                                                    getResNewsImage[
                                                                            index]
                                                                        .name_n!,
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            20),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    maxLines: 1,
                                                                  ))
                                                            ],
                                                          )),
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ],
                                      );
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: ClipRRect(
                                        borderRadius: index == 1
                                            ? BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10))
                                            : index == getResNews.length
                                                ? BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10))
                                                : BorderRadius.zero,
                                        child: Material(
                                          color: Theme.of(context)
                                              .appBarTheme
                                              .backgroundColor,
                                          // child: Padding(
                                          // padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Column(
                                            children: [
                                              News(
                                                  id: getResNews[index - 1].id,
                                                  name:
                                                      getResNews[index - 1].name_n,
                                                  image:
                                                      getResNews[index - 1].url_f,
                                                  desc: getResNews[index - 1]
                                                      .description_n,
                                                  time: getResNews[index - 1]
                                                      .timestamp_n!),
                                              index != getResNews.length
                                                  ? const Padding(
                                                      padding: EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8.0),
                                                      child: Divider(
                                                        thickness: 2.5,
                                                        // height: 5,
                                                        // color: Colors.grey[400],
                                                      ),
                                                    )
                                                  : SizedBox(),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // ),
                                    );
                                  })
                          // :
                          )),
                );
              }),
        ),
      ),
      // if (users[index_user].status == "admin"){
      floatingActionButton: users[index_user].status == "admin"
          ? FloatingActionButton.small(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const EditorNews()));
              },
              child: Icon(Icons.add),
            )
          : SizedBox(),
      // }
    );
  }
}

