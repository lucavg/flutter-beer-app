import 'package:beer_app/viewmodel/beer/beer_add/beer_add_viewmodel.dart';
import 'package:beer_app/widget/general/styled/beer_app_back_button.dart';
import 'package:beer_app/widget/general/styled/beer_app_button.dart';
import 'package:beer_app/widget/general/styled/beer_app_input_field.dart';
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
        create: getIt,
        childBuilderWithViewModel: (context, viewModel, theme, localization) => ThemeWidget(
          child: Scaffold(
            backgroundColor: theme.colorsTheme.background,
            appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle.light,
              leading: BeerAppBackButton.light(
                onClick: viewModel.onBackClicked,
              ),
              title: Text(localization.todoAddTitle),
              backgroundColor: theme.colorsTheme.primary,
            ),
            body: ScrollConfiguration(
              behavior: ScrollWhenNeededBehavior(),
              child: Scrollbar(
                child: ListView(
                  physics: ScrollWhenNeededPhysics(targetPlatform: Theme.of(context).platform),
                  padding: const EdgeInsets.all(ThemeDimens.padding16),
                  children: [
                    // BeerAppInputField(
                    //   hint: "Name",
                    //   onChanged: viewModel.onBeerChanged,
                    // ),
                    Container(height: ThemeDimens.padding16),
                    BeerAppButton(
                      text: localization.generalLabelSave,
                      isEnabled: viewModel.isSaveEnabled,
                      onClick: viewModel.onSaveClicked,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
