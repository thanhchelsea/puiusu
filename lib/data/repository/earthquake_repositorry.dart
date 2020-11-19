import 'package:flutter_earthquake_network/data/model/earthquake_model.dart';
import 'package:flutter_earthquake_network/data/model/model.dart';
import 'package:flutter_earthquake_network/data/network/api_constant.dart';
import 'package:flutter_earthquake_network/ui/widgets/earthquake_item.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class EarthquakeRepository {
  EarthquakeRepository();
  Future<List<EarthquakeModel>> getListEarthquake() async {
    var response = await http.get(ApiConstant.LIST_EARTHQUAKE);
    print(ApiConstant.LIST_EARTHQUAKE);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      List<EarthquakeModel> list = (jsonResponse as List)
          .map((e) => EarthquakeModel.fromJson(e))
          .toList();
      return list;
    } else {
      print(":(");
    }
  }

  Future<List<CityModel>> getListCity(String city) async {
    var response = await http.get(ApiConstant.LIST_CITY+city);
    print(ApiConstant.LIST_CITY);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      List<CityModel> listCity =
      (jsonResponse as List).map((e) => CityModel.fromJson(e)).toList();
      return listCity;
    }
    else{
      print(":(");
    }
  }

  Future<List<EarthquakeModel>> getEarthquakeOnCity(String city) async {
    var response = await http.get(ApiConstant.GET_EARTHQUAKE_CITY+city);
    print(ApiConstant.GET_EARTHQUAKE_CITY+city);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      List<EarthquakeModel> listEarthquke =
      (jsonResponse as List).map((e) => EarthquakeModel.fromJson(e)).toList();
      return listEarthquke;
    }
    else{
      print(":(");
    }
  }
}
