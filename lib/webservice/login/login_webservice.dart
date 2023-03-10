import 'package:beer_app/model/webservice/login/login_request.dart';
import 'package:beer_app/model/webservice/login/login_response.dart';
import 'package:beer_app/webservice/login/login_service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'login_webservice.g.dart';

@Singleton(as: LoginService)
@RestApi()
abstract class LoginWebService extends LoginService {
  @factoryMethod
  factory LoginWebService(Dio dio) = _LoginWebService;

  @override
  @POST('/auth/login')
  Future<LoginResponse> login(@Body() LoginRequest request);
}