// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i37;
import 'package:drift/drift.dart' as _i7;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:icapps_architecture/icapps_architecture.dart' as _i6;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i15;

import '../database/beer/beer_dao_storage.dart' as _i19;
import '../database/beer_app_database.dart' as _i18;
import '../database/brewery/brewery_dao_storage.dart' as _i20;
import '../database/todo/todo_dao_storage.dart' as _i23;
import '../navigator/main_navigator.dart' as _i11;
import '../repository/beer/beer_repository.dart' as _i48;
import '../repository/brewery/brewery_repository.dart' as _i49;
import '../repository/debug/debug_repository.dart' as _i26;
import '../repository/locale/locale_repository.dart' as _i28;
import '../repository/login/login_repository.dart' as _i45;
import '../repository/refresh/refresh_repository.dart' as _i30;
import '../repository/secure_storage/auth/auth_storage.dart' as _i25;
import '../repository/secure_storage/secure_storage.dart' as _i14;
import '../repository/shared_prefs/local/local_storage.dart' as _i27;
import '../repository/todo/todo_repository.dart' as _i24;
import '../styles/theme_data.dart' as _i3;
import '../util/cache/cache_controller.dart' as _i5;
import '../util/cache/cache_controlling.dart' as _i4;
import '../util/interceptor/network_auth_interceptor.dart' as _i29;
import '../util/interceptor/network_error_interceptor.dart' as _i12;
import '../util/interceptor/network_log_interceptor.dart' as _i13;
import '../util/interceptor/network_refresh_interceptor.dart' as _i36;
import '../util/locale/localization.dart' as _i10;
import '../util/snackbar/error_util.dart' as _i8;
import '../viewmodel/beer/beers_overview_viewmodel.dart' as _i50;
import '../viewmodel/debug/debug_platform_selector_viewmodel.dart' as _i21;
import '../viewmodel/debug/debug_theme_selector_viewmodel.dart' as _i33;
import '../viewmodel/debug/debug_viewmodel.dart' as _i34;
import '../viewmodel/global/global_viewmodel.dart' as _i35;
import '../viewmodel/license/license_viewmodel.dart' as _i22;
import '../viewmodel/login/login_viewmodel.dart' as _i46;
import '../viewmodel/splash/splash_viewmodel.dart' as _i47;
import '../viewmodel/todo/todo_add/todo_add_viewmodel.dart' as _i31;
import '../viewmodel/todo/todo_list/todo_list_viewmodel.dart' as _i32;
import '../webservice/beer/beer_service.dart' as _i41;
import '../webservice/beer/beer_webservice.dart' as _i42;
import '../webservice/brewery/brewery_service.dart' as _i43;
import '../webservice/brewery/brewery_webservice.dart' as _i44;
import '../webservice/login/login_service.dart' as _i38;
import '../webservice/login/login_webservice.dart' as _i39;
import '../webservice/todo/todo_dummy_service.dart' as _i17;
import '../webservice/todo/todo_service.dart' as _i16;
import '../webservice/todo/todo_webservice.dart' as _i40;
import 'injectable.dart' as _i51;

