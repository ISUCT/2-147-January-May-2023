import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:postgres/postgres.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:student_simulator/data/Users.dart';
import 'package:student_simulator/guide/Model/guideModel.dart';
import 'package:student_simulator/guide/detalGuidePage.dart';

import '../api/apiGuide.dart';

// import '';

class GuidePage extends StatefulWidget {
  const GuidePage({super.key});

  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  static final cachedImage = CacheManager(Config(
    'cache1',
    stalePeriod: const Duration(days: 15),
    maxNrOfCacheObjects: 100,
  ));
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: RefreshIndicator(
      color: Colors.blue,
      onRefresh: (() async {
        return Future<void>.delayed(const Duration(seconds: 3), () {
          setState(() {
            getGuide();
          });
        });
      }),
      child: CustomScrollView(physics: BouncingScrollPhysics(), slivers: [
        SliverAppBar(
          snap: false,
          floating: true,
          pinned: false,
          // backgroundColor: Colors.white,
          actions: [
            IconButton(
              splashRadius: 20,
              icon: Icon(EvaIcons.search),
              // color: Colors.black,
              onPressed: () {},
            ),
          ],
        ),
        FutureBuilder(
            future: getGuide(),
            builder: (context, AsyncSnapshot snapshot) {
              if (isData) {
                Future.delayed(Duration(seconds: 1), () {});
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Material(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => detalGuidePage(
                                        name: guides[index].name_g,
                                        description:
                                            guides[index].description_g,
                                        datetime: guides[index].timestamp_g,
                                        user: users[0].username)),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Colors.blue,
                                        backgroundImage: NetworkImage(
                                            users[index_user].avatar_url),
                                        foregroundImage: NetworkImage(
                                            users[index_user].avatar_url),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            // width: ,
                                            child: Text(
                                              users[index_user].username,
                                              maxLines: 1,
                                              softWrap: false,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          if (users[index_user].verifed)
                                            const Icon(
                                              BoxIcons.bxs_badge_check,
                                              color: Colors.blue,
                                              size: 19,
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8.0, left: 8.0, right: 8.0),
                                  child: Text(
                                    // '',
                                    guides[index].name_g,
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                guides[index].url_f[0] != null
                                    ? AspectRatio(
                                      aspectRatio: 4/3,
                                      child: CachedNetworkImage(
                                          cacheManager: cachedImage,
                                          imageUrl: guides[index].url_f[0] == null
                                              ? ''
                                              : guides[index].url_f[0]!,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              Container(
                                            color: Colors.grey[400],
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Container(
                                            color: Colors.grey[400],
                                            alignment: Alignment.center,
                                            child: Icon(
                                              Icons.error,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                    )
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          // '',
                                          guides[index].description_g,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      // TextButton(onPressed: (){}, child: Text('-', style: TextStyle(fontSize: 20),)),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          EvaIcons.minus_outline,
                                          size: 20,
                                        ),
                                        splashRadius: 20,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        // '',
                                        guides[index].like_g.toString(),
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          EvaIcons.plus_outline,
                                          size: 20,
                                        ),
                                        splashRadius: 20,
                                      ),
                                      // TextButton(style: ButtonStyle(foregroundColor: ),onPressed: (){}, child: Text('+', style: TextStyle(fontSize: 20))),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: guides.length,
                  ),
                  // physics: BouncingScrollPhysics(),
                  // itemCount: guides.length,
                  // itemBuilder: (context, index) {
                );
              } else {
                return SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()));
                // Future.delayed(Duration(seconds: 15), () {
                //   );
                // });
                // return SliverFillRemaining(
                //     child: Center(
                //   child: Text(
                //     "Произошла ошибка(\nВернитесь позже",
                //     style: TextStyle(
                //       fontSize: 20,
                //     ),
                //     textAlign: TextAlign.center,
                //   ),
                // ));
                //  Center(child: CircularProgressIndicator());
                // }
              }
            })
        // : SliverFillRemaining(
        //     child: Center(
        //       child: Text(
        //         "Произошла ошибка(\nВернитесь позже",
        //         style: TextStyle(
        //           fontSize: 20,
        //         ),
        //         textAlign: TextAlign.center,
        //       ),
        //     ),
        //   )
        // }),
      ]),
    ));
  }
}

// Future operation() async {
//   try {
//     var connection = PostgreSQLConnection(
//         "185.251.89.150",
//         5432, // port
//         "sumilardb", // databaseName
//         username: "oleg",
//         password: "post_23",
//         useSSL: true);

//     // await connection.open();
//     print("Connected");
//     // await connection.close();
//   } catch (e) {
//     print("exep: $e");
//   }
//   print("Connected");
// }
