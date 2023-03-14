import 'package:beer_app/di/injectable.dart';
import 'package:beer_app/navigator/main_navigator.dart';
import 'package:beer_app/repository/login/login_repository.dart';
import 'package:beer_app/repository/shared_prefs/local/local_storage.dart';
import 'package:beer_app/viewmodel/splash/splash_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../di/injectable_test.mocks.dart';
import '../../di/test_injectable.dart';
import '../../util/test_extensions.dart';

void main() {
  late SplashViewModel sut;
  late LocalStorage localStorage;
  late MainNavigator navigator;
  late LoginRepository loginRepo;

  setUp(() async {
    await initTestInjectable();
    navigator = MockMainNavigator();
    localStorage = MockLocalStorage();
    loginRepo = getIt();
    sut = SplashViewModel(localStorage, navigator, loginRepo);
  });

  test('SplashViewModel init', () async {
    await sut.init();
    verify(navigator.goToHome()).calledOnce();
    verifyNoMoreInteractions(navigator);
  });
}
