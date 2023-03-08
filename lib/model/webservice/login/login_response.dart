// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:beer_app/model/webservice/login/login_response_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginResponse {
  @JsonKey(name: 'data', required: true)
  final LoginResponseData data;

  const LoginResponse({
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

}
