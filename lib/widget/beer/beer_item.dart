import 'package:beer_app/model/webservice/beer/beer_with_brewery.dart';
import 'package:beer_app/styles/theme_dimens.dart';
import 'package:beer_app/widget/provider/data_provider_widget.dart';
import 'package:flutter/material.dart';

class BeerItem extends StatelessWidget {
  final BeerWithBrewery beerWithBrewery;

  const BeerItem({
    required this.beerWithBrewery,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DataProviderWidget(
      // TODO: move onTap to this widget
      // TODO: research difference between ValueChanged and VoidCallback
      childBuilderTheme: (context, theme) => GestureDetector(
        child: Container(
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
                        RichText(
                          text: TextSpan(
                            style: theme.coreTextTheme.bodyNormal,
                            children: [
                              TextSpan(
                                text: '${beerWithBrewery.beer.rating}/5',
                                style: theme.coreTextTheme.bodyNormal,
                              ),
                              const WidgetSpan(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 2.0),
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          beerWithBrewery.brewery!.name,
                          style: theme.coreTextTheme.bodyNormal,
                        ),
                      ],
                    )),
              ),
              Hero(tag: 'hero_$beerWithBrewery.beer.id', child: Image.network(beerWithBrewery.beer.thumbImageUrl)),
            ],
          ),
        ),
      ),
    );
  }
}
