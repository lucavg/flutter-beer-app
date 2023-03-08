// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';

part 'login_response_data.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginResponseData {
  @JsonKey(name: 'accessToken', required: true)
  final String accessToken;
  @JsonKey(name: 'refreshToken', required: true)
  final String refreshToken;

  const LoginResponseData({
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginResponseData.fromJson(Map<String, dynamic> json) => _$LoginResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseDataToJson(this);

}
