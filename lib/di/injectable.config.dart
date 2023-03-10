// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i43;
import 'package:drift/drift.dart' as _i10;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i14;
import 'package:get_it/get_it.dart' as _i1;
import 'package:icapps_architecture/icapps_architecture.dart' as _i9;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i20;

import '../database/beer/beer_dao_storage.dart' as _i5;
import '../database/beer_app_database.dart' as _i24;
import '../database/todo/todo_dao_storage.dart' as _i27;
import '../navigator/main_navigator.dart' as _i12;
import '../repository/beer/beer_repository.dart' as _i4;
import '../repository/brewery/brewery_repository.dart' as _i6;
import '../repository/debug/debug_repository.dart' as _i30;
import '../repository/locale/locale_repository.dart' as _i32;
import '../repository/login/login_repository.dart' as _i33;
import '../repository/refresh/refresh_repository.dart' as _i35;
import '../repository/secure_storage/auth/auth_storage.dart' as _i29;
import '../repository/secure_storage/secure_storage.dart' as _i19;
import '../repository/shared_prefs/local/local_storage.dart' as _i31;
import '../repository/todo/todo_repository.dart' as _i28;
import '../styles/theme_data.dart' as _i3;
import '../util/cache/cache_controller.dart' as _i8;
import '../util/cache/cache_controlling.dart' as _i7;
import '../util/interceptor/network_auth_interceptor.dart' as _i34;
import '../util/interceptor/network_error_interceptor.dart' as _i17;
import '../util/interceptor/network_log_interceptor.dart' as _i18;
import '../util/interceptor/network_refresh_interceptor.dart' as _i42;
import '../util/locale/localization.dart' as _i16;
import '../util/snackbar/error_util.dart' as _i13;
import '../viewmodel/beer/beer_add/beer_add_viewmodel.dart' as _i23;
import '../viewmodel/beer/beer_detail/beer_detail_viewmodel.dart' as _i25;
import '../viewmodel/beer/beer_overview/beers_overview_viewmodel.dart' as _i26;
import '../viewmodel/debug/debug_platform_selector_viewmodel.dart' as _i11;
import '../viewmodel/debug/debug_theme_selector_viewmodel.dart' as _i39;
import '../viewmodel/debug/debug_viewmodel.dart' as _i40;
import '../viewmodel/global/global_viewmodel.dart' as _i41;
import '../viewmodel/license/license_viewmodel.dart' as _i15;
import '../viewmodel/splash/splash_viewmodel.dart' as _i36;
import '../viewmodel/todo/todo_add/todo_add_viewmodel.dart' as _i37;
import '../viewmodel/todo/todo_list/todo_list_viewmodel.dart' as _i38;
import '../webservice/todo/todo_dummy_service.dart' as _i22;
import '../webservice/todo/todo_service.dart' as _i21;
import '../webservice/todo/todo_webservice.dart' as _i44;
import 'injectable.dart' as _i45;

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
  gh.lazySingleton<_i4.BeerRepository>(() => _i4.BeerRepository(
        get<dynamic>(),
        get<_i5.BeerDaoStorage>(),
      ));
  gh.lazySingleton<_i6.BreweryRepository>(() => _i6.BreweryRepository(
        get<dynamic>(),
        get<dynamic>(),
      ));
  gh.singleton<_i7.CacheControlling>(_i8.CacheController());
  gh.singleton<_i9.ConnectivityHelper>(registerModule.connectivityHelper());
  await gh.singletonAsync<_i10.DatabaseConnection>(
    () => registerModule.provideDatabaseConnection(),
    preResolve: true,
  );
  gh.factory<_i11.DebugPlatformSelectorViewModel>(
      () => _i11.DebugPlatformSelectorViewModel(get<_i12.MainNavigator>()));
  gh.lazySingleton<_i13.ErrorUtil>(() => _i13.ErrorUtil());
  gh.lazySingleton<_i14.FlutterSecureStorage>(() => registerModule.storage());
  gh.factory<_i15.LicenseViewModel>(
      () => _i15.LicenseViewModel(get<_i12.MainNavigator>()));
  gh.lazySingleton<_i16.Localization>(() => registerModule.localization());
  gh.singleton<_i17.NetworkErrorInterceptor>(
      _i17.NetworkErrorInterceptor(get<_i9.ConnectivityHelper>()));
  gh.singleton<_i18.NetworkLogInterceptor>(_i18.NetworkLogInterceptor());
  gh.lazySingleton<_i19.SecureStorage>(
      () => _i19.SecureStorage(get<_i14.FlutterSecureStorage>()));
  await gh.singletonAsync<_i20.SharedPreferences>(
    () => registerModule.prefs(),
    preResolve: true,
  );
  gh.singleton<_i21.TodoService>(
    _i22.TodoDummyService(),
    registerFor: {_dummy},
  );
  gh.factory<_i23.BeerAddViewModel>(() => _i23.BeerAddViewModel(
        get<_i4.BeerRepository>(),
        get<_i6.BreweryRepository>(),
        get<_i12.MainNavigator>(),
      ));
  gh.lazySingleton<_i24.BeerAppDatabase>(() =>
      registerModule.provideBeerAppDatabase(get<_i10.DatabaseConnection>()));
  gh.factory<_i25.BeerDetailViewModel>(() => _i25.BeerDetailViewModel(
        get<_i12.MainNavigator>(),
        get<_i20.SharedPreferences>(),
      ));
  gh.factory<_i26.BeersOverViewViewModel>(() => _i26.BeersOverViewViewModel(
        get<_i4.BeerRepository>(),
        get<_i6.BreweryRepository>(),
        get<_i12.MainNavigator>(),
        get<_i20.SharedPreferences>(),
      ));
  gh.lazySingleton<_i9.SharedPreferenceStorage>(
      () => registerModule.sharedPreferences(get<_i20.SharedPreferences>()));
  gh.lazySingleton<_i9.SimpleKeyValueStorage>(
      () => registerModule.keyValueStorage(
            get<_i9.SharedPreferenceStorage>(),
            get<_i19.SecureStorage>(),
          ));
  gh.lazySingleton<_i27.TodoDaoStorage>(
      () => _i27.TodoDaoStorage(get<_i24.BeerAppDatabase>()));
  gh.lazySingleton<_i28.TodoRepository>(() => _i28.TodoRepository(
        get<_i21.TodoService>(),
        get<_i27.TodoDaoStorage>(),
      ));
  gh.lazySingleton<_i29.AuthStorage>(
      () => _i29.AuthStorage(get<_i9.SimpleKeyValueStorage>()));
  gh.lazySingleton<_i30.DebugRepository>(
      () => _i30.DebugRepository(get<_i9.SharedPreferenceStorage>()));
  gh.lazySingleton<_i31.LocalStorage>(() => _i31.LocalStorage(
        get<_i29.AuthStorage>(),
        get<_i9.SharedPreferenceStorage>(),
      ));
  gh.lazySingleton<_i32.LocaleRepository>(
      () => _i32.LocaleRepository(get<_i9.SharedPreferenceStorage>()));
  gh.lazySingleton<_i33.LoginRepository>(
      () => _i33.LoginRepository(get<_i29.AuthStorage>()));
  gh.singleton<_i34.NetworkAuthInterceptor>(
      _i34.NetworkAuthInterceptor(get<_i29.AuthStorage>()));
  gh.lazySingleton<_i35.RefreshRepository>(
      () => _i35.RefreshRepository(get<_i29.AuthStorage>()));
  gh.factory<_i36.SplashViewModel>(() => _i36.SplashViewModel(
        get<_i31.LocalStorage>(),
        get<_i12.MainNavigator>(),
      ));
  gh.factory<_i37.TodoAddViewModel>(() => _i37.TodoAddViewModel(
        get<_i28.TodoRepository>(),
        get<_i12.MainNavigator>(),
      ));
  gh.factory<_i38.TodoListViewModel>(() => _i38.TodoListViewModel(
        get<_i28.TodoRepository>(),
        get<_i12.MainNavigator>(),
      ));
  gh.factory<_i39.DebugThemeSelectorViewmodel>(
      () => _i39.DebugThemeSelectorViewmodel(
            get<_i12.MainNavigator>(),
            get<_i31.LocalStorage>(),
          ));
  gh.factory<_i40.DebugViewModel>(() => _i40.DebugViewModel(
        get<_i30.DebugRepository>(),
        get<_i12.MainNavigator>(),
        get<_i24.BeerAppDatabase>(),
        get<_i31.LocalStorage>(),
      ));
  gh.lazySingleton<_i41.GlobalViewModel>(() => _i41.GlobalViewModel(
        get<_i32.LocaleRepository>(),
        get<_i30.DebugRepository>(),
        get<_i31.LocalStorage>(),
        get<_i16.Localization>(),
      ));
  gh.singleton<_i42.NetworkRefreshInterceptor>(_i42.NetworkRefreshInterceptor(
    get<_i29.AuthStorage>(),
    get<_i35.RefreshRepository>(),
  ));
  gh.lazySingleton<_i9.CombiningSmartInterceptor>(
      () => registerModule.provideCombiningSmartInterceptor(
            get<_i18.NetworkLogInterceptor>(),
            get<_i34.NetworkAuthInterceptor>(),
            get<_i17.NetworkErrorInterceptor>(),
            get<_i42.NetworkRefreshInterceptor>(),
          ));
  gh.lazySingleton<_i43.Dio>(
      () => registerModule.provideDio(get<_i9.CombiningSmartInterceptor>()));
  gh.singleton<_i21.TodoService>(
    _i44.TodoWebService(get<_i43.Dio>()),
    registerFor: {
      _dev,
      _prod,
    },
  );
  return get;
}

class _$RegisterModule extends _i45.RegisterModule {}
