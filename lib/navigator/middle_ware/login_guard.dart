import 'package:beer_app/di/injectable.dart';
import 'package:beer_app/navigator/main_navigator.dart';
import 'package:beer_app/repository/secure_storage/auth/auth_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginGuard extends GetMiddleware {
  final authStorage = getIt.get<AuthStorage>();

  @override
  RouteSettings? redirect(String? route) {
    return authStorage.isLoggedIn ? RouteSettings(name: MainNavigator.initialRoute) : null;
  }
}