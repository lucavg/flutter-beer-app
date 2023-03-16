import 'package:flutter/material.dart';

class BreweryHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final int count;

  BreweryHeaderDelegate({
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        "$title: $count beers",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,

        ),
      ),
    );
  }

  @override
  double get maxExtent => 40.0;

  @override
  double get minExtent => 40.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}