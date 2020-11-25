import 'package:flutter/material.dart';
import 'package:flutter_earthquake_network/localizations.dart';
import 'package:flutter_earthquake_network/res/dimens.dart';
import 'package:flutter_earthquake_network/routes.dart';
import 'package:flutter_earthquake_network/ui/widgets/base_screen_method.dart';
import 'package:flutter_earthquake_network/utils/device.dart';

class SettingScreens extends StatelessWidget {
  bool fromMenu;

  SettingScreens({this.fromMenu});

  Widget itemSetting(String title, String description, BuildContext context,
      String jumpScreen,Icon icon) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, jumpScreen);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: icon,
          ),
          Column(
            children: <Widget>[
              Container(
               // width: DeviceUtil.getDeviceWidth(context),
                child: Padding(
                  padding: const EdgeInsets.only(
                  //  top: AppDimens.SIZE_15,
                    left: AppDimens.SIZE_15,
                    bottom: AppDimens.SIZE_30,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        Language.of(context).getText(title),
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: AppDimens.SIZE_20,
                        ),
                      ),
                      Text(
                        description != null
                            ? Language.of(context).getText(description)
                            : "",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: AppDimens.SIZE_15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    fromMenu = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: BaseScreenMethod(
        iconBack: fromMenu,
        title: "home.settings",
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: AppDimens.SIZE_10),
            child: Column(
              children: <Widget>[

                Container(
                  child: itemSetting(
                    "settings.maps",
                    "settings.descriptionMap",
                    context,
                    Routes.mapSettings,   Icon(Icons.map,color: Colors.green,)
                  ),
                ),
                Container(
                  child: itemSetting(
                    "settings.sos",
                    "settings.descriptionSOS",
                    context,
                    Routes.sosSettingsScreen,   Icon(Icons.contact_mail,color:Colors.amber)
                  ),
                ),
                Container(
                  child: itemSetting(
                    "settings.change_language",
                    "settings.des_change_language",
                    context,
                    Routes.changeLanguage,   Icon(Icons.language,color:Colors.blue)
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
