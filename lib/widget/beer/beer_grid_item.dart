import 'package:beer_app/model/webservice/beer/beer_with_brewery.dart';
import 'package:beer_app/navigator/main_navigator.dart';
import 'package:beer_app/widget/provider/data_provider_widget.dart';
import 'package:flutter/material.dart';

class BeerGridItem extends StatelessWidget {
  final BeerWithBrewery? beerWithBrewery;
  final MainNavigator navigator;

  const BeerGridItem({
    required this.beerWithBrewery,
    required this.navigator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DataProviderWidget(
      childBuilderTheme: (context, theme) => GestureDetector(
        onTap: () => navigator.goToBeerDetail(beerWithBrewery!),
        child: Hero(
          tag: beerWithBrewery!.beer.id,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(beerWithBrewery!.beer.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          beerWithBrewery!.beer.rating.toString(),
                          style: theme.coreTextTheme.bodyNormal,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  right: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      beerWithBrewery!.beer.name,
                      style: theme.coreTextTheme.bodyNormal,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
