import 'package:flutter/material.dart';
import 'package:beer_app/di/injectable.dart';
import 'package:beer_app/navigator/route_names.dart';
import 'package:beer_app/viewmodel/splash/splash_viewmodel.dart';
import 'package:beer_app/widget/general/status_bar.dart';
import 'package:beer_app/widget/provider/provider_widget.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = RouteNames.splashScreen;

  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

@visibleForTesting
class SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<SplashViewModel>(
      create: () => getIt()..init(),
      consumerWithThemeAndLocalization:
          (context, viewModel, child, theme, localization) =>
              StatusBar.animated(
        isDarkStyle: theme.isDarkTheme,
        child: Scaffold(
          backgroundColor: theme.colorsTheme.primary,
          body: Center(
            child: Image.network(
              "https://freesvg.org/img/1515941353.png",
              height: MediaQuery.of(context).size.height *
                  0.4, // adjust image height
            ),
          ),
        ),
      ),
    );
  }
}
