// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i35;
import 'package:drift/drift.dart' as _i7;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:icapps_architecture/icapps_architecture.dart' as _i6;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i15;

import '../database/beer/beer_dao_storage.dart' as _i17;
import '../database/beer_app_database.dart' as _i16;
import '../database/brewery/brewery_dao_storage.dart' as _i19;
import '../navigator/main_navigator.dart' as _i11;
import '../repository/beer/beer_repository.dart' as _i42;
import '../repository/brewery/brewery_repository.dart' as _i43;
import '../repository/debug/debug_repository.dart' as _i23;
import '../repository/locale/locale_repository.dart' as _i25;
import '../repository/login/login_repository.dart' as _i26;
import '../repository/refresh/refresh_repository.dart' as _i29;
import '../repository/secure_storage/auth/auth_storage.dart' as _i22;
import '../repository/secure_storage/secure_storage.dart' as _i14;
import '../repository/shared_prefs/local/local_storage.dart' as _i24;
import '../styles/theme_data.dart' as _i3;
import '../util/cache/cache_controller.dart' as _i5;
import '../util/cache/cache_controlling.dart' as _i4;
import '../util/interceptor/network_auth_interceptor.dart' as _i28;
import '../util/interceptor/network_error_interceptor.dart' as _i12;
import '../util/interceptor/network_log_interceptor.dart' as _i13;
import '../util/interceptor/network_refresh_interceptor.dart' as _i34;
import '../util/locale/localization.dart' as _i10;
import '../util/snackbar/error_util.dart' as _i8;
import '../viewmodel/beer/beer_add/beer_add_viewmodel.dart' as _i44;
import '../viewmodel/beer/beer_detail/beer_detail_viewmodel.dart' as _i18;
import '../viewmodel/beer/beer_overview/beers_overview_viewmodel.dart' as _i45;
import '../viewmodel/debug/debug_platform_selector_viewmodel.dart' as _i20;
import '../viewmodel/debug/debug_theme_selector_viewmodel.dart' as _i31;
import '../viewmodel/debug/debug_viewmodel.dart' as _i32;
import '../viewmodel/global/global_viewmodel.dart' as _i33;
import '../viewmodel/license/license_viewmodel.dart' as _i21;
import '../viewmodel/login/login_viewmodel.dart' as _i27;
import '../viewmodel/splash/splash_viewmodel.dart' as _i30;
import '../webservice/beer/beer_service.dart' as _i38;
import '../webservice/beer/beer_webservice.dart' as _i39;
import '../webservice/brewery/brewery_service.dart' as _i40;
import '../webservice/brewery/brewery_webservice.dart' as _i41;
import '../webservice/login/login_service.dart' as _i36;
import '../webservice/login/login_webservice.dart' as _i37;
import 'injectable.dart' as _i46;

