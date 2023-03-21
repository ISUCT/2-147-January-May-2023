import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({required this.child, super.key});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: child,
      baseColor: Theme.of(context).backgroundColor,
      highlightColor: Theme.of(context).appBarTheme.backgroundColor!,
    );
  }
}
