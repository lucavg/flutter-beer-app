// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brewery_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BreweryResponse _$BreweryResponseFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['data'],
  );
  return BreweryResponse(
    data: (json['data'] as List<dynamic>)
        .map((e) => Brewery.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$BreweryResponseToJson(BreweryResponse instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
    };
