import 'package:beer_app/model/webservice/login/login_response.dart';
import 'package:beer_app/model/webservice/login/login_request.dart';

abstract class LoginService {
  Future<LoginResponse> login(LoginRequest request);
}
