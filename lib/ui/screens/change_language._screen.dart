import 'package:flutter/material.dart';
import 'package:flutter_earthquake_network/res/colors.dart';
import 'package:flutter_earthquake_network/res/dimens.dart';
import 'package:flutter_earthquake_network/ui/template/app_theme.dart';
import 'package:flutter_earthquake_network/ui/widgets/base_screen_method.dart';
import 'package:flutter_earthquake_network/utils/device.dart';

class ChangeLanguageScreen extends StatefulWidget {
  @override
  _ChangeLanguageScreenState createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreenMethod(
      iconBack: true,
      title: "settings.change_language",
      body: Column(
        children: <Widget>[
          Container(
            width: 300,
            height: 50,
            color: Colors.pinkAccent,
            child: Row(
              children: <Widget>[
                Container(
                  child: Text("Thay đổi ngôn ngữ"),
                  margin: EdgeInsets.only(le),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}
