import 'package:beer_app/navigator/main_navigator.dart';
import 'package:beer_app/repository/login/login_repository.dart';
import 'package:beer_app/repository/shared_prefs/local/local_storage.dart';
import 'package:icapps_architecture/icapps_architecture.dart';
import 'package:injectable/injectable.dart';

@injectable
class SplashViewModel with ChangeNotifierEx {
  final LocalStorage _localStorage;
  final MainNavigator _navigator;
  final LoginRepository _loginRepo;

  SplashViewModel(this._localStorage, this._navigator, this._loginRepo);

  Future<void> init() async {
    await _localStorage.checkForNewInstallation();
    final result = await _loginRepo.isLoggedIn;
    if (result) {
      _navigator.goToHome();
    } else {
      await _navigator.goToLogin();
    }
  }
}
