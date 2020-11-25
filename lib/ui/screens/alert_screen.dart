import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_earthquake_network/res/colors.dart';
import 'package:flutter_earthquake_network/ui/template/design_course_app_theme.dart';
import 'package:flutter_earthquake_network/ui/template/fintness_app_theme.dart';
import 'package:flutter_earthquake_network/ui/widgets/widgets.dart';
import 'package:flutter_earthquake_network/utils/device.dart';

class AlertScreen extends StatelessWidget {

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
