import 'package:json_annotation/json_annotation.dart';
part 'earthquake_model.g.dart';


@JsonSerializable(explicitToJson: true)
class EarthquakeListModel {
  @JsonKey(name: "earthquake", defaultValue: [])
  List<EarthquakeModel> listEarthquake;
  EarthquakeListModel(this.listEarthquake);
}

@JsonSerializable(explicitToJson: true)
class EarthquakeModel {
  @JsonKey(name: "region", defaultValue: "")
  String address;

  @JsonKey(name: "magnitude", defaultValue: 0)
  double magnitude;

  @JsonKey(name: "lat", defaultValue: 0)
  String lat;

  @JsonKey(name: "lng", defaultValue: 0)
  String lng;

  @JsonKey(name: "timestamp", defaultValue: 0)
  int time;

  @JsonKey(name: "depth", defaultValue: 0)
  double depth;

  @JsonKey(name: "riskLevel", defaultValue: 0)
  int riskLevel;

  EarthquakeModel(
      {this.address,
      this.magnitude,
      this.lat,
      this.lng,
      this.time,
      this.depth,
      this.riskLevel});

  static EarthquakeModel fromJson(Map<String, dynamic> json) =>
      _$EarthquakeModelFromJson(json);

  Map<String, dynamic> toJson() => _$EarthquakeModelToJson(this);
}
