import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_earthquake_network/blocs/blocs.dart';
import 'package:flutter_earthquake_network/data/model/earthquake_model.dart';
import 'package:flutter_earthquake_network/localizations.dart';
import 'package:flutter_earthquake_network/routes.dart';
import 'package:flutter_earthquake_network/ui/screens/safety_screen.dart';
import 'package:flutter_earthquake_network/ui/screens/screens.dart';
import 'package:flutter_earthquake_network/ui/template/app_theme.dart';
import 'package:flutter_earthquake_network/ui/template/bottom_navigation_view/bottom_bar_view.dart';
import 'package:flutter_earthquake_network/ui/template/bottom_navigation_view/tabIcon_data.dart';
import 'package:flutter_earthquake_network/ui/template/dialog_sos.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'map_screen.dart';

import 'package:location/location.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>
    with TickerProviderStateMixin {
  final Location location = Location();
  AnimationController animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: AppTheme.white,
  );

  _checkLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

//  @override
//  // TODO: implement wantKeepAlive
//  bool get wantKeepAlive => true;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<EarthquakeModel> messages = [];
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future onSelectNotification(String payload) async{
 //   Navigator.pushNamed(context, Routes.settingScreen);
    debugPrint("payload : $payload");
  await setState(() {
      tabBody = AlertScreen();
      tabIconsList[1].isSelected = true;
      tabIconsList[0].isSelected = false;
      tabIconsList[2].isSelected = false;
      tabIconsList[3].isSelected = false;
    });
  }

  showNotification(EarthquakeModel e) async {
    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.high, importance: Importance.max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(
        0,
        Language.of(context).getText("alert.new_earthquake"),
        e.address,
        platform,
        payload: 'notification aloooooo');
  }

  @override
  void initState() {
    tabIconsList[0].isSelected = false;
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    tabBody = MapScreen();
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      this._checkLocation();
    });

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('vn');
    var iOS = new IOSInitializationSettings();
    var initSetttings = new InitializationSettings(android: android, iOS: iOS);
    flutterLocalNotificationsPlugin..initialize(initSetttings,
        onSelectNotification: onSelectNotification);
    _firebaseMessaging.getToken().then((token) {
      print(token.toString() + " token firebase");
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        //kích hoạt khi ứng dụng đang mở và chạy ở nền trước.
        print(
            "onMessage: $message");
        final notification = message['data'];
        EarthquakeModel e;
        try {
          String id = notification['id'];
          String region = notification['region'];
          String magnitude = notification['magnitude'];
          String lat = notification['lat'];
          String lng = notification['lng'];
          String timestamp = notification['timestamp'];
          String depth = notification['depth'];
          String riskLevel = notification['riskLevel'];

          e = new EarthquakeModel(
            id: int.parse(id),
            address: region,
            magnitude: double.parse(magnitude),
            lat: lat,
            lng: lng,
            time: int.parse(timestamp),
            depth: double.parse(depth),
            riskLevel: int.parse(riskLevel),
          );
        } catch (e) {
          print(e.toString());
        }
        BlocProvider.of<AlertBloc>(context).add(AddNotification(e));
       showNotification(e);
        BlocProvider.of<HomeBloc>(context).add(Loading());
      },
      onLaunch: (Map<String, dynamic> message) async {
        // kích hoạt nếu ứng dụng bị chấm dứt hoàn toàn.
        print("onLaunch: $message");
        final notification = message['data'];
        EarthquakeModel e;
        try {
          String id = notification['id'];
          String region = notification['region'];
          String magnitude = notification['magnitude'];
          String lat = notification['lat'];
          String lng = notification['lng'];
          String timestamp = notification['timestamp'];
          String depth = notification['depth'];
          String riskLevel = notification['riskLevel'];

          e = new EarthquakeModel(
            id: int.parse(id),
            address: region,
            magnitude: double.parse(
              magnitude,
            ),
            lat: lat,
            lng: lng,
            time: int.parse(timestamp),
            depth: double.parse(depth),
            riskLevel: int.parse(riskLevel),
          );
          BlocProvider.of<AlertBloc>(context).add(AddNotification(e));
        } catch (e) {
          print(e.toString());
        }

       // showNotification(e);
      },
      onResume: (Map<String, dynamic> message) async {
        // kích hoạt nếu ứng dụng bị đóng nhưng vẫn chạy trong nền.
        print("onResume: $message");
        final notification = message['data'];
        EarthquakeModel e;
        try {
          String id = notification['id'];
          String region = notification['region'];
          String magnitude = notification['magnitude'];
          String lat = notification['lat'];
          String lng = notification['lng'];
          String timestamp = notification['timestamp'];
          String depth = notification['depth'];
          String riskLevel = notification['riskLevel'];

          e = new EarthquakeModel(
            id: int.parse(id),
            address: region,
            magnitude: double.parse(magnitude),
            lat: lat,
            lng: lng,
            time: int.parse(timestamp),
            depth: double.parse(depth),
            riskLevel: int.parse(riskLevel),
          );
          BlocProvider.of<AlertBloc>(context).add(AddNotification(e));
        } catch (e) {
          print(e.toString());
        }

//        showNotification(e);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: true),
    );
    BlocProvider.of<AlertBloc>(context).add(LoadingNotifi());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Stack(
          children: [
            tabBody,
            bottomBar(),
          ],
        ),
      ),
    );
  }

  void showDemoDialog({BuildContext context}) {
    showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) => DialogSOS(
        barrierDismissible: true,
        onCancelClick: () {},
      ),
    );
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {
            showDemoDialog(
              context: context,
            );
          },
          changeIndex: (int index) {
            switch (index) {
              case 0:
                {
                  animationController.reverse().then<dynamic>((data) {
                    if (!mounted) {
                      return;
                    }
                    setState(() {
                      tabBody = MapScreen();
                    });
                  });
                }
                break;
              case 1:
                {
                  animationController.reverse().then<dynamic>((data) {
                    if (!mounted) {
                      return;
                    }
                    setState(() {
                      tabBody = AlertScreen();
                    });
                  });
                }
                break;
              case 2:
                {
                  animationController.reverse().then<dynamic>((data) {
                    if (!mounted) {
                      return;
                    }
                    setState(() {
                      tabBody = SettingScreens(
                        fromMenu: false,
                      );
                    });
                  });
                }
                break;
              case 3:
                {
                  animationController.reverse().then<dynamic>((data) {
                    if (!mounted) {
                      return;
                    }
                    setState(() {
                      tabBody = SafetyScreen();
                    });
                  });
                }
                break;
            }
          },
        ),
      ],
    );
  }
}
