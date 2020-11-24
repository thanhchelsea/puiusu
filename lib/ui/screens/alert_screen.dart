import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_earthquake_network/res/colors.dart';
import 'package:flutter_earthquake_network/ui/template/design_course_app_theme.dart';
import 'package:flutter_earthquake_network/ui/template/fintness_app_theme.dart';
import 'package:flutter_earthquake_network/ui/widgets/widgets.dart';
import 'package:flutter_earthquake_network/utils/device.dart';

class AlertScreen extends StatelessWidget {
  Widget itemAlert(
      double mangtitude, String city, String time, BuildContext context) {
    return Column(
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
                    width: 60,height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        mangtitude.toString(),
                        style: TextStyle(
                            color: DesignCourseAppTheme.nearlyWhite,
                            fontWeight: FontWeight.w600),
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
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(text:"Xảy ra động đất tại " ,style: TextStyle(
                              color: FitnessAppTheme.nearlyBlack,
                              fontSize: 16,
                              letterSpacing: 0.27,
                              //color: DesignCourseAppTheme.darkerText,
                            )),
                            TextSpan(text:city ,style: TextStyle(
                              color: FitnessAppTheme.nearlyBlack,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              letterSpacing: 0.27,
                              //color: DesignCourseAppTheme.darkerText,
                            )),
                          ]
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 8),
                          child: Text(time,style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: DesignCourseAppTheme.grey,
                          ),))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseScreenMethod(
        title: "home.alert",
        body: MessagingWidget(),
      ),
    );
  }
}
