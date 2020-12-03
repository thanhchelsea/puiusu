import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_earthquake_network/ui/widgets/widgets.dart';
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
