import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import '../constants.dart';
import '../data/model/phone_number.dart';
import '../data/model/phone_number.dart';

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
}
