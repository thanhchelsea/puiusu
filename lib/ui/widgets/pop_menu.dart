import 'package:flutter/material.dart';
import 'package:flutter_earthquake_network/res/dimens.dart';

import '../../localizations.dart';
import '../../routes.dart';
class PopMenu extends StatefulWidget {
  final bool isRefresh;

  PopMenu({this.isRefresh});

  @override
  _PopMenuState createState() => _PopMenuState();
}

class _PopMenuState extends State<PopMenu> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,
              child: InkWell(
                onTap: (){
                  Navigator.pushNamed(context, Routes.settingScreen, arguments: true);
                },
                child: Row(
                  children: <Widget>[
                    Text(Language.of(context).getText("home.settings")),
                  ],
                ),
              ),
            ),
            (widget.isRefresh) ? PopupMenuItem(
              value: 2,
              child: Row(
                children: <Widget>[
                  Text(Language.of(context).getText("home.refresh")),
                ],
              ),
            ) : null,
          ]),
    );
  }
}

