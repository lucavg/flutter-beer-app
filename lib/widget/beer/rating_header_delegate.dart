import 'package:flutter/material.dart';

class RatingHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final int count;

  RatingHeaderDelegate({
    required this.title,
    required this.count,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        color: Colors.white,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            Text(
              "$count ${count > 1 ? "beers" : "beer"} with $title",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Icon(
              Icons.star,
              color: Colors.amber,
              size: 20,
            ),
          ],
        ));
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
