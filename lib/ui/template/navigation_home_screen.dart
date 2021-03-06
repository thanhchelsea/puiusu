import 'package:flutter/material.dart';
import 'package:flutter_earthquake_network/ui/screens/screens.dart';
import 'package:flutter_earthquake_network/ui/template/custom_drawer/home_drawer.dart';
import 'app_theme.dart';
import 'custom_drawer/drawer_user_controller.dart';

class NavigationHomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget screenView;
  DrawerIndex drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = Home();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() {
          screenView = Home();
        });
      } else if (drawerIndex == DrawerIndex.Setting) {
        setState(() {
          screenView = SettingScreens(fromMenu: false,);
        });
      } else if (drawerIndex == DrawerIndex.About) {
        setState(() {
          screenView = AboutScreen();
        });
      } else if (drawerIndex == DrawerIndex.FAQ) {
        setState(() {
          screenView = FAQScreen();
        });
      } else if(drawerIndex == DrawerIndex.Terms_And_Conditions) {
        setState(() {
          screenView = TermAndConditionScreen();
        });
      } else {
        setState(() {
          screenView = PrivacyPolicy();
        });
      }
    }
  }
}
