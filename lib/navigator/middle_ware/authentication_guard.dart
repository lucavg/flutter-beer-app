import 'package:beer_app/di/injectable.dart';
import 'package:beer_app/navigator/route_names.dart';
import 'package:beer_app/repository/secure_storage/auth/auth_storage.dart';
import 'package:beer_app/util/env/flavor_config.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class AuthenticationGuard extends GetMiddleware {
  final authStorage = getIt.get<AuthStorage>();

  @override
  RouteSettings? redirect(String? route) {
    if (FlavorConfig.isInTest()) return null;
    return authStorage.isLoggedIn
        ? null
        : const RouteSettings(name: RouteNames.loginScreen);
  }
}
