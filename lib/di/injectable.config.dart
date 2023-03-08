// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i33;
import 'package:drift/drift.dart' as _i9;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i11;
import 'package:get_it/get_it.dart' as _i1;
import 'package:icapps_architecture/icapps_architecture.dart' as _i8;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i17;

import '../database/beer/beer_dao_storage.dart' as _i19;
import '../database/beer_app_database.dart' as _i18;
import '../database/brewery/brewery_dao_storage.dart' as _i20;
import '../model/webservice/beer/beer_with_brewery.dart' as _i5;
import '../navigator/main_navigator.dart' as _i13;
import '../repository/beer/beer_repository.dart' as _i43;
import '../repository/brewery/brewery_repository.dart' as _i44;
import '../repository/debug/debug_repository.dart' as _i24;
import '../repository/locale/locale_repository.dart' as _i26;
import '../repository/login/login_repository.dart' as _i40;
import '../repository/refresh/refresh_repository.dart' as _i28;
import '../repository/secure_storage/auth/auth_storage.dart' as _i23;
import '../repository/secure_storage/secure_storage.dart' as _i16;
import '../repository/shared_prefs/local/local_storage.dart' as _i25;
import '../styles/theme_data.dart' as _i3;
import '../util/cache/cache_controller.dart' as _i7;
import '../util/cache/cache_controlling.dart' as _i6;
import '../util/interceptor/network_auth_interceptor.dart' as _i27;
import '../util/interceptor/network_error_interceptor.dart' as _i14;
import '../util/interceptor/network_log_interceptor.dart' as _i15;
import '../util/interceptor/network_refresh_interceptor.dart' as _i32;
import '../util/locale/localization.dart' as _i12;
import '../util/snackbar/error_util.dart' as _i10;
import '../viewmodel/beer/beer_add/beer_add_viewmodel.dart' as _i45;
import '../viewmodel/beer/beer_detail/beer_detail_viewmodel.dart' as _i4;
import '../viewmodel/beer/beer_overview/beers_overview_viewmodel.dart' as _i46;
import '../viewmodel/debug/debug_platform_selector_viewmodel.dart' as _i21;
import '../viewmodel/debug/debug_theme_selector_viewmodel.dart' as _i29;
import '../viewmodel/debug/debug_viewmodel.dart' as _i30;
import '../viewmodel/global/global_viewmodel.dart' as _i31;
import '../viewmodel/license/license_viewmodel.dart' as _i22;
import '../viewmodel/login/login_viewmodel.dart' as _i41;
import '../viewmodel/splash/splash_viewmodel.dart' as _i42;
import '../webservice/beer/beer_service.dart' as _i36;
import '../webservice/beer/beer_webservice.dart' as _i37;
import '../webservice/brewery/brewery_service.dart' as _i38;
import '../webservice/brewery/brewery_webservice.dart' as _i39;
import '../webservice/login/login_service.dart' as _i34;
import '../webservice/login/login_webservice.dart' as _i35;
import 'injectable.dart' as _i47;

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
  gh.factory<_i4.BeerDetailViewModel>(
      () => _i4.BeerDetailViewModel(get<_i5.BeerWithBrewery>()));
  gh.singleton<_i6.CacheControlling>(_i7.CacheController());
  gh.singleton<_i8.ConnectivityHelper>(registerModule.connectivityHelper());
  await gh.singletonAsync<_i9.DatabaseConnection>(
    () => registerModule.provideDatabaseConnection(),
    preResolve: true,
  );
  gh.lazySingleton<_i10.ErrorUtil>(() => _i10.ErrorUtil());
  gh.lazySingleton<_i11.FlutterSecureStorage>(() => registerModule.storage());
  gh.lazySingleton<_i12.Localization>(() => registerModule.localization());
  gh.lazySingleton<_i13.MainNavigator>(
      () => _i13.MainNavigator(get<_i10.ErrorUtil>()));
  gh.singleton<_i14.NetworkErrorInterceptor>(
      _i14.NetworkErrorInterceptor(get<_i8.ConnectivityHelper>()));
  gh.singleton<_i15.NetworkLogInterceptor>(_i15.NetworkLogInterceptor());
  gh.lazySingleton<_i16.SecureStorage>(
      () => _i16.SecureStorage(get<_i11.FlutterSecureStorage>()));
  await gh.singletonAsync<_i17.SharedPreferences>(
    () => registerModule.prefs(),
    preResolve: true,
  );
  gh.lazySingleton<_i18.BeerAppDatabase>(
      () => registerModule.provideBADatabase(get<_i9.DatabaseConnection>()));
  gh.lazySingleton<_i19.BeerDaoStorage>(
      () => _i19.BeerDaoStorage(get<_i18.BeerAppDatabase>()));
  gh.lazySingleton<_i20.BreweryDaoStorage>(
      () => _i20.BreweryDaoStorage(get<_i18.BeerAppDatabase>()));
  gh.factory<_i21.DebugPlatformSelectorViewModel>(
      () => _i21.DebugPlatformSelectorViewModel(get<_i13.MainNavigator>()));
  gh.factory<_i22.LicenseViewModel>(
      () => _i22.LicenseViewModel(get<_i13.MainNavigator>()));
  gh.lazySingleton<_i8.SharedPreferenceStorage>(
      () => registerModule.sharedPreferences(get<_i17.SharedPreferences>()));
  gh.lazySingleton<_i8.SimpleKeyValueStorage>(
      () => registerModule.keyValueStorage(
            get<_i8.SharedPreferenceStorage>(),
            get<_i16.SecureStorage>(),
          ));
  gh.lazySingleton<_i23.AuthStorage>(
      () => _i23.AuthStorage(get<_i8.SimpleKeyValueStorage>()));
  gh.lazySingleton<_i24.DebugRepository>(
      () => _i24.DebugRepository(get<_i8.SharedPreferenceStorage>()));
  gh.lazySingleton<_i25.LocalStorage>(() => _i25.LocalStorage(
        get<_i23.AuthStorage>(),
        get<_i8.SharedPreferenceStorage>(),
      ));
  gh.lazySingleton<_i26.LocaleRepository>(
      () => _i26.LocaleRepository(get<_i8.SharedPreferenceStorage>()));
  gh.singleton<_i27.NetworkAuthInterceptor>(
      _i27.NetworkAuthInterceptor(get<_i23.AuthStorage>()));
  gh.lazySingleton<_i28.RefreshRepository>(
      () => _i28.RefreshRepository(get<_i23.AuthStorage>()));
  gh.factory<_i29.DebugThemeSelectorViewmodel>(
      () => _i29.DebugThemeSelectorViewmodel(
            get<_i13.MainNavigator>(),
            get<_i25.LocalStorage>(),
          ));
  gh.factory<_i30.DebugViewModel>(() => _i30.DebugViewModel(
        get<_i24.DebugRepository>(),
        get<_i13.MainNavigator>(),
        get<_i18.BeerAppDatabase>(),
        get<_i25.LocalStorage>(),
      ));
  gh.lazySingleton<_i31.GlobalViewModel>(() => _i31.GlobalViewModel(
        get<_i26.LocaleRepository>(),
        get<_i24.DebugRepository>(),
        get<_i25.LocalStorage>(),
        get<_i12.Localization>(),
      ));
  gh.singleton<_i32.NetworkRefreshInterceptor>(_i32.NetworkRefreshInterceptor(
    get<_i23.AuthStorage>(),
    get<_i28.RefreshRepository>(),
  ));
  gh.lazySingleton<_i8.CombiningSmartInterceptor>(
      () => registerModule.provideCombiningSmartInterceptor(
            get<_i15.NetworkLogInterceptor>(),
            get<_i27.NetworkAuthInterceptor>(),
            get<_i14.NetworkErrorInterceptor>(),
            get<_i32.NetworkRefreshInterceptor>(),
          ));
  gh.lazySingleton<_i33.Dio>(
      () => registerModule.provideDio(get<_i8.CombiningSmartInterceptor>()));
  gh.singleton<_i34.LoginService>(_i35.LoginWebService(get<_i33.Dio>()));
  gh.singleton<_i36.BeerService>(
    _i37.BeerWebService(get<_i33.Dio>()),
    registerFor: {
      _dev,
      _prod,
    },
  );
  gh.singleton<_i38.BreweryService>(
    _i39.BreweryWebService(get<_i33.Dio>()),
    registerFor: {
      _dev,
      _prod,
    },
  );
  gh.lazySingleton<_i40.LoginRepository>(() => _i40.LoginRepository(
        get<_i23.AuthStorage>(),
        get<_i34.LoginService>(),
      ));
  gh.factory<_i41.LoginViewModel>(() => _i41.LoginViewModel(
        get<_i40.LoginRepository>(),
        get<_i13.MainNavigator>(),
        get<_i10.ErrorUtil>(),
      ));
  gh.factory<_i42.SplashViewModel>(() => _i42.SplashViewModel(
        get<_i25.LocalStorage>(),
        get<_i13.MainNavigator>(),
        get<_i40.LoginRepository>(),
      ));
  gh.lazySingleton<_i43.BeerRepository>(() => _i43.BeerRepository(
        get<_i36.BeerService>(),
        get<_i19.BeerDaoStorage>(),
      ));
  gh.lazySingleton<_i44.BreweryRepository>(() => _i44.BreweryRepository(
        get<_i38.BreweryService>(),
        get<_i20.BreweryDaoStorage>(),
      ));
  gh.factory<_i45.BeerAddViewModel>(() => _i45.BeerAddViewModel(
        get<_i43.BeerRepository>(),
        get<_i13.MainNavigator>(),
      ));
  gh.factory<_i46.BeersOverViewViewModel>(() => _i46.BeersOverViewViewModel(
        get<_i43.BeerRepository>(),
        get<_i44.BreweryRepository>(),
        get<_i13.MainNavigator>(),
        get<_i17.SharedPreferences>(),
      ));
  return get;
}

class _$RegisterModule extends _i47.RegisterModule {}
