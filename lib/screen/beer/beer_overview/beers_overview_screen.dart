import 'package:beer_app/di/injectable.dart';
import 'package:beer_app/model/webservice/beer/beer_with_brewery.dart';
import 'package:beer_app/styles/theme_assets.dart';
import 'package:beer_app/styles/theme_dimens.dart';
import 'package:beer_app/util/keys.dart';
import 'package:beer_app/viewmodel/beer/beer_overview/beers_overview_viewmodel.dart';
import 'package:beer_app/widget/beer/beer_item.dart';
import 'package:beer_app/widget/general/action/action_item.dart';
import 'package:beer_app/widget/general/styled/beer_app_progress_indicator.dart';
import 'package:beer_app/widget/provider/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icapps_architecture/icapps_architecture.dart';

class BeersOverviewScreen extends StatefulWidget {
  const BeersOverviewScreen({super.key});

  @override
  BeersOverViewScreenState createState() => BeersOverViewScreenState();
}

@visibleForTesting
class BeersOverViewScreenState extends State<BeersOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<BeersOverViewViewModel>(
      create: () => getIt()..init(),
      consumerWithThemeAndLocalization: (context, viewModel, child, theme, localization) {
        final errorKey = viewModel.errorKey;
        return Scaffold(
          backgroundColor: theme.colorsTheme.background,
          appBar: AppBar(
            title: Text(localization.todoTitle),
            systemOverlayStyle: SystemUiOverlayStyle.light,
            centerTitle: context.isIOSTheme,
            backgroundColor: theme.colorsTheme.primary,
            actions: [
              ActionItem(
                key: Keys.downloadAction,
                svgAsset: ThemeAssets.downloadIcon(context),
                onClick: viewModel.onDownloadClicked,
                color: theme.colorsTheme.appBarAction,
              ),
              ActionItem(
                key: Keys.addAction,
                svgAsset: ThemeAssets.addIcon(context),
                onClick: viewModel.onAddClicked,
                color: theme.colorsTheme.appBarAction,
              ),
              // ActionItem(key: Keys.logoutButton, svgAsset: ThemeAssets.logoutIcon(context), onClick: viewModel.onLogoutClicked, color: theme.colorsTheme.appBarAction),
            ],
          ),
          body: Builder(
            builder: (context) {
              if (viewModel.isLoading) return Center(child: BeerAppProgressIndicator(dark: theme.isLightTheme));
              if (errorKey != null) {
                return Center(
                  child: Text(
                    localization.getTranslation(errorKey),
                    style: theme.coreTextTheme.bodyNormal.copyWith(color: theme.colorsTheme.errorText),
                  ),
                );
              }

              return Scrollbar(
                child: StreamBuilder<List<BeerWithBrewery>>(
                  stream: viewModel.dataBeerStream,
                  builder: (context, snapshot) {
                    final data = snapshot.data;
                    if (data == null) return const Center(child: Padding(padding: EdgeInsets.all(ThemeDimens.padding32), child: Text("List is empty")));
                    if (data.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(ThemeDimens.padding32),
                          child: Text(
                            localization.todoEmptyState,
                            textAlign: TextAlign.center,
                            style: theme.coreTextTheme.bodyNormal,
                          ),
                        ),
                      );
                    }
                    return ListView.separated(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final item = data[index];
                        return GestureDetector(
                            onTap: () {
                              viewModel.onBeerClicked(item);
                            },
                            child: BeerItem(beerWithBrewery: item, navigator: viewModel.navigator,));
                      },
                      separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: ThemeDimens.padding16),
                        child: Container(
                          height: 1,
                          color: theme.colorsTheme.primary.withOpacity(0.1),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
