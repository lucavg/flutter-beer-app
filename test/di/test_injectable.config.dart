// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:beer_app/database/beer_app_database.dart' as _i4;
import 'package:beer_app/navigator/main_navigator.dart' as _i17;
import 'package:beer_app/repository/debug/debug_repository.dart' as _i7;
import 'package:beer_app/repository/locale/locale_repository.dart' as _i14;
import 'package:beer_app/repository/login/login_repository.dart' as _i16;
import 'package:beer_app/repository/refresh/refresh_repository.dart' as _i18;
import 'package:beer_app/repository/secure_storage/auth/auth_storage.dart'
    as _i3;
import 'package:beer_app/repository/secure_storage/secure_storage.dart' as _i19;
import 'package:beer_app/repository/shared_prefs/local/local_storage.dart'
    as _i13;
import 'package:beer_app/util/locale/localization.dart' as _i15;
import 'package:beer_app/viewmodel/debug/debug_platform_selector_viewmodel.dart'
    as _i6;
import 'package:beer_app/viewmodel/debug/debug_viewmodel.dart' as _i8;
import 'package:beer_app/viewmodel/global/global_viewmodel.dart' as _i11;
import 'package:beer_app/viewmodel/license/license_viewmodel.dart' as _i12;
import 'package:beer_app/viewmodel/splash/splash_viewmodel.dart' as _i21;
import 'package:dio/dio.dart' as _i9;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:icapps_architecture/icapps_architecture.dart' as _i5;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i20;

import 'test_injectable.dart' as _i22;

const String _test = 'test';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initTestGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.singleton<_i3.AuthStorage>(registerModule.getAuthStoring);
  gh.singleton<_i4.BeerAppDatabase>(
    registerModule.flutterTemplateDatabase,
    registerFor: {_test},
  );
  gh.singleton<_i5.ConnectivityHelper>(
      registerModule.getConnectivityControlling);
  gh.singleton<_i6.DebugPlatformSelectorViewModel>(
      registerModule.getDebugPlatformSelectorViewModel);
  gh.singleton<_i7.DebugRepository>(registerModule.getDebugRepo);
  gh.singleton<_i8.DebugViewModel>(registerModule.getDebugViewModel);
  gh.singleton<_i9.Dio>(registerModule.getDio);
  gh.singleton<_i10.FlutterSecureStorage>(
      registerModule.getFlutterSecureStorage);
  gh.singleton<_i11.GlobalViewModel>(registerModule.getGlobalViewModel);
  gh.singleton<_i12.LicenseViewModel>(registerModule.getLicenseViewModel);
  gh.singleton<_i13.LocalStorage>(registerModule.getLocalStoring);
  gh.singleton<_i14.LocaleRepository>(registerModule.getLocaleRepo);
  gh.singleton<_i15.Localization>(registerModule.getLocalization);
  gh.singleton<_i16.LoginRepository>(registerModule.getLoginRepo);
  gh.singleton<_i17.MainNavigator>(
    registerModule.getMainNavigator,
    registerFor: {_test},
  );
  gh.singleton<_i18.RefreshRepository>(registerModule.getRefreshRepo);
  gh.singleton<_i19.SecureStorage>(registerModule.getSecureStoring);
  gh.singleton<_i5.SharedPreferenceStorage>(
      registerModule.getSharedPrefsStoring);
  gh.singleton<_i20.SharedPreferences>(registerModule.getSharedPreferences);
  gh.singleton<_i21.SplashViewModel>(registerModule.getSplashViewModel);
  return get;
}

class _$RegisterModule extends _i22.RegisterModule {}
