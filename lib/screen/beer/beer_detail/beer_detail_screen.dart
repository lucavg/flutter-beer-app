import 'package:beer_app/di/injectable.dart';
import 'package:beer_app/model/webservice/beer/beer.dart';
import 'package:beer_app/model/webservice/beer/beer_with_brewery.dart';
import 'package:beer_app/model/webservice/beer/brewery.dart';
import 'package:beer_app/navigator/route_names.dart';
import 'package:beer_app/styles/theme_dimens.dart';
import 'package:beer_app/viewmodel/beer/beer_detail/beer_detail_viewmodel.dart';
import 'package:beer_app/widget/beer/rating_bar_form_field.dart';
import 'package:beer_app/widget/general/styled/beer_app_button.dart';
import 'package:beer_app/widget/general/styled/beer_app_progress_indicator.dart';
import 'package:beer_app/widget/provider/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icapps_architecture/icapps_architecture.dart';

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
        final Brewery brewery = Brewery(
            id: viewModel.beerWithBrewery.brewery!.id.isNotEmpty
                ? viewModel.beerWithBrewery.brewery!.id
                : "No brewery linked yet!",
            name: viewModel.beerWithBrewery.brewery!.name.isNotEmpty
                ? viewModel.beerWithBrewery.brewery!.name
                : "",
            address: viewModel.beerWithBrewery.brewery!.address.isNotEmpty
                ? viewModel.beerWithBrewery.brewery!.address
                : "",
            city: viewModel.beerWithBrewery.brewery!.city.isNotEmpty
                ? viewModel.beerWithBrewery.brewery!.city
                : "",
            country: viewModel.beerWithBrewery.brewery!.country.isNotEmpty
                ? viewModel.beerWithBrewery.brewery!.country
                : "");
        final errorKey = viewModel.errorKey;
        return Scaffold(
          backgroundColor: theme.colorsTheme.background,
          appBar: AppBar(
            title: Text(beer.name),
            systemOverlayStyle: SystemUiOverlayStyle.light,
            centerTitle: context.isIOSTheme,
            backgroundColor: theme.colorsTheme.primary,
            actions: const [
              // ActionItem(
              //     key: Keys.logoutButton,
              //     svgAsset: ThemeAssets.logoutIcon(context),
              //     onClick: viewModel.onLogoutClicked,
              //     color: theme.colorsTheme.appBarAction),
            ],
          ),
          body: Builder(
            builder: (context) {
              if (viewModel.isLoading) {
                return Center(
                    child: BeerAppProgressIndicator(dark: theme.isLightTheme));
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

                        /// This is the important part, we need [Hero] widget with unique tag but same as Hero's tag in [User] widget.
                        child: Hero(
                          tag: beer.id,
                          transitionOnUserGestures: true,
                          child: Image.network(
                            viewModel.hasImage
                                ? beer.imageUrl
                                : "https://freesvg.org/img/1515941353.png",
                            height: MediaQuery.of(context).size.height * 0.25,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(ThemeDimens.padding32),
                        child: Column(
                          children: [
                            Text(
                              beer.name,
                              style: const TextStyle(fontSize: 22),
                            ),
                            RatingBarFormField(
                              maxStars: 5,
                              currentRating: viewModel.currentRating,
                              onRatingChanged: (value) =>
                                  viewModel.updateRating(value),
                            ),
                            Text(
                              brewery.name,
                              style: const TextStyle(fontSize: 18),
                            ),
                            Text(
                              "${brewery.address} ${brewery.city}",
                            ),
                            Text(
                              brewery.country,
                            ),
                            // const Divider(),
                            // SizedBox(
                            //   height: 450,
                            //   width: 400,
                            //   child: FlutterMap(
                            //     options: MapOptions(
                            //       center: LatLng(51.509364, -0.128928),
                            //       zoom: 9.2,
                            //       maxZoom: 22,
                            //     ),
                            //     children: [
                            //       TileLayer(
                            //         urlTemplate:
                            //             'https://tile.thunderforest.com/atlas/{z}/{x}/{y}.png?apikey=8f6cd8800b8d436c890dccf078f972a8',
                            //         subdomains: const ['a', 'b', 'c'],
                            //         additionalOptions: const {
                            //           'style':
                            //               'https://tile.thunderforest.com/atlas/{z}/{x}/{y}.png?apikey=8f6cd8800b8d436c890dccf078f972a8',
                            //           'apiKey':
                            //               '8f6cd8800b8d436c890dccf078f972a8',
                            //         },
                            //         maxZoom: 22,
                            //         userAgentPackageName: 'com.example.map',
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          bottomNavigationBar: Visibility(
            visible: viewModel.ratingUpdated,
            child: BeerAppButton(
              text: "Save rating",
              onClick: () {
                viewModel.updateBeer();
                _showToast(context);
              },
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
      content: const Text('Beer rating updated!'),
      action: SnackBarAction(
          label: 'CLOSE', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}
