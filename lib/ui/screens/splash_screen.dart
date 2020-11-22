import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_earthquake_network/res/images.dart';
import 'package:flutter_earthquake_network/routes.dart';
import 'package:flutter_earthquake_network/ui/template/fintness_app_theme.dart';
import 'package:flutter_earthquake_network/utils/device.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 100), vsync: this)..repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> offsetAnimation = Tween(begin: 0.0, end: 10.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(controller)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller.reverse();
            }
          });
    WidgetsBinding.instance.addPostFrameCallback((_) => openScreen(context));
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.only(left: 30),
                width: 0.6*DeviceUtil.getDeviceWidth(context),height:0.4* DeviceUtil.getDeviceHeight(context),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.LOGO_VIETNAM),
                    fit: BoxFit.cover,
                  ),
                ),
              ),),
            AnimatedBuilder(
                animation: offsetAnimation,
                builder: (buildContext, child) {

                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    padding: EdgeInsets.only(
                        left: offsetAnimation.value + 10.0,
                        right: 10 - offsetAnimation.value),
                    child: Text("Earthquake",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color:FitnessAppTheme.nearlyBlue),),
                  );
                }),

          ],
        ),

      ),
    );
  }

  openScreen(BuildContext context) async {
    await Future.delayed(Duration(seconds: 3));
    controller.reset();
     Navigator.pushReplacementNamed(context, Routes.home);
  }
}
