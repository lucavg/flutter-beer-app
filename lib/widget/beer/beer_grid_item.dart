import 'package:beer_app/model/webservice/beer/beer_with_brewery.dart';
import 'package:beer_app/navigator/main_navigator.dart';
import 'package:beer_app/styles/theme_data.dart';
import 'package:beer_app/widget/provider/data_provider_widget.dart';
import 'package:flutter/material.dart';

class BeerGridItem extends StatelessWidget {
  final BeerWithBrewery? beerWithBrewery;
  final BeerAppTheme theme;
  final MainNavigator navigator;

  const BeerGridItem({
    required this.beerWithBrewery,
    required this.navigator,
    required this.theme,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final beer = beerWithBrewery!.beer;

    Widget buildTitle() {
      return Text(
        beer.name,
        style: theme.coreTextTheme.bodyNormal,
        textAlign: TextAlign.center,
      );
    }

    Widget buildRating() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.star,
            color: Colors.amber,
            size: 16,
          ),
          Text(
            beer.rating.toString(),
            style: theme.coreTextTheme.bodyNormal,
          ),
        ],
      );
    }

    return DataProviderWidget(
      childBuilderTheme: (context, theme) => InkWell(
        onTap: () => navigator.goToBeerDetail(beerWithBrewery!),
        child: Card(
          elevation: 4,
          margin: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Hero(
                tag: beer.id,
                child: FadeInImage(
                  placeholder: const AssetImage(
                      'assets/images/placeholder.png'),
                  image: NetworkImage(
                    beer.imageUrl,
                  ),
                  fit: BoxFit.cover,
                  fadeInDuration: const Duration(milliseconds: 200),
                  fadeOutDuration: const Duration(milliseconds: 200),
                ),
              ),
              const SizedBox.shrink(),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildTitle(),
                    buildRating(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
