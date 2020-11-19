import 'package:json_annotation/json_annotation.dart';
part 'city_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CityModel {
//  "name": "Hà Giang",
//  "slug": "ha-giang",
//  "type": "tinh",
//  "name_with_type": "Tỉnh Hà Giang",
  @JsonKey(name: "name", defaultValue: "")
  String name;

  @JsonKey(name: "slug", defaultValue: "")
  String slug;

  @JsonKey(name: "type", defaultValue: "")
  String type;

  @JsonKey(name: "name_with_type", defaultValue: "")
  String nameWithType;

  CityModel(this.name, this.slug, this.type, this.nameWithType);

  static CityModel fromJson(Map<String, dynamic> json) =>
      _$CityModelFromJson(json);

  Map<String, dynamic> toJson() => _$CityModelToJson(this);
}
