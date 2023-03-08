import 'package:beer_app/navigator/main_navigator.dart';
import 'package:beer_app/repository/login/login_repository.dart';
import 'package:icapps_architecture/icapps_architecture.dart';
import 'package:injectable/injectable.dart';
import 'package:beer_app/util/snackbar/error_util.dart';

@injectable // This annotation is used by the dependency injection library, it tells the library that this class can be injected, but isn't a singleton.
class LoginViewModel with ChangeNotifierEx {
  // ChangeNotifierEx is a custom class that extends ChangeNotifier. A ChangeNotifier is a class that notifies listeners when a value changes. This means that the UI will be rebuild when we call `notifyListeners();`.
  final LoginRepository _loginRepo;
  final MainNavigator _navigator;
  final ErrorUtil _errorUtil;

  var _password = '';
  var _email = '';

  LoginViewModel(
    this._loginRepo,
    this._navigator,
    this._errorUtil,
  );

  Future<void> init() async {
    // This function is called in the screen when it is created. This is not needed for the LoginViewModel, but is a good example of what a ViewModel should contain.
    // await _localStorage.checkForNewInstallation();
    final result = await _loginRepo.isLoggedIn;
    if (result) {
      _navigator.goToHome();
    } else {
      await _navigator.goToLogin();
    }
  }

  void onEmailUpdated(String email) {
    _email = email;
    notifyListeners();
  }

  void onPasswordUpdated(String password) {
    _password = password;
    notifyListeners();
  }

  Future<void> onLoginClicked() async {
    try {
      await _loginRepo.login(email: _email, password: _password);
      return _navigator.goToHome();
    } catch (e) {
      _errorUtil.showError(e);
    }
  }
}
