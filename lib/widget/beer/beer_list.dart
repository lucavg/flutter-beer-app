import 'dart:collection';

import 'package:beer_app/model/webservice/beer/beer_with_brewery.dart';
import 'package:beer_app/model/webservice/beer/brewery.dart';
import 'package:beer_app/model/webservice/beer/group_option.dart';
import 'package:beer_app/model/webservice/beer/sort_option.dart';
import 'package:beer_app/navigator/main_navigator.dart';
import 'package:beer_app/styles/theme_data.dart';
import 'package:beer_app/util/locale/localization.dart';
import 'package:beer_app/widget/beer/beer_grid_item.dart';
import 'package:beer_app/widget/beer/beer_item.dart';
import 'package:beer_app/widget/beer/brewery_header_delegate.dart';
import 'package:beer_app/widget/beer/rating_header_delegate.dart';
import 'package:flutter/material.dart';
import "package:collection/collection.dart";

class BeerList extends StatelessWidget {
  final List<BeerWithBrewery> beerList;
  final MainNavigator navigator;
  final GroupOption groupOption;
  final SortOption sortOption;
  final BeerAppTheme theme;
  final bool isGridView;

  const BeerList({
    required this.beerList,
    required this.navigator,
    required this.theme,
    required this.sortOption,
    required this.groupOption,
    required this.isGridView,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<BeerWithBrewery> sortedList = sortList();
    Map<dynamic, List<BeerWithBrewery>?> beerMap =
        <dynamic, List<BeerWithBrewery>>{};
    if (groupOption == GroupOption.BREWERY) {
      beerMap = groupListByBrewery(sortedList);
    } else if (groupOption == GroupOption.RATING) {
      beerMap = groupListByRating(sortedList);
    }

    if (isGridView) {
      if (beerMap.isEmpty) {
        return CustomScrollView(
          slivers: [
            SliverPadding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _getCrossAxisCount(context),
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.75,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final BeerWithBrewery beer = sortedList[index];
                    return BeerGridItem(
                      beerWithBrewery: beer,
                      theme: theme,
                      navigator: navigator,
                    );
                  },
                  childCount: sortedList.length,
                ),
              ),
            ),
          ],
        );
      }
      return CustomScrollView(
        slivers: beerMap.keys
            .map((dynamic key) {
              if (key is Brewery) {
                // Show the list of beers grouped by brewery
                return [
                  SliverPersistentHeader(
                    delegate: BreweryHeaderDelegate(
                      title: key.name,
                      count: beerMap[key]!.length,
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 8.0,
                    ),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: _getCrossAxisCount(context),
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 0.75,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final BeerWithBrewery beer = beerMap[key]![index];
                          return BeerGridItem(
                            beerWithBrewery: beer,
                            theme: theme,
                            navigator: navigator,
                          );
                        },
                        childCount: beerMap[key]?.length,
                      ),
                    ),
                  ),
                ];
              } else if (key is int) {
                // Show the list of beers grouped by rating
                final List<BeerWithBrewery> beers = beerMap[key]!;
                return [
                  SliverPersistentHeader(
                    delegate: RatingHeaderDelegate(
                      count: beers.length,
                      title: key.toString(),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 8.0,
                    ),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: _getCrossAxisCount(context),
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 0.75,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final BeerWithBrewery beer = beerMap[key]![index];
                          return BeerGridItem(
                            beerWithBrewery: beer,
                            theme: theme,
                            navigator: navigator,
                          );
                        },
                        childCount: beerMap[key]?.length,
                      ),
                    ),
                  ),
                ];
              } else {
                throw ArgumentError(Localization().beerListKeyError + key.runtimeType.toString());
              }
            })
            .expand((slivers) => slivers)
            .toList(),
      );
    } else {
      if (beerMap.isEmpty) {
        return CustomScrollView(
          slivers: [
            SliverPadding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final BeerWithBrewery beer = sortedList[index];
                    return BeerItem(
                      beerWithBrewery: beer,
                      navigator: navigator,
                    );
                  },
                  childCount: sortedList.length,
                ),
              ),
            ),
          ],
        );
      }
      return CustomScrollView(
        slivers: beerMap.keys
            .map((dynamic key) {
              if (key is Brewery) {
                // Show the list of beers grouped by brewery
                return [
                  SliverPersistentHeader(
                    delegate: BreweryHeaderDelegate(
                      title: key.name,
                      count: beerMap[key]!.length,
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 8.0,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final BeerWithBrewery beer = beerMap[key]![index];
                          return BeerItem(
                            beerWithBrewery: beer,
                            navigator: navigator,
                          );
                        },
                        childCount: beerMap[key]?.length,
                      ),
                    ),
                  ),
                ];
              } else if (key is int) {
                // Show the list of beers grouped by rating
                final List<BeerWithBrewery> beers = beerMap[key]!;
                return [
                  SliverPersistentHeader(
                    delegate: RatingHeaderDelegate(
                      count: beers.length,
                      title: key.toString(),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 8.0,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final BeerWithBrewery beer = beers[index];
                          return BeerItem(
                            beerWithBrewery: beer,
                            navigator: navigator,
                          );
                        },
                        childCount: beers.length,
                      ),
                    ),
                  ),
                ];
              } else {
                throw ArgumentError(Localization().beerListKeyError + key.runtimeType.toString());
              }
            })
            .expand((slivers) => slivers)
            .toList(),
      );
    }
  }

  List<BeerWithBrewery> sortList() {
    switch (sortOption) {
      case SortOption.RATINGDESCENDING:
        {
          beerList.sort((a, b) => a.beer.rating.compareTo(b.beer.rating));
          return beerList;
        }
      case SortOption.RATINGASCENDING:
        {
          beerList.sort((a, b) => b.beer.rating.compareTo(a.beer.rating));
          return beerList;
        }
      default:
        {
          beerList.sort((a, b) => a.beer.name.compareTo(b.beer.name));
          return beerList;
        }
    }
  }

  Map<dynamic, List<BeerWithBrewery>?> groupListByBrewery(
      List<BeerWithBrewery> listToGroup) {
    final groups = groupBy(listToGroup, (beer) => beer.brewery!.id);
    final groupedMap = groups.map(
      (breweryId, beerList) => MapEntry(
        beerList.first.brewery!,
        beerList,
      ),
    );
    return SplayTreeMap<Brewery, List<BeerWithBrewery>>.from(
      groupedMap,
      (a, b) => a.name.compareTo(b.name),
    );
  }

  Map<dynamic, List<BeerWithBrewery>?> groupListByRating(
      List<BeerWithBrewery> beers) {
    final groupedBeers = groupBy(beers, (beer) => beer.beer.rating);
    final sortedKeys = groupedBeers.keys.toList()
      ..sort((a, b) => b.compareTo(a));
    final sortedGroups = {for (var k in sortedKeys) k: groupedBeers[k]};
    return sortedGroups;
  }

  int _getCrossAxisCount(BuildContext context) {
    if (MediaQuery.of(context).size.width > 400) {
      return 3;
    } else if (MediaQuery.of(context).size.width > 200) {
      return 2;
    } else {
      return 1;
    }
  }
}
