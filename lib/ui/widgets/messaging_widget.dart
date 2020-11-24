import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_earthquake_network/blocs/alert_bloc.dart';
import 'package:flutter_earthquake_network/blocs/base_bloc/base.dart';
import 'package:flutter_earthquake_network/blocs/blocs.dart';
import 'package:flutter_earthquake_network/data/model/model.dart';
import 'package:flutter_earthquake_network/res/resources.dart';
import 'package:flutter_earthquake_network/ui/template/design_course_app_theme.dart';
import 'package:flutter_earthquake_network/ui/template/fintness_app_theme.dart';
import 'package:flutter_earthquake_network/utils/common.dart';
import 'package:flutter_earthquake_network/utils/hex_color.dart';
import 'package:flutter_earthquake_network/utils/ultils.dart';
import '../../routes.dart';

class MessagingWidget extends StatefulWidget {
  @override
  _MessagingWidgetState createState() => _MessagingWidgetState();
}

class _MessagingWidgetState extends State<MessagingWidget> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.getToken().then((token) {
      print(token.toString() + " token firebase");
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        //kích hoạt khi ứng dụng đang mở và chạy ở nền trước.
        print("onMessage: $message"); //{notification: {title: run nowwwwww, body: die you ....quickly}, data: {id: 1}}
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
          print(e.time.toString() + ' do lon');
        } catch (e) {
          print(e.toString());
        }
        BlocProvider.of<AlertBloc>(context).add(AddNotification(e));
//        setState(() {
//          messages.add(Message(
//              title: notification['region'], body: notification['timestamp'].toString(),e: e));
//        });
      },
      onLaunch: (Map<String, dynamic> message) async {
        // kích hoạt nếu ứng dụng bị chấm dứt hoàn toàn.
        print("onLaunch: $message");
        final notification = message['data'];    EarthquakeModel e;
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
          print(e.id.toString() + ' do lon');
        } catch (e) {
          print(e.toString());
        }
        setState(() {
          messages.add(Message(
            title: '${notification['region']}',
            body: '${notification['timestamp']}',
            e: e
          ));
        });
        print("cai dm");
      },
      onResume: (Map<String, dynamic> message) async {
        // kích hoạt nếu ứng dụng bị đóng nhưng vẫn chạy trong nền.
        print("onResume: $message");
        //   Navigator.pushNamed(context, Routes.settingScreen,);
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
          print(e.id.toString() + ' do lon');
        } catch (e) {
          print(e.toString());
        }
//         print(e.time.toString());
        setState(() {
          messages.add(Message(
            title: '${notification['region']}',
            body: '${notification['timestamp']}',
             e: e
          ));
        });
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
  //  print(messages.length);
    return BlocConsumer<AlertBloc,BaseState>(
      listener: (context, state) {
        print(AlertBloc.listEarthquakeLatest.length);
      },
      builder: (context, state) {
        return Container(
          width: DeviceUtil.getDeviceWidth(context),
          height: DeviceUtil.getDeviceWidth(context),
          child: ListView(
            padding: EdgeInsets.only(top: 0),
            children: AlertBloc.listEarthquakeLatest.map(buildMessage).toList(),
          ),
        );
      },
    );
  }

  Widget itemAlert(
      EarthquakeModel e, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.earthquakeDetais,
          arguments: e,
        );
      },
      child: Column(
        children: <Widget>[
          Container(
            width: DeviceUtil.getDeviceWidth(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          e.magnitude.toString(),
                          style: TextStyle(
                            fontSize: 20,
                              color: DesignCourseAppTheme.nearlyWhite,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    margin: EdgeInsets.only(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: "Xảy ra động đất tại ",
                                style: TextStyle(
                                  color: FitnessAppTheme.nearlyBlack,
                                  fontSize: 16,
                                  letterSpacing: 0.27,
                                  //color: DesignCourseAppTheme.darkerText,
                                )),
                            TextSpan(
                                text: e.address,
                                style: TextStyle(
                                  color: FitnessAppTheme.nearlyBlack,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  letterSpacing: 0.27,
                                  //color: DesignCourseAppTheme.darkerText,
                                )),
                          ]),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 8),
                            child: Text(
                              Common.readTimestamp(int.parse(e.time.toString()), context),
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: DesignCourseAppTheme.grey,
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMessage(EarthquakeModel e) => Container(
        padding: EdgeInsets.all(10),
        color: HexColor('#e6faff'),
        child: itemAlert( e, context),
      );
}
