import 'package:beer_app/model/webservice/beer/beer_with_brewery.dart';
import 'package:beer_app/navigator/main_navigator.dart';
import 'package:beer_app/styles/theme_dimens.dart';
import 'package:beer_app/widget/provider/data_provider_widget.dart';
import 'package:flutter/material.dart';

class BeerItem extends StatelessWidget {
  final BeerWithBrewery beerWithBrewery;
  final MainNavigator navigator;

  const BeerItem({
    required this.beerWithBrewery,
    required this.navigator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const List<int> ratingList = [0, 1, 2, 3, 4];
    return DataProviderWidget(
      // TODO: move onTap to this widget
      // TODO: research difference between ValueChanged and VoidCallback
      childBuilderTheme: (context, theme) => Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(
          horizontal: ThemeDimens.padding16,
          vertical: ThemeDimens.padding8,
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        beerWithBrewery.beer.name,
                        style: theme.coreTextTheme.bodyBig,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: ratingList
                            .map(
                              (i) => i < beerWithBrewery.beer.rating
                                  ? const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 24,
                                    )
                                  : const Icon(
                                      Icons.star,
                                      color: Colors.grey,
                                      size: 24,
                                    ),
                            )
                            .toList(),
                      ),
                      Text(
                        beerWithBrewery.brewery!.name,
                        style: theme.coreTextTheme.bodyNormal,
                      ),
                    ],
                  )),
            ),
            GestureDetector(
              onTap: () {
                navigator.goToBeerDetail(beerWithBrewery);
              },
              child: Hero(
                tag: beerWithBrewery.beer.id,
                transitionOnUserGestures: true,
                child: Image.network(
                  beerWithBrewery.beer.imageUrl != ""
                      ? beerWithBrewery.beer.imageUrl
                      : "https://freesvg.org/img/1515941353.png",
                  height: 120,
                  width: 120,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