const String _dummy = 'dummy';
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
  gh.singleton<_i16.TodoService>(
    _i17.TodoDummyService(),
    registerFor: {_dummy},
  );
  gh.lazySingleton<_i18.BeerAppDatabase>(
      () => registerModule.provideBADatabase(get<_i7.DatabaseConnection>()));
  gh.lazySingleton<_i19.BeerDaoStorage>(
      () => _i19.BeerDaoStorage(get<_i18.BeerAppDatabase>()));
  gh.lazySingleton<_i20.BreweryDaoStorage>(
      () => _i20.BreweryDaoStorage(get<_i18.BeerAppDatabase>()));
  gh.factory<_i21.DebugPlatformSelectorViewModel>(
      () => _i21.DebugPlatformSelectorViewModel(get<_i11.MainNavigator>()));
  gh.factory<_i22.LicenseViewModel>(
      () => _i22.LicenseViewModel(get<_i11.MainNavigator>()));
  gh.lazySingleton<_i6.SharedPreferenceStorage>(
      () => registerModule.sharedPreferences(get<_i15.SharedPreferences>()));
  gh.lazySingleton<_i6.SimpleKeyValueStorage>(
      () => registerModule.keyValueStorage(
            get<_i6.SharedPreferenceStorage>(),
            get<_i14.SecureStorage>(),
          ));
  gh.lazySingleton<_i23.TodoDaoStorage>(
      () => _i23.TodoDaoStorage(get<_i18.BeerAppDatabase>()));
  gh.lazySingleton<_i24.TodoRepository>(() => _i24.TodoRepository(
        get<_i16.TodoService>(),
        get<_i23.TodoDaoStorage>(),
      ));
  gh.lazySingleton<_i25.AuthStorage>(
      () => _i25.AuthStorage(get<_i6.SimpleKeyValueStorage>()));
  gh.lazySingleton<_i26.DebugRepository>(
      () => _i26.DebugRepository(get<_i6.SharedPreferenceStorage>()));
  gh.lazySingleton<_i27.LocalStorage>(() => _i27.LocalStorage(
        get<_i25.AuthStorage>(),
        get<_i6.SharedPreferenceStorage>(),
      ));
  gh.lazySingleton<_i28.LocaleRepository>(
      () => _i28.LocaleRepository(get<_i6.SharedPreferenceStorage>()));
  gh.singleton<_i29.NetworkAuthInterceptor>(
      _i29.NetworkAuthInterceptor(get<_i25.AuthStorage>()));
  gh.lazySingleton<_i30.RefreshRepository>(
      () => _i30.RefreshRepository(get<_i25.AuthStorage>()));
  gh.factory<_i31.TodoAddViewModel>(() => _i31.TodoAddViewModel(
        get<_i24.TodoRepository>(),
        get<_i11.MainNavigator>(),
      ));
  gh.factory<_i32.TodoListViewModel>(() => _i32.TodoListViewModel(
        get<_i24.TodoRepository>(),
        get<_i11.MainNavigator>(),
      ));
  gh.factory<_i33.DebugThemeSelectorViewmodel>(
      () => _i33.DebugThemeSelectorViewmodel(
            get<_i11.MainNavigator>(),
            get<_i27.LocalStorage>(),
          ));
  gh.factory<_i34.DebugViewModel>(() => _i34.DebugViewModel(
        get<_i26.DebugRepository>(),
        get<_i11.MainNavigator>(),
        get<_i18.BeerAppDatabase>(),
        get<_i27.LocalStorage>(),
      ));
  gh.lazySingleton<_i35.GlobalViewModel>(() => _i35.GlobalViewModel(
        get<_i28.LocaleRepository>(),
        get<_i26.DebugRepository>(),
        get<_i27.LocalStorage>(),
        get<_i10.Localization>(),
      ));
  gh.singleton<_i36.NetworkRefreshInterceptor>(_i36.NetworkRefreshInterceptor(
    get<_i25.AuthStorage>(),
    get<_i30.RefreshRepository>(),
  ));
  gh.lazySingleton<_i6.CombiningSmartInterceptor>(
      () => registerModule.provideCombiningSmartInterceptor(
            get<_i13.NetworkLogInterceptor>(),
            get<_i29.NetworkAuthInterceptor>(),
            get<_i12.NetworkErrorInterceptor>(),
            get<_i36.NetworkRefreshInterceptor>(),
          ));
  gh.lazySingleton<_i37.Dio>(
      () => registerModule.provideDio(get<_i6.CombiningSmartInterceptor>()));
  gh.singleton<_i38.LoginService>(_i39.LoginWebService(get<_i37.Dio>()));
  gh.singleton<_i16.TodoService>(
    _i40.TodoWebService(get<_i37.Dio>()),
    registerFor: {
      _dev,
      _prod,
    },
  );
  gh.singleton<_i41.BeerService>(
    _i42.BeerWebService(get<_i37.Dio>()),
    registerFor: {
      _dev,
      _prod,
    },
  );
  gh.singleton<_i43.BreweryService>(
    _i44.BreweryWebService(get<_i37.Dio>()),
    registerFor: {
      _dev,
      _prod,
    },
  );
  gh.lazySingleton<_i45.LoginRepository>(() => _i45.LoginRepository(
        get<_i25.AuthStorage>(),
        get<_i38.LoginService>(),
      ));
  gh.factory<_i46.LoginViewModel>(() => _i46.LoginViewModel(
        get<_i45.LoginRepository>(),
        get<_i11.MainNavigator>(),
        get<_i8.ErrorUtil>(),
      ));
  gh.factory<_i47.SplashViewModel>(() => _i47.SplashViewModel(
        get<_i27.LocalStorage>(),
        get<_i11.MainNavigator>(),
        get<_i45.LoginRepository>(),
      ));
  gh.lazySingleton<_i48.BeerRepository>(() => _i48.BeerRepository(
        get<_i41.BeerService>(),
        get<_i19.BeerDaoStorage>(),
      ));
  gh.lazySingleton<_i49.BreweryRepository>(() => _i49.BreweryRepository(
        get<_i43.BreweryService>(),
        get<_i20.BreweryDaoStorage>(),
      ));
  gh.factory<_i50.BeersOverViewViewModel>(() => _i50.BeersOverViewViewModel(
        get<_i48.BeerRepository>(),
        get<_i49.BreweryRepository>(),
        get<_i11.MainNavigator>(),
        get<_i15.SharedPreferences>(),
      ));
  return get;
}

class _$RegisterModule extends _i51.RegisterModule {}
