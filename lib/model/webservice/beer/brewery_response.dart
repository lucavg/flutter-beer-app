// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:beer_app/model/webservice/beer/brewery.dart';
import 'package:json_annotation/json_annotation.dart';

part 'brewery_response.g.dart';

@JsonSerializable(explicitToJson: true)
class BreweryResponse {
  @JsonKey(name: 'data', required: true)
  final List<Brewery> data;

  const BreweryResponse({
    required this.data,
  });

  factory BreweryResponse.fromJson(Map<String, dynamic> json) => _$BreweryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BreweryResponseToJson(this);

}
