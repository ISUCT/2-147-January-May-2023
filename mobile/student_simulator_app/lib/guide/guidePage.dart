import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:student_simulator/guide/Model/guideModel.dart';
import 'package:student_simulator/guide/Widgets/loadingGWidget.dart';
import 'package:student_simulator/guide/editorGuides.dart';

import '../APIs_draft/apiGuide.dart';
import '../main.dart';
import 'Widgets/guides.dart';

class GuidePage extends StatefulWidget {
  const GuidePage({super.key});

  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    super.build(context);
    return Scaffold(
        body: SafeArea(
      child: RefreshIndicator(
        // color: Colors.blue,
        onRefresh: (() async {
          return Future<void>.delayed(const Duration(seconds: 1), () {
            setState(() {
              getGuide();
            });
          });
        }),
        child: CustomScrollView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                snap: false,
                floating: true,
                pinned: false,
                // backgroundColor: Colors.white,
                actions: [
                  IconButton(
                    splashRadius: 20,
                    icon: const Icon(Icons.add),
                    // color: Colors.black,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const EditorGuides()));
                    },
                  ),
                  IconButton(
                    splashRadius: 20,
                    icon: const Icon(EvaIcons.search),
                    // color: Colors.black,
                    onPressed: () {},
                  ),
                ],
              ),
              FutureBuilder(
                  future: getGuide(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (isData) {
                      Future.delayed(const Duration(seconds: 1), () {});
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, index) {
                            return Padding(
                                padding: EdgeInsets.only(
                                    bottom: guides.length - 1 == index ? 8 : 0,
                                    top: 8.0),
                                child: Guides(
                                    id: guides[index].id,
                                    name: guides[index].name_g,
                                    desc: guides[index].description_g,
                                    url_f: guides[index].url_f,
                                    time: guides[index].timestamp_g!));
                          },
                          childCount: guides.length,
                        ),
                      );
                    } else {
                      return const SliverFillRemaining(child: LoadingGWidget());
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
            ]),
      ),
    ));
  }
  
  @override
  bool get wantKeepAlive => true;
}
