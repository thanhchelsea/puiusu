import 'package:flutter_earthquake_network/data/model/earthquake_model.dart';
import 'package:flutter_earthquake_network/data/network/api_constant.dart';
import 'package:flutter_earthquake_network/ui/widgets/earthquake_item.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class EarthquakeRepository {
  EarthquakeRepository();
  Future<List<EarthquakeModel>> getListEarthquake() async {
    var response =
        await http.get(ApiConstant.apiHost + ApiConstant.LIST_EARTHQUAKE);
    print(ApiConstant.apiHost + ApiConstant.LIST_EARTHQUAKE);
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
}
