// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginRequest {
  @JsonKey(name: 'username', required: true)
  final String username;
  @JsonKey(name: 'password', required: true)
  final String password;
  @JsonKey(name: 'deviceId', required: true)
  final String deviceId;

  const LoginRequest({
    required this.username,
    required this.password,
    required this.deviceId,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);

}
