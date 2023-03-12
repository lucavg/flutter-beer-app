import 'package:beer_app/model/webservice/beer/brewery.dart';
import 'package:beer_app/viewmodel/beer/beer_add/beer_add_viewmodel.dart';
import 'package:beer_app/widget/general/styled/beer_app_back_button.dart';
import 'package:beer_app/widget/general/styled/beer_app_button.dart';
import 'package:beer_app/widget/general/styled/beer_app_input_field.dart';
import 'package:beer_app/widget/general/styled/beer_app_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:beer_app/di/injectable.dart';
import 'package:beer_app/navigator/route_names.dart';
import 'package:beer_app/styles/theme_dimens.dart';
import 'package:beer_app/widget/general/theme_widget.dart';
import 'package:beer_app/widget/provider/provider_widget.dart';
import 'package:get/get.dart';
import 'package:scroll_when_needed/scroll_when_needed.dart';

class BeerAddScreen extends StatefulWidget {
  static const String routeName = RouteNames.beerAddScreen;

  const BeerAddScreen({Key? key}) : super(key: key);

  @override
  BeerAddScreenState createState() => BeerAddScreenState();
}

@visibleForTesting
class BeerAddScreenState extends State<BeerAddScreen> {
  @override
  Widget build(BuildContext context) {
    return ThemeWidget(
      child: ProviderWidget<BeerAddViewModel>(
        create: () => getIt()..init(),
        childBuilderWithViewModel: (context, viewModel, theme, localization) =>
            ThemeWidget(
          child: DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: theme.colorsTheme.background,
              appBar: AppBar(
                systemOverlayStyle: SystemUiOverlayStyle.light,
                leading: BeerAppBackButton.light(
                  onClick: viewModel.onBackClicked,
                ),
                title: const Text("Add a new beer!"),
                backgroundColor: theme.colorsTheme.primary,
                bottom: const TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.plus_one)),
                    Tab(icon: Icon(Icons.cloud)),
                  ],
                ),
              ),
              body: ScrollConfiguration(
                behavior: ScrollWhenNeededBehavior(),
                child: Scrollbar(
                  child: TabBarView(
                    children: [
                      ListView(
                        physics: ScrollWhenNeededPhysics(
                            targetPlatform: Theme.of(context).platform),
                        padding: const EdgeInsets.all(ThemeDimens.padding16),
                        children: [
                          BeerAppButton(
                            text: localization.generalLabelSave,
                            isEnabled: viewModel.isSaveEnabled,
                            onClick: viewModel.onSaveClicked,
                          ),
                        ],
                      ),
                      ListView(
                        physics: ScrollWhenNeededPhysics(
                            targetPlatform: Theme.of(context).platform),
                        padding: const EdgeInsets.all(ThemeDimens.padding16),
                        children: [
                          StreamBuilder<List<Brewery>>(
                            stream: viewModel.dataBreweryStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }

                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return const BeerAppProgressIndicator(
                                      dark: true);
                                default:
                                  return DropdownButton<Brewery>(
                                    hint: Text(viewModel.selectedBrewery == null
                                        ? "Select a brewery"
                                        : viewModel.selectedBrewery!.name),
                                    items: snapshot.data?.map(
                                      (Brewery brewery) {
                                        return DropdownMenuItem<Brewery>(
                                          value: brewery,
                                          child: Text(brewery.name),
                                        );
                                      },
                                    ).toList(),
                                    onChanged: (Brewery? selectedBrewery) {
                                      viewModel.selectedBrewery =
                                          selectedBrewery;
                                    },
                                  );
                              }
                            },
                          ),
                          BeerAppButton(
                            text: localization.generalLabelSave,
                            isEnabled: viewModel.isSaveEnabled,
                            onClick: viewModel.onSaveClicked,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
