import 'package:beer_app/di/injectable.dart';
import 'package:beer_app/model/webservice/beer/beer.dart';
import 'package:beer_app/model/webservice/beer/beer_with_brewery.dart';
import 'package:beer_app/model/webservice/beer/brewery.dart';
import 'package:beer_app/navigator/route_names.dart';
import 'package:beer_app/styles/theme_dimens.dart';
import 'package:beer_app/util/locale/localization.dart';
import 'package:beer_app/util/locale/localization_keys.dart';
import 'package:beer_app/viewmodel/beer/beer_detail/beer_detail_viewmodel.dart';
import 'package:beer_app/viewmodel/beer/beers_overview/beers_overview_viewmodel.dart';
import 'package:beer_app/widget/beer/rating_bar_form_field.dart';
import 'package:beer_app/widget/brewery/brewery_item.dart';
import 'package:beer_app/widget/general/styled/beer_app_button.dart';
import 'package:beer_app/widget/general/styled/beer_app_progress_indicator.dart';
import 'package:beer_app/widget/provider/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:icapps_architecture/icapps_architecture.dart';
import 'package:latlong2/latlong.dart';

class BeerDetailScreen extends StatefulWidget {
  static const String routeName = RouteNames.beerDetailScreen;
  final BeerWithBrewery beerWithBrewery;

  const BeerDetailScreen({super.key, required this.beerWithBrewery});

  @override
  BeerDetailScreenState createState() => BeerDetailScreenState();
}

@visibleForTesting
class BeerDetailScreenState extends State<BeerDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<BeerDetailViewModel>(
      create: () => getIt()..init(widget.beerWithBrewery),
      consumerWithThemeAndLocalization:
          (context, viewModel, child, theme, localization) {
        final Beer beer = viewModel.beerWithBrewery.beer;
        final Brewery? brewery = viewModel.beerWithBrewery.brewery;
        final errorKey = viewModel.errorKey;
        return Scaffold(
          backgroundColor: theme.colorsTheme.background,
          appBar: AppBar(
            title: Text(beer.name),
            systemOverlayStyle: SystemUiOverlayStyle.light,
            centerTitle: context.isIOSTheme,
            backgroundColor: theme.colorsTheme.primary,
            actions: const [],
          ),
          body: SafeArea(
            child: Builder(
              builder: (context) {
                if (viewModel.isLoading) {
                  return Center(
                      child:
                          BeerAppProgressIndicator(dark: theme.isLightTheme));
                }
                if (errorKey != null) {
                  return Center(
                    child: Text(
                      localization.getTranslation(errorKey),
                      style: theme.coreTextTheme.bodyNormal
                          .copyWith(color: theme.colorsTheme.errorText),
                    ),
                  );
                }

                return Scrollbar(
                  child: Center(
                    child: ListView(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: Hero(
                            tag: beer.id,
                            transitionOnUserGestures: true,
                            child: FadeInImage(
                              placeholder: const AssetImage(
                                  'assets/images/placeholder.png'),
                              image: NetworkImage(
                                beer.imageUrl,
                              ),
                              fit: BoxFit.cover,
                              fadeInDuration: const Duration(milliseconds: 200),
                              fadeOutDuration:
                                  const Duration(milliseconds: 200),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(ThemeDimens.padding32),
                          child: Column(
                            children: [
                              Text(
                                beer.name,
                                style: theme.coreTextTheme.titleBig,
                                textAlign: TextAlign.center,
                              ),
                              RatingBarFormField(
                                maxStars: 5,
                                currentRating: viewModel.currentRating,
                                onRatingChanged: (value) =>
                                    viewModel.updateRating(value),
                              ),
                              BreweryItem(brewery: brewery)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: SizedBox(
                            height: 360,
                            width: 180,
                            child: FlutterMap(
                              mapController: viewModel.mapController,
                              options: MapOptions(
                                center: viewModel.latLng,
                                zoom: 9.2,
                                maxZoom: 22,
                              ),
                              children: [
                                TileLayer(
                                  urlTemplate:
                                      'https://tile.thunderforest.com/atlas/{z}/{x}/{y}.png?apikey=8f6cd8800b8d436c890dccf078f972a8',
                                  subdomains: const ['a', 'b', 'c'],
                                  additionalOptions: const {
                                    'style':
                                        'https://tile.thunderforest.com/atlas/{z}/{x}/{y}.png?apikey=8f6cd8800b8d436c890dccf078f972a8',
                                    'apiKey':
                                        '8f6cd8800b8d436c890dccf078f972a8',
                                  },
                                  maxZoom: 22,
                                  userAgentPackageName: 'com.example.map',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          bottomNavigationBar: Visibility(
            visible: viewModel.ratingUpdated,
            child: SafeArea(
              child: BeerAppButton(
                text: localization.beerDetailSaveRating,
                onClick: () {
                  viewModel.updateBeer();
                  _showToast(context);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

void _showToast(BuildContext context) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(Localization().beerDetailSaveRating),
      action: SnackBarAction(
          label: Localization().beerDetailCloseToast,
          onPressed: scaffold.hideCurrentSnackBar),
      duration: const Duration(seconds: 5),
    ),
  );
}
