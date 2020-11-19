import 'package:flutter/cupertino.dart';
import 'package:flutter_earthquake_network/localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import '../constants.dart';
import 'package:intl/intl.dart';

class Common {
  static Future saveTypeLanguage(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SPrefCache.PREF_KEY_LANGUAGE, language);
  }

  static Future<String> getTypeLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String typeLanguage = prefs.getString(SPrefCache.PREF_KEY_LANGUAGE);
    return typeLanguage;
  }

  static Future changTypeMap(String typeMap) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(SPrefCache.TYPE_MAP, typeMap);
  }

  static Future<String> getTypeMap() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String typeMap = prefs.getString(SPrefCache.TYPE_MAP);
    print(typeMap);
    return typeMap;
  }

  static Future saveListPhone(String s) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(SPrefCache.LIST_PHONE, s);
  }

  static Future<String> getListPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String dsPhone ;
    dsPhone = prefs.getString(SPrefCache.LIST_PHONE);
    if(dsPhone!=null){
      return dsPhone;
    }
    else return null;
  }

  static Future saveMessageSOS(String message) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(SPrefCache.MESSAGE_SOS, message);
  }

  static Future<String> getMessageSOS() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String messageSOS = prefs.getString(SPrefCache.MESSAGE_SOS);
    return messageSOS;
  }

  static Future<Coordinates> getCoordinates() async {
    LocationData myLocation;
    Coordinates coordinates =
        new Coordinates(myLocation.latitude, myLocation.longitude);
    return coordinates;
  }

  static Future<String> getUserLocation() async {
    String locate = "";
    String latlng = "";
    LocationData myLocation;
    Location location = new Location();
    bool _serviceEnabled;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
    }
    if (_serviceEnabled) {
      try {
        myLocation = await location.getLocation();
        final coordinates =
            new Coordinates(myLocation.latitude, myLocation.longitude);
        var addresses =
            await Geocoder.local.findAddressesFromCoordinates(coordinates);
        var first = addresses.first;
        locate = first.addressLine;
        latlng = "Latitude :" +
            first.coordinates.latitude.toString() +
            "\nLongitude :" +
            first.coordinates.longitude.toString();
        print(locate + latlng);
      } catch (e) {
        if (e.code == 'PERMISSION_DENIED') {
          // error = 'please grant permission';
        }
        if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
          //error = 'permission denied- please enable it from app settings';print("sai2");
        }
        myLocation = null;
      }
    }
    return locate + "\n" + latlng;
  }
  static int readTimestampToMonth(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('yyyy-MM-dd ');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    int time=int.parse((diff.inDays/7).floor().toString()) ;
    return time;

  }
 static String readTimestamp(int timestamp,BuildContext context) {
    var now = DateTime.now();
    var format = DateFormat('yyyy-MM-dd ');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() +" "+ Language.of(context).getText("day_ago");
      } else {
        time = diff.inDays.toString() + " "+Language.of(context).getText("day_ago");
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString()+" " + Language.of(context).getText("week_ago");
      } else {

        time = (diff.inDays / 7).floor().toString()+" " +  Language.of(context).getText("week_ago");
      }
    }
    return time;
  }

 static String _getDirection(double val, [bool isLongitude = false]) {
    if(!isLongitude)
      return val < 0 ? 'S' : 'N';
    else
      return val < 0 ? 'W' : 'E';
  }
  static String latitudeToHumanReadableString(double latitude) {
    String direction = _getDirection(latitude);
    latitude = latitude.abs();
    int degrees = latitude.truncate();
    latitude = (latitude - degrees) * 60;
    int minutes = latitude.truncate();
    int seconds = ((latitude - minutes) * 60).truncate();
    return '$direction $degrees°$minutes\'$seconds\"';
  }

 static String longitudeToHumanReadableString(double longitude) {
    String direction = _getDirection(longitude, true);
    longitude = longitude.abs();
    int degrees = longitude.truncate();
    longitude = (longitude - degrees) * 60;
    int minutes = longitude.truncate();
    int seconds = ((longitude - minutes) * 60).truncate();
    return '$direction $degrees°$minutes\'$seconds\"';
  }

  static int circleCount(double magntitude){
    if(magntitude>=1&&magntitude<=4){
      return 3;
    }
    else{
      if(magntitude>4&&magntitude<=4.9){
        return 4;
      }
      else{
        if(magntitude>=5&&magntitude<=5.9){
          return 5;
        }
        else{
          if(magntitude>=6&&magntitude<=6.9){
            return 6;
          }
          else{
            return 7;
          }
        }
      }
    }
  }
}
