// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'earthquake_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EarthquakeListModel _$EarthquakeListModelFromJson(Map<String, dynamic> json) {
  return EarthquakeListModel(
    (json['earthquake'] as List)
            ?.map((e) => e == null
                ? null
                : EarthquakeModel.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
  );
}

Map<String, dynamic> _$EarthquakeListModelToJson(
        EarthquakeListModel instance) =>
    <String, dynamic>{
      'earthquake': instance.listEarthquake?.map((e) => e?.toJson())?.toList(),
    };

EarthquakeModel _$EarthquakeModelFromJson(Map<String, dynamic> json) {
  return EarthquakeModel(
    address: json['region'] as String ?? '',
    magnitude: (json['magnitude'] as num)?.toDouble() ?? 0,
    lat: json['lat'] as String ?? 0,
    lng: json['lng'] as String ?? 0,
    time: json['timestamp'] as int ?? 0,
    depth: (json['depth'] as num)?.toDouble() ?? 0,
    riskLevel: json['riskLevel'] as int ?? 0,
  );
}

Map<String, dynamic> _$EarthquakeModelToJson(EarthquakeModel instance) =>
    <String, dynamic>{
      'region': instance.address,
      'magnitude': instance.magnitude,
      'lat': instance.lat,
      'lng': instance.lng,
      'timestamp': instance.time,
      'depth': instance.depth,
      'riskLevel': instance.riskLevel,
    };
