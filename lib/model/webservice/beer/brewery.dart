// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';

part 'brewery.g.dart';

@JsonSerializable(explicitToJson: true)
class Brewery {
  @JsonKey(name: 'id', required: true)
  final String id;
  @JsonKey(name: 'name', required: true)
  final String name;
  @JsonKey(name: 'address', required: true)
  final String address;
  @JsonKey(name: 'city', required: true)
  final String city;
  @JsonKey(name: 'country', required: true)
  final String country;

  const Brewery({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.country,
  });

  factory Brewery.fromJson(Map<String, dynamic> json) => _$BreweryFromJson(json);

  Map<String, dynamic> toJson() => _$BreweryToJson(this);

}
