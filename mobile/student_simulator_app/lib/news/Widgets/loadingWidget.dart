import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:student_simulator/news/Widgets/shimmerWidget.dart';

import 'CustomListTile.dart';

class LoadingList extends StatelessWidget {
  const LoadingList({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
                  child: Text(
                    "Новости",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(12),
                      child: Shimmer.fromColors(
                        baseColor: Theme.of(context).backgroundColor,
                        highlightColor:
                            Theme.of(context).appBarTheme.backgroundColor!,
                        child: Material(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Material(
              color: Theme.of(context).appBarTheme.backgroundColor,
              borderRadius: index == 1
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))
                  : index == 4
                      ? const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))
                      : BorderRadius.zero,
              child: Column(
                children: [
                  CustomListTile(
                    title: ShimmerWidget(
                        child: Container(
                      width: size.width - 200,
                      height: 16,
                      color: Theme.of(context).backgroundColor,
                    )),
                    subtitle: ShimmerWidget(
                        child: Container(
                      width: size.width - 275,
                      height: 14,
                      color: Theme.of(context).backgroundColor,
                    )),
                    trailing: ShimmerWidget(
                      child: Container(
                        height: 100,
                        width: 150,
                        color: Theme.of(context).backgroundColor,
                      ),
                    ),
                  ),
                  index != 4
                      ? const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Divider(
                            thickness: 2.5,
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            ),
          );
        });
  }
}
