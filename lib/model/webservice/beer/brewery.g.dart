// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brewery.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Brewery _$BreweryFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'name', 'address', 'city', 'country'],
  );
  return Brewery(
    id: json['id'] as String,
    name: json['name'] as String,
    address: json['address'] as String,
    city: json['city'] as String,
    country: json['country'] as String,
  );
}

Map<String, dynamic> _$BreweryToJson(Brewery instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'city': instance.city,
      'country': instance.country,
    };
