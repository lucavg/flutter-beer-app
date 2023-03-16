import 'package:beer_app/model/webservice/beer/beer_with_brewery.dart';
import 'package:beer_app/navigator/main_navigator.dart';
import 'package:flutter/material.dart';
import 'package:icapps_architecture/icapps_architecture.dart';

class BeerItem extends StatelessWidget {
  final BeerWithBrewery beerWithBrewery;
  final MainNavigator navigator;

  const BeerItem({
    required this.beerWithBrewery,
    required this.navigator,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const List<int> ratingList = [0, 1, 2, 3, 4];
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => navigator.goToBeerDetail(beerWithBrewery),
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      beerWithBrewery.beer.name,
                      style: theme.textTheme.titleLarge,
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
                  ],
                ),
              ),
            ),
            Hero(
              tag: beerWithBrewery.beer.id,
              transitionOnUserGestures: true,
              child: FadeInImage(
                placeholder: const AssetImage(
                    'assets/images/placeholder.png'),
                image: NetworkImage(
                  beerWithBrewery.beer.thumbImageUrl,
                ),
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 200),
                fadeOutDuration: const Duration(milliseconds: 200),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
