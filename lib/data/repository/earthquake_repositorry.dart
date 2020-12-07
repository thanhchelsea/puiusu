import 'dart:convert';
import 'package:flutter_earthquake_network/data/model/earthquake_model.dart';
import 'package:flutter_earthquake_network/data/model/model.dart';
import 'package:flutter_earthquake_network/data/network/api_constant.dart';
import 'package:flutter_earthquake_network/data/network/request/push_report.dart';
import 'package:flutter_earthquake_network/utils/common.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:platform_device_id/platform_device_id.dart';

class EarthquakeRepository {
  int week=604800;// 1 tuan co 604800 giay
  int day = 86400; // 1 thang co 2592000 s
  int nowDay = int.parse(
      (new DateTime.now().millisecondsSinceEpoch / 1000).floor().toString());
  // query cac tran dong dat trong vong 1 thang
  EarthquakeRepository();
  Future<List<EarthquakeModel>> getListEarthquake() async {
    var response = await http.get(ApiConstant.LIST_EARTHQUAKE +
        ApiConstant.QUERYl_LIST(nowDay - day, nowDay));
    print(ApiConstant.LIST_EARTHQUAKE +
        ApiConstant.QUERYl_LIST(nowDay - day, nowDay));
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

  Future<List<EarthquakeModel>> getLatestListEarthquake() async {
    var response = await http.get(ApiConstant.LIST_EARTHQUAKE +
        ApiConstant.QUERYl_LIST(nowDay - week, nowDay));
    print(ApiConstant.LIST_EARTHQUAKE +
        ApiConstant.QUERYl_LIST(nowDay - week, nowDay));
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
    var response = await http.get(ApiConstant.LIST_CITY + city);
    print(ApiConstant.LIST_CITY);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      List<CityModel> listCity =
          (jsonResponse as List).map((e) => CityModel.fromJson(e)).toList();
      return listCity;
    } else {
      print(":(");
    }
  }

  Future<List<EarthquakeModel>> getEarthquakeOnCity(String city) async {
    var response = await http.get(ApiConstant.GET_EARTHQUAKE_CITY + city);
    print(ApiConstant.GET_EARTHQUAKE_CITY + city);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      List<EarthquakeModel> listEarthquke = (jsonResponse as List)
          .map((e) => EarthquakeModel.fromJson(e))
          .toList();
      return listEarthquke;
    } else {
      print(":(");
    }
  }

  Future<bool> postReport(int levelReport, int idEarthquake) async {
    String deviceId = await PlatformDeviceId.getDeviceId;
    Map<String, String> headers = {"Content-type": "application/json"};
    LocationData location = await Common.getCoordinates();
    int time = int.parse(
        (new DateTime.now().millisecondsSinceEpoch / 1000).floor().toString());
    PushReport p = new PushReport(
        idEarthquake,
        deviceId,
        location.latitude.toString(),
        location.longitude.toString(),
        levelReport,
        time);
         var response = await http
        .post(ApiConstant.Report_EARTHQUAKE, headers: headers, body: json.encode(p.toMap()));
    if(response.statusCode!=404){
      return true;
    }
    else{
      return false;
    }
  }
  Future<List<ReportModel>> getReport(int idEarthquake) async{
    var response = await http.get(ApiConstant.GET_REPORT_EARTHQUAKE +idEarthquake.toString());
    print(ApiConstant.GET_REPORT_EARTHQUAKE +idEarthquake.toString());
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      List<ReportModel> list = (jsonResponse as List)
          .map((e) => ReportModel.fromJson(e))
          .toList();

      print(list.length);
      return list;
    } else {
      print(":(");
    }
  }

}
