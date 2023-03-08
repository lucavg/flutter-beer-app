import 'package:beer_app/di/injectable.dart';
import 'package:beer_app/navigator/route_names.dart';
import 'package:beer_app/styles/theme_dimens.dart';
import 'package:beer_app/viewmodel/login/login_viewmodel.dart';
import 'package:beer_app/widget/general/styled/beer_app_button.dart';
import 'package:beer_app/widget/general/styled/beer_app_input_field.dart';
import 'package:beer_app/widget/provider/provider_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = RouteNames.loginScreen;

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<LoginViewModel>(
        create: () => getIt()..init(),
        childBuilderWithViewModel: (context, viewModel, theme, localization) => Scaffold(
              body: SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(ThemeDimens.padding16),
                    child: Column(
                      children: [
                        //TODO: Add loading state, prevent users from pressing login while loading
                        Image.network(
                          "https://freesvg.org/img/1515941353.png",
                          height: 250,
                        ),
                        BeerAppInputField(
                          hint: 'Email',
                          onChanged: (value) => viewModel.onEmailUpdated(value),
                        ),
                        // TODO: Password field must be censored
                        BeerAppInputField(
                          hint: 'Password',
                          onChanged: (value) => viewModel.onPasswordUpdated(value),
                        ),
                        const SizedBox(height: 8),
                        BeerAppButton(
                          text: 'Login',
                          onClick: () => viewModel.onLoginClicked(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
