import 'package:beer_app/model/webservice/beer/beer_with_brewery.dart';
import 'package:beer_app/model/webservice/beer/brewery.dart';
import 'package:beer_app/navigator/main_navigator.dart';
import 'package:beer_app/styles/theme_dimens.dart';
import 'package:beer_app/widget/provider/data_provider_widget.dart';
import 'package:flutter/material.dart';

class BreweryItem extends StatelessWidget {
  final Brewery brewery;

  const BreweryItem({
    required this.brewery,
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
                        brewery.name,
                        style: theme.coreTextTheme.bodyBig,
                      ),
                      Row(
                        children: [
                          Text(
                            brewery.address,
                            style: theme.coreTextTheme.bodyBig,
                          ),
                          const Text(" "),
                          Text(
                            brewery.city,
                            style: theme.coreTextTheme.bodyBig,
                          ),
                        ],
                      ),
                      Text(
                        brewery.country,
                        style: theme.coreTextTheme.bodyBig,
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
