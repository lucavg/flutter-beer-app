import 'package:beer_app/di/injectable.dart';
import 'package:beer_app/model/webservice/beer/beer_with_brewery.dart';
import 'package:beer_app/model/webservice/beer/group_option.dart';
import 'package:beer_app/model/webservice/beer/sort_option.dart';
import 'package:beer_app/styles/theme_assets.dart';
import 'package:beer_app/styles/theme_dimens.dart';
import 'package:beer_app/util/keys.dart';
import 'package:beer_app/viewmodel/beer/beers_overview/beers_overview_viewmodel.dart';
import 'package:beer_app/widget/beer/beer_list.dart';
import 'package:beer_app/widget/general/action/action_item.dart';
import 'package:beer_app/widget/general/styled/beer_app_button.dart';
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
      consumerWithThemeAndLocalization:
          (context, viewModel, child, theme, localization) {
        final errorKey = viewModel.errorKey;
        return Scaffold(
            backgroundColor: theme.colorsTheme.background,
            appBar: AppBar(
              title: Text(localization.beerOverviewTitle),
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
                ActionItem(
                    key: Keys.logoutButton,
                    svgAsset: ThemeAssets.logoutIcon(context),
                    onClick: viewModel.onLogoutClicked,
                    color: theme.colorsTheme.appBarAction),
              ],
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
                    child: StreamBuilder<List<BeerWithBrewery>>(
                      stream: viewModel.dataBeerStream,
                      builder: (context, snapshot) {
                        final data = snapshot.data;
                        if (data == null) {
                          return Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.all(ThemeDimens.padding32),
                              child: Text(localization.beerOverviewEmpty),
                            ),
                          );
                        }
                        if (data.isEmpty) {
                          return Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.all(ThemeDimens.padding32),
                              child: Text(
                                localization.beerEmptyState,
                                textAlign: TextAlign.center,
                                style: theme.coreTextTheme.bodyNormal,
                              ),
                            ),
                          );
                        }
                        return Center(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: DropdownButton<SortOption>(
                                      value: viewModel.sortOption,
                                      hint: Text(localization.beerOverviewSort),
                                      onChanged: (option) {
                                        viewModel
                                            .onSortingOptionChanged(option!);
                                      },
                                      items: [
                                        DropdownMenuItem(
                                          value: SortOption.NAMEASCENDING,
                                          child: Text(localization
                                              .beerOverviewSortName),
                                        ),
                                        DropdownMenuItem(
                                          value: SortOption.RATINGDESCENDING,
                                          child: Text(localization
                                              .beerOverviewSortRatingDown),
                                        ),
                                        DropdownMenuItem(
                                          value: SortOption.RATINGASCENDING,
                                          child: Text(localization
                                              .beerOverviewSortRatingUp),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: DropdownButton<GroupOption>(
                                      value: viewModel.groupOption,
                                      hint:
                                          Text(localization.beerOverviewGroup),
                                      onChanged: (option) {
                                        viewModel.onGroupOptionChanged(option!);
                                      },
                                      items: [
                                        DropdownMenuItem(
                                            value: GroupOption.NONE,
                                            child: Text(localization
                                                .beerOverviewGroupNone)),
                                        DropdownMenuItem(
                                          value: GroupOption.BREWERY,
                                          child: Text(localization
                                              .beerOverviewGroupBrewery),
                                        ),
                                        DropdownMenuItem(
                                          value: GroupOption.RATING,
                                          child: Text(localization
                                              .beerOverviewGroupRating),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: BeerAppButton(
                                      text: localization.beerOverviewViewToggle,
                                      buttonType: ButtonType.text,
                                      onClick: () =>
                                          viewModel.onViewToggleClicked(),
                                    ),
                                  ),
                                ],
                              ),
                              Flexible(
                                child: BeerList(
                                  beerList: data,
                                  theme: theme,
                                  navigator: viewModel.navigator,
                                  isGridView: viewModel.isGridView,
                                  sortOption: viewModel.sortOption,
                                  groupOption: viewModel.groupOption,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ));
      },
    );
  }
}
