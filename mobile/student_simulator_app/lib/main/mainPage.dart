// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:student_simulator/main/Widgets/CustomListTile.dart';
import 'package:student_simulator/main/Widgets/shimmerWidget.dart';
import 'package:student_simulator/main/Widgets/news.dart';
import 'package:student_simulator/main/Widgets/newsImage.dart';
import 'package:student_simulator/main/detalNewPage.dart';
import '../api/apiNews.dart';
import '../data/Users.dart';

int countSendEmail = 0;

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar:
      body: NestedScrollView(
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
                                      backgroundColor: Colors.blue,
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
                      backgroundColor: Colors.blue,
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
        body: RefreshIndicator(
          onRefresh: () {
            getNewsImage();
            getNews();
            return Future<void>.delayed(const Duration(seconds: 3), () {});
          },
          child: FutureBuilder(
              future: getNews(),
              builder: (context, snapshot) {
                return SizedBox(
                    width: size.width,
                    child: isDataNews
                        ? ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: getResNews.length + 1,
                            itemBuilder: (context, index) {
                              Future.delayed(const Duration(seconds: 1), () {});
                              if (index == 0) {
                                return Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          left: 8.0, right: 8, bottom: 8),
                                      child: Text(
                                        "Новости",
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
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
                                              itemCount: getResNewsImage.length,
                                              itemBuilder: (context, index) =>
                                                  Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16.0,
                                                        vertical: 8),
                                                child: Material(
                                                    clipBehavior: Clip
                                                        .antiAliasWithSaveLayer,
                                                    elevation: 5,
                                                    // color: Colors.grey[400],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    child: NewsImage(
                                                      route: DetalNewPage(
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
                                                      name:
                                                          getResNewsImage[index]
                                                              .name_n!,
                                                      desc:
                                                          getResNewsImage[index]
                                                              .description_n!,
                                                      time:
                                                          getResNewsImage[index]
                                                              .timestamp_n!,
                                                      image:
                                                          getResNewsImage[index]
                                                              .url_f!,
                                                    )),
                                              ),
                                            );
                                          }),
                                    ),
                                  ],
                                );
                              }
                              return Column(
                                children: [
                                  News(
                                      name: getResNews[index - 1].name_n,
                                      image: getResNews[index - 1].url_f,
                                      desc: getResNews[index - 1].description_n,
                                      time: getResNews[index - 1].timestamp_n!),
                                  Divider(
                                    height: 2,
                                    color: Colors.grey[400],
                                  ),
                                ],
                              );
                            })
                        : ListView.builder(
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          left: 8.0, right: 8, bottom: 8),
                                      child: Text(
                                        "Новости",
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    AspectRatio(
                                      aspectRatio: 16 / 9,
                                      child: PageView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: 1,
                                        itemBuilder: (context, index) =>
                                            Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0, vertical: 8),
                                          child: Shimmer.fromColors(
                                            baseColor: Colors.grey[400]!,
                                            highlightColor: Colors.grey[300]!,
                                            child: Material(
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              elevation: 5,
                                              // color: Colors.grey[300],
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return Column(
                                children: [
                                  CustomListTile(
                                    title: ShimmerWidget(
                                        child: Container(
                                      width: size.width - 200,
                                      height: 16,
                                      color: Colors.grey[400],
                                    )),
                                    subtitle: ShimmerWidget(
                                        child: Container(
                                      width: size.width - 275,
                                      height: 14,
                                      color: Colors.grey[400],
                                    )),
                                    trailing: ShimmerWidget(
                                      child: Container(
                                        height: 100,
                                        width: 150,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }));
              }),
        ),
      ),
    );
  }
}
