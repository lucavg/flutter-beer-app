// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Beer _$BeerFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'name', 'rating', 'thumbImageUrl', 'imageUrl'],
  );
  return Beer(
    id: json['id'] as String,
    name: json['name'] as String,
    rating: json['rating'] as int,
    thumbImageUrl: json['thumbImageUrl'] as String,
    imageUrl: json['imageUrl'] as String,
    brewery: json['brewery'] == null
        ? null
        : Brewery.fromJson(json['brewery'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BeerToJson(Beer instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rating': instance.rating,
      'thumbImageUrl': instance.thumbImageUrl,
      'imageUrl': instance.imageUrl,
      'brewery': instance.brewery?.toJson(),
    };