const String _dev = 'dev';
const String _prod = 'prod';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.BeerAppTheme>(() => registerModule.theme());
  gh.singleton<_i4.CacheControlling>(_i5.CacheController());
  gh.singleton<_i6.ConnectivityHelper>(registerModule.connectivityHelper());
  await gh.singletonAsync<_i7.DatabaseConnection>(
    () => registerModule.provideDatabaseConnection(),
    preResolve: true,
  );
  gh.lazySingleton<_i8.ErrorUtil>(() => _i8.ErrorUtil());
  gh.lazySingleton<_i9.FlutterSecureStorage>(() => registerModule.storage());
  gh.lazySingleton<_i10.Localization>(() => registerModule.localization());
  gh.lazySingleton<_i11.MainNavigator>(
      () => _i11.MainNavigator(get<_i8.ErrorUtil>()));
  gh.singleton<_i12.NetworkErrorInterceptor>(
      _i12.NetworkErrorInterceptor(get<_i6.ConnectivityHelper>()));
  gh.singleton<_i13.NetworkLogInterceptor>(_i13.NetworkLogInterceptor());
  gh.lazySingleton<_i14.SecureStorage>(
      () => _i14.SecureStorage(get<_i9.FlutterSecureStorage>()));
  await gh.singletonAsync<_i15.SharedPreferences>(
    () => registerModule.prefs(),
    preResolve: true,
  );
  gh.lazySingleton<_i16.BeerAppDatabase>(() =>
      registerModule.provideBeerAppDatabase(get<_i7.DatabaseConnection>()));
  gh.lazySingleton<_i17.BeerDaoStorage>(
      () => _i17.BeerDaoStorage(get<_i16.BeerAppDatabase>()));
  gh.factory<_i18.BeerDetailViewModel>(() => _i18.BeerDetailViewModel(
        get<_i11.MainNavigator>(),
        get<_i15.SharedPreferences>(),
      ));
  gh.lazySingleton<_i19.BreweryDaoStorage>(
      () => _i19.BreweryDaoStorage(get<_i16.BeerAppDatabase>()));
  gh.factory<_i20.DebugPlatformSelectorViewModel>(
      () => _i20.DebugPlatformSelectorViewModel(get<_i11.MainNavigator>()));
  gh.factory<_i21.LicenseViewModel>(
      () => _i21.LicenseViewModel(get<_i11.MainNavigator>()));
  gh.lazySingleton<_i6.SharedPreferenceStorage>(
      () => registerModule.sharedPreferences(get<_i15.SharedPreferences>()));
  gh.lazySingleton<_i6.SimpleKeyValueStorage>(
      () => registerModule.keyValueStorage(
            get<_i6.SharedPreferenceStorage>(),
            get<_i14.SecureStorage>(),
          ));
  gh.lazySingleton<_i22.AuthStorage>(
      () => _i22.AuthStorage(get<_i6.SimpleKeyValueStorage>()));
  gh.lazySingleton<_i23.DebugRepository>(
      () => _i23.DebugRepository(get<_i6.SharedPreferenceStorage>()));
  gh.lazySingleton<_i24.LocalStorage>(() => _i24.LocalStorage(
        get<_i22.AuthStorage>(),
        get<_i6.SharedPreferenceStorage>(),
      ));
  gh.lazySingleton<_i25.LocaleRepository>(
      () => _i25.LocaleRepository(get<_i6.SharedPreferenceStorage>()));
  gh.lazySingleton<_i26.LoginRepository>(
      () => _i26.LoginRepository(get<_i22.AuthStorage>()));
  gh.factory<_i27.LoginViewModel>(() => _i27.LoginViewModel(
        get<_i26.LoginRepository>(),
        get<_i11.MainNavigator>(),
        get<_i8.ErrorUtil>(),
      ));
  gh.singleton<_i28.NetworkAuthInterceptor>(
      _i28.NetworkAuthInterceptor(get<_i22.AuthStorage>()));
  gh.lazySingleton<_i29.RefreshRepository>(
      () => _i29.RefreshRepository(get<_i22.AuthStorage>()));
  gh.factory<_i30.SplashViewModel>(() => _i30.SplashViewModel(
        get<_i24.LocalStorage>(),
        get<_i11.MainNavigator>(),
      ));
  gh.factory<_i31.DebugThemeSelectorViewmodel>(
      () => _i31.DebugThemeSelectorViewmodel(
            get<_i11.MainNavigator>(),
            get<_i24.LocalStorage>(),
          ));
  gh.factory<_i32.DebugViewModel>(() => _i32.DebugViewModel(
        get<_i23.DebugRepository>(),
        get<_i11.MainNavigator>(),
        get<_i16.BeerAppDatabase>(),
        get<_i24.LocalStorage>(),
      ));
  gh.lazySingleton<_i33.GlobalViewModel>(() => _i33.GlobalViewModel(
        get<_i25.LocaleRepository>(),
        get<_i23.DebugRepository>(),
        get<_i24.LocalStorage>(),
        get<_i10.Localization>(),
      ));
  gh.singleton<_i34.NetworkRefreshInterceptor>(_i34.NetworkRefreshInterceptor(
    get<_i22.AuthStorage>(),
    get<_i29.RefreshRepository>(),
  ));
  gh.lazySingleton<_i6.CombiningSmartInterceptor>(
      () => registerModule.provideCombiningSmartInterceptor(
            get<_i13.NetworkLogInterceptor>(),
            get<_i28.NetworkAuthInterceptor>(),
            get<_i12.NetworkErrorInterceptor>(),
            get<_i34.NetworkRefreshInterceptor>(),
          ));
  gh.lazySingleton<_i35.Dio>(
      () => registerModule.provideDio(get<_i6.CombiningSmartInterceptor>()));
  gh.singleton<_i36.LoginService>(_i37.LoginWebService(get<_i35.Dio>()));
  gh.singleton<_i38.BeerService>(
    _i39.BeerWebService(get<_i35.Dio>()),
    registerFor: {
      _dev,
      _prod,
    },
  );
  gh.singleton<_i40.BreweryService>(
    _i41.BreweryWebService(get<_i35.Dio>()),
    registerFor: {
      _dev,
      _prod,
    },
  );
  gh.lazySingleton<_i42.BeerRepository>(() => _i42.BeerRepository(
        get<_i38.BeerService>(),
        get<_i17.BeerDaoStorage>(),
      ));
  gh.lazySingleton<_i43.BreweryRepository>(() => _i43.BreweryRepository(
        get<_i40.BreweryService>(),
        get<_i19.BreweryDaoStorage>(),
      ));
  gh.factory<_i44.BeerAddViewModel>(() => _i44.BeerAddViewModel(
        get<_i42.BeerRepository>(),
        get<_i43.BreweryRepository>(),
        get<_i11.MainNavigator>(),
      ));
  gh.factory<_i45.BeersOverViewViewModel>(() => _i45.BeersOverViewViewModel(
        get<_i42.BeerRepository>(),
        get<_i43.BreweryRepository>(),
        get<_i11.MainNavigator>(),
        get<_i15.SharedPreferences>(),
      ));
  return get;
}

class _$RegisterModule extends _i46.RegisterModule {}
