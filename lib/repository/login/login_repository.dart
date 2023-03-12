import 'package:beer_app/model/webservice/login/login_request.dart';
import 'package:beer_app/repository/secure_storage/auth/auth_storage.dart';
import 'package:beer_app/webservice/login/login_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
abstract class LoginRepository {
  @factoryMethod
  factory LoginRepository(AuthStorage storage, LoginService loginService) = _LoginRepository;

  Future<bool> get isLoggedIn;

  Future<void> login({required String email, required String password});
}

class _LoginRepository implements LoginRepository {
  final AuthStorage _storage;
  final LoginService _loginService;
  _LoginRepository(this._storage, this._loginService);

  @override
  Future<bool> get isLoggedIn => _storage.hasLoggedInUser();

  @override
  Future<void> login({required String email, required String password}) async {
    final tokens = await _loginService.login(LoginRequest(username: email, password: password, deviceId: 'MYDEVICE'));
    await _storage.saveUserCredentials(accessToken: tokens.data.accessToken, refreshToken: tokens.data.refreshToken);
  }
}
