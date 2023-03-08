// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:beer_app/model/webservice/beer/beer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'beer_response.g.dart';

@JsonSerializable(explicitToJson: true)
class BeerResponse {
  @JsonKey(name: 'data', required: true)
  final List<Beer> data;

  const BeerResponse({
    required this.data,
  });

  factory BeerResponse.fromJson(Map<String, dynamic> json) => _$BeerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BeerResponseToJson(this);

}
