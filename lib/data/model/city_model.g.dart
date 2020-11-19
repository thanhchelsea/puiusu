// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityModel _$CityModelFromJson(Map<String, dynamic> json) {
  return CityModel(
    json['name'] as String ?? '',
    json['slug'] as String ?? '',
    json['type'] as String ?? '',
    json['name_with_type'] as String ?? '',
  );
}

Map<String, dynamic> _$CityModelToJson(CityModel instance) => <String, dynamic>{
      'name': instance.name,
      'slug': instance.slug,
      'type': instance.type,
      'name_with_type': instance.nameWithType,
    };
