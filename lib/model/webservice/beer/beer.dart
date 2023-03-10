// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:beer_app/model/webservice/beer/brewery.dart';
import 'package:json_annotation/json_annotation.dart';

part 'beer.g.dart';

@JsonSerializable(explicitToJson: true)
class Beer {
  @JsonKey(name: 'id', required: true)
  final String id;
  @JsonKey(name: 'name', required: true)
  final String name;
  @JsonKey(name: 'rating', required: true)
  final int rating;
  @JsonKey(name: 'thumbImageUrl', required: true)
  final String thumbImageUrl;
  @JsonKey(name: 'imageUrl', required: true)
  final String imageUrl;
  @JsonKey(name: 'brewery')
  final Brewery? brewery;

  const Beer({
    required this.id,
    required this.name,
    required this.rating,
    required this.thumbImageUrl,
    required this.imageUrl,
    this.brewery,
  });

  factory Beer.fromJson(Map<String, dynamic> json) => _$BeerFromJson(json);

  Map<String, dynamic> toJson() => _$BeerToJson(this);

}
