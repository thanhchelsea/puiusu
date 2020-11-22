// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportModel _$ReportModelFromJson(Map<String, dynamic> json) {
  return ReportModel(
    json['id'] as int ?? 0,
    json['idEarthquake'] as int ?? 0,
    json['idDevice'] as String ?? '',
    json['latUser'] as String ?? '',
    json['lngUser'] as String ?? '',
    json['reportLevel'] as int ?? 0,
    json['timestampReport'] as int ?? 0,
  );
}

Map<String, dynamic> _$ReportModelToJson(ReportModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'idEarthquake': instance.idEarthquake,
      'idDevice': instance.idDevice,
      'latUser': instance.latUser,
      'lngUser': instance.lngUser,
      'reportLevel': instance.reportLevel,
      'timestampReport': instance.timestampReport,
    };
