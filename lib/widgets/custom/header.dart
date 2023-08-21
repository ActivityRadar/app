import 'package:flutter/material.dart';

class CustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  CustomHeaderDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 100.0;

  @override
  double get minExtent => 100.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
