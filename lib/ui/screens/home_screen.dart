import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_earthquake_network/ui/screens/screens.dart';
import 'package:flutter_earthquake_network/ui/template/app_theme.dart';
import 'package:flutter_earthquake_network/ui/template/bottom_navigation_view/bottom_bar_view.dart';
import 'package:flutter_earthquake_network/ui/template/bottom_navigation_view/tabIcon_data.dart';
import 'package:flutter_earthquake_network/ui/template/dialog_sos.dart';
import 'map_screen.dart';

import 'package:location/location.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<Home> {
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
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
                      tabBody = SettingScreens(fromMenu: false,);
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
                      tabBody = FAQScreen();
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
