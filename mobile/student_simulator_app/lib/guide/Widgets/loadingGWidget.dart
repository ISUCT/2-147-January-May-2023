import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../news/Widgets/shimmerWidget.dart';

class LoadingGWidget extends StatelessWidget {
  const LoadingGWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: 5,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(
          bottom: 5 - 1 == index ? 8 : 0,
          top: 0 != index ? 8 : 0,
          // bottom: 8.0
        ),
        child: Material(
          color: Theme.of(context).appBarTheme.backgroundColor,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundColor:
                          Theme.of(context).appBarTheme.backgroundColor,
                      child: ShimmerWidget(
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Theme.of(context).backgroundColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    ShimmerWidget(
                        child: Container(
                      width: size.width - 200,
                      height: 16,
                      color: Theme.of(context).backgroundColor,
                    )),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
                child: ShimmerWidget(
                    child: Container(
                  width: size.width - 150,
                  height: 20,
                  color: Theme.of(context).backgroundColor,
                )),
              ),
              AspectRatio(
                aspectRatio: 4 / 3,
                child: ShimmerWidget(
                    child: Container(
                  width: size.width - 200,
                  height: size.height,
                  color: Theme.of(context).backgroundColor,
                )),
              )
            ],
          ),
        ),
      ),
    );

  }
}
