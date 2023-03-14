import 'package:beer_app/model/webservice/beer/brewery.dart';
import 'package:beer_app/styles/theme_dimens.dart';
import 'package:beer_app/widget/provider/data_provider_widget.dart';
import 'package:flutter/material.dart';

class BreweryItem extends StatelessWidget {
  final Brewery? brewery;

  const BreweryItem({
    required this.brewery,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DataProviderWidget(
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      brewery!.name,
                      style: theme.coreTextTheme.titleNormal,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${brewery!.address} ${brewery!.city}",
                          style: theme.coreTextTheme.bodyNormal,
                        ),
                      ],
                    ),
                    Text(
                      brewery!.country,
                      style: theme.coreTextTheme.bodyNormal,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
