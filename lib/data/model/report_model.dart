import 'package:json_annotation/json_annotation.dart';
part 'report_model.g.dart';
@JsonSerializable(explicitToJson: true)
class ReportModel {
  @JsonKey(name: "id", defaultValue: 0)
  int id;
  @JsonKey(name: "idEarthquake", defaultValue: 0)
  int idEarthquake;
  @JsonKey(name: "idDevice", defaultValue: "")
  String idDevice;
  @JsonKey(name: "latUser", defaultValue: "")
  String latUser;
  @JsonKey(name: "lngUser", defaultValue: "")
  String lngUser;
  @JsonKey(name: "reportLevel", defaultValue: 0)
  int reportLevel;
  @JsonKey(name: "timestampReport", defaultValue: 0)
  int timestampReport;

  ReportModel(this.id,this.idEarthquake, this.idDevice, this.latUser, this.lngUser,
      this.reportLevel, this.timestampReport);

  static ReportModel fromJson(Map<String, dynamic> json) =>
      _$ReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportModelToJson(this);
}