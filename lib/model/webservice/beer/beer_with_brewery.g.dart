// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beer_with_brewery.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BeerWithBrewery _$BeerWithBreweryFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['beer'],
  );
  return BeerWithBrewery(
    beer: Beer.fromJson(json['beer'] as Map<String, dynamic>),
    brewery: json['brewery'] == null
        ? null
        : Brewery.fromJson(json['brewery'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BeerWithBreweryToJson(BeerWithBrewery instance) =>
    <String, dynamic>{
      'beer': instance.beer.toJson(),
      'brewery': instance.brewery?.toJson(),
    };
