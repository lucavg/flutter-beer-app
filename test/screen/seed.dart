import 'package:flutter/material.dart';
import 'package:beer_app/di/injectable.dart';
import 'package:beer_app/repository/secure_storage/auth/auth_storage.dart';
import 'package:beer_app/repository/shared_prefs/local/local_storage.dart';
import 'package:beer_app/util/license.dart';
import 'package:beer_app/util/locale/localization.dart';
import 'package:beer_app/util/locale/localization_keys.dart';
import 'package:beer_app/viewmodel/debug/debug_viewmodel.dart';
import 'package:beer_app/viewmodel/global/global_viewmodel.dart';
import 'package:beer_app/viewmodel/license/license_viewmodel.dart';
import 'package:mockito/mockito.dart';

import '../util/test_extensions.dart';

void seedDebugViewModel() {
  final debugViewModel = getIt<DebugViewModel>();
  when(debugViewModel.slowAnimationsEnabled).thenReturn(false);
  // ignore: void_checks
  when(debugViewModel.onTargetPlatformClicked()).thenReturn(1);
  // ignore: void_checks
  when(debugViewModel.onSelectLanguageClicked()).thenReturn(1);
  // ignore: void_checks
  when(debugViewModel.onLicensesClicked()).thenReturn(1);
}

void seedsLicenses() {
  final licenseViewModel = getIt<LicenseViewModel>();
  // ignore: void_checks
  when(licenseViewModel.onBackClicked()).thenReturn(1);
  when(licenseViewModel.licenses).thenReturn([
    for (var i = 0; i < 100; ++i)
      License(
        name: 'name$i',
        version: 'version$i',
        homepage: 'homepage$i',
        license: 'license$i',
        repository: 'repository$i',
      ),
  ]);
}

void seedGlobalViewModel() {
  final globalViewModel = getIt<GlobalViewModel>();
  when(globalViewModel.targetPlatform).thenAnswer((_) => TargetPlatform.android);
  when(globalViewModel.showsTranslationKeys).thenAnswer((_) => false);
  when(globalViewModel.locale).thenAnswer((_) => const Locale('en'));
  when(globalViewModel.themeMode).thenAnswer((_) => ThemeMode.system);
  when(globalViewModel.getCurrentPlatform()).thenReturn(LocalizationKeys.generalLabelAndroid);
  when(globalViewModel.getCurrentLanguage()).thenReturn('English');
  when(globalViewModel.localizationInstance).thenReturn(Localization());
  when(globalViewModel.supportedLocales).thenReturn(const [Locale('en'), Locale('nl')]);
  // ignore: void_checks
  when(globalViewModel.dispose()).thenReturn(1);
}

void verifyGlobalViewModel() {
  final globalViewModel = getIt<GlobalViewModel>();
  verify(globalViewModel.targetPlatform);
  verify(globalViewModel.locale);
  verify(globalViewModel.themeMode);
  verify(globalViewModel.init()).calledOnce();
}

void seedAuthStorage() {
  final authStorage = getIt<AuthStorage>();
  when(authStorage.getAccessToken()).thenAnswer((_) => Future.value('accessToken'));
  when(authStorage.getRefreshToken()).thenAnswer((_) => Future.value('refreshToken'));
  when(authStorage.isLoggedIn).thenReturn(true);
}

void seedLocalStorage() {
  final localStorage = getIt<LocalStorage>();
  when(localStorage.getThemeMode()).thenReturn(ThemeMode.system);
}
