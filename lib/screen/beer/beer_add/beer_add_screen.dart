import 'dart:io';

import 'package:beer_app/model/webservice/beer/brewery.dart';
import 'package:beer_app/viewmodel/beer/beer_add/beer_add_viewmodel.dart';
import 'package:beer_app/widget/beer/image_picker_form_field.dart';
import 'package:beer_app/widget/beer/rating_bar_form_field.dart';
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
                bottom: TabBar(
                  onTap: (index) => viewModel.resetForm(),
                  tabs: const [
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
                          Text(
                            "Beer data:",
                            textAlign: TextAlign.center,
                            style: theme.coreTextTheme.bodyNormal,
                          ),
                          BeerAppInputField(
                            hint: "Beer name",
                            controller: viewModel.beerNameController,
                            onChanged: (value) =>
                                viewModel.onNameChanged(value),
                          ),
                          RatingBarFormField(
                            maxStars: 5,
                            currentRating: viewModel.currentRating,
                            onRatingChanged: (value) =>
                                viewModel.onRatingChanged(value),
                          ),
                          ImagePickerFormField(
                            onImagePicked: (File? value) {
                              viewModel.onImageUrlChanged(value);
                            },
                            validator: (File? value) {
                              if (value == null) {
                                return 'Please select an image';
                              }
                              return null;
                            },
                          ),
                          const Divider(
                            height: 16,
                          ),
                          Text(
                            "Brewery data:",
                            textAlign: TextAlign.center,
                            style: theme.coreTextTheme.bodyNormal,
                          ),
                          BeerAppInputField(
                            hint: "Brewery name",
                            controller: viewModel.breweryNameController,
                            onChanged: (value) =>
                                viewModel.onBreweryNameChanged(value),
                          ),
                          BeerAppInputField(
                            hint: "Brewery Address",
                            controller: viewModel.breweryAddressController,
                            onChanged: (value) =>
                                viewModel.onBreweryAddressChanged(value),
                          ),
                          BeerAppInputField(
                            hint: "Brewery city",
                            controller: viewModel.breweryCityController,
                            onChanged: (value) =>
                                viewModel.onBreweryCityChanged(value),
                          ),
                          BeerAppInputField(
                            hint: "Brewery country",
                            controller: viewModel.breweryCountryController,
                            onChanged: (value) =>
                                viewModel.onBreweryCountryChanged(value),
                          ),
                          const Divider(height: 16),
                          BeerAppButton(
                            text: localization.generalLabelSave,
                            isEnabled: viewModel.isSaveEnabled,
                            onClick: viewModel.onNewBrewerySavedClicked,
                          ),
                        ],
                      ),
                      ListView(
                        physics: ScrollWhenNeededPhysics(
                            targetPlatform: Theme.of(context).platform),
                        padding: const EdgeInsets.all(ThemeDimens.padding16),
                        children: [
                          Text(
                            "Beer data:",
                            textAlign: TextAlign.center,
                            style: theme.coreTextTheme.bodyNormal,
                          ),
                          BeerAppInputField(
                            hint: "Beer name",
                            controller: viewModel.beerNameController,
                            onChanged: (value) =>
                                viewModel.onNameChanged(value),
                          ),
                          RatingBarFormField(
                            maxStars: 5,
                            currentRating: viewModel.currentRating,
                            onRatingChanged: (value) =>
                                viewModel.onRatingChanged(value),
                          ),
                          ImagePickerFormField(
                            onImagePicked: (File? value) {
                              viewModel.onImageUrlChanged(value);
                            },
                            validator: (File? value) {
                              if (value == null) {
                                return 'Please select an image';
                              }
                              return null;
                            },
                          ),
                          const Divider(
                            height: 16,
                          ),
                          Text(
                            "Brewery data:",
                            textAlign: TextAlign.center,
                            style: theme.coreTextTheme.bodyNormal,
                          ),
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
                            onClick: viewModel.onBreweryExistsSaveClicked,
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
