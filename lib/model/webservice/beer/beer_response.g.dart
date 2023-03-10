// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BeerResponse _$BeerResponseFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['data'],
  );
  return BeerResponse(
    data: (json['data'] as List<dynamic>)
        .map((e) => Beer.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$BeerResponseToJson(BeerResponse instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
    };
