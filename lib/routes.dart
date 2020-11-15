import 'package:flutter/material.dart';
import 'package:flutter_earthquake_network/blocs/app_bloc.dart';
import 'package:flutter_earthquake_network/ui/screens/change_language._screen.dart';
import 'package:flutter_earthquake_network/ui/screens/faq_screen.dart';
import 'package:flutter_earthquake_network/ui/screens/details_screen.dart';
import 'package:flutter_earthquake_network/ui/screens/privacy_policy_screen.dart';
import 'package:flutter_earthquake_network/ui/screens/screens.dart';
import 'package:flutter_earthquake_network/ui/screens/term_and_condition_screen.dart';
import 'package:flutter_earthquake_network/ui/template/navigation_home_screen.dart';

class Routes {
  Routes._();
  //screen name
  static const String home = "/homeScreen";
  static const String searchScreen = "/searchScreen";
  static const String settingScreen = "/settings";
  static const String aboutscreen = "/about";
  static const String faqScreen = "/FAQScreen";
  static const String termAndCondition = "/term_and_conditionScreen";
  static const String privacyPolicy = "/aboutScreen";
  static const String mapSettings = "/mapSettingsScreen";
  static const String notificationSetting = "/notificationSettingScreen";
  static const String earthquakeDetais = "/details";
  static const String sosSettingsScreen = "/sosSettingsScreen";
  static const String sosSettingSMS = "/sosSettingSMS";
  static const String SOSScreen = "/SOSScreen";
  static const String alertScreen="/alert_screen";
  static const String changeLanguage="/change_language_screen";

  static String initScreen() => home;
  //init screen name
  static final routes = <String, WidgetBuilder>{
    home: (context) => NavigationHomeScreen(),//Home(),
    searchScreen: (context) => SearchScreen(),
    settingScreen: (context) => SettingScreens(),
    aboutscreen: (context) => AboutScreen(),
    faqScreen: (context) => FAQScreen(),
    termAndCondition: (context) => TermAndConditionScreen(),
    privacyPolicy: (context) => PrivacyPolicy(),
    mapSettings: (context) => MapSettingScreen(),
    notificationSetting: (context) => NotificationSettingScreen(),
    earthquakeDetais: (context) => Details(),
    sosSettingsScreen: (context) => SOSSetingsScreen(),
    sosSettingSMS: (context) => SMSSetting(),
    alertScreen: (context) => AlertScreen(),
    changeLanguage: (context) => ChangeLanguageScreen(),
  };
}
