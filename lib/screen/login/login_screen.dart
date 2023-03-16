import 'package:beer_app/di/injectable.dart';
import 'package:beer_app/navigator/route_names.dart';
import 'package:beer_app/viewmodel/login/login_viewmodel.dart';
import 'package:beer_app/widget/general/styled/beer_app_button.dart';
import 'package:beer_app/widget/general/styled/beer_app_input_field.dart';
import 'package:beer_app/widget/login/censored_input_field.dart';
import 'package:beer_app/widget/provider/provider_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = RouteNames.loginScreen;

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<LoginViewModel>(
      create: () => getIt()..init(),
      childBuilderWithViewModel: (context, viewModel, theme, localization) =>
          Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(
                  MediaQuery.of(context).size.width * 0.05), // adjust padding
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //TODO: Add loading state, prevent users from pressing login while loading
                    Image.asset(
                      "assets/images/placeholder.png",
                      height: MediaQuery.of(context).size.height * 0.4,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    // add spacing
                    BeerAppInputField(
                      hint: localization.loginEmail,
                      onChanged: (value) => viewModel.onEmailUpdated(value),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    // add spacing
                    CensoredInputField(
                      hint: localization.loginPassword,
                      enabled: true,
                      onChanged: (value) => viewModel.onPasswordUpdated(value),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    // add spacing
                    BeerAppButton(
                      text: localization.loginConfirm,
                      onClick: () => viewModel.onLoginClicked(),
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
