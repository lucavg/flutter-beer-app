// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:beer_app/model/webservice/beer/beer.dart';
import 'package:beer_app/model/webservice/beer/brewery.dart';
import 'package:json_annotation/json_annotation.dart';

part 'beer_with_brewery.g.dart';

@JsonSerializable(explicitToJson: true)
class BeerWithBrewery {
  @JsonKey(name: 'beer', required: true)
  final Beer beer;
  @JsonKey(name: 'brewery')
  final Brewery? brewery;

  const BeerWithBrewery({
    required this.beer,
    this.brewery,
  });

  factory BeerWithBrewery.fromJson(Map<String, dynamic> json) => _$BeerWithBreweryFromJson(json);

  Map<String, dynamic> toJson() => _$BeerWithBreweryToJson(this);

}
