import 'package:flutter/material.dart';
import 'package:flutter_earthquake_network/res/images.dart';
import 'package:flutter_earthquake_network/ui/widgets/widgets.dart';
import 'package:flutter_earthquake_network/utils/device.dart';

import '../../localizations.dart';

class SafetyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BaseScreenMethod(
      title: "attack",
      body: Prepare(),
    ));
  }
}

class Prepare extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget item({String des, Image image, String title}) {
      return Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 10),
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),
            ),
          ),
          Container(
            child: image,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 30, top: 10),
            alignment: Alignment.centerLeft,
            child: Text(
              des,
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
          ),
        ],
      );
    }

    return Container(
      width: DeviceUtil.getDeviceWidth(context),
      height: DeviceUtil.getDeviceHeight(context),
      child: ListView(
        padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 50),
        children: <Widget>[
          item(
            title: Language.of(context).getText("bp1.title"),
            image: Image(
              image: AssetImage(AppImages.BP1),
            ),
            des:  Language.of(context).getText("bp1.content")
          ),
          item(
              title: Language.of(context).getText("bp2.title"),
              image: Image(
                image: AssetImage(AppImages.BP2),
              ),
              des:  Language.of(context).getText("bp2.content")
          ),
          item(
              title: Language.of(context).getText("bp3.title"),
              image: Image(
                image: AssetImage(AppImages.BP3),
              ),
              des:  Language.of(context).getText("bp3.content")
          ),
          item(
              title: Language.of(context).getText("bp4.title"),
              image: Image(
                image: AssetImage(AppImages.BP4),
              ),
              des:  Language.of(context).getText("bp4.content")
          )
        ],
      ),
    );
  }
}
