import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_earthquake_network/blocs/blocs.dart';
import 'package:flutter_earthquake_network/localizations.dart';
import 'package:flutter_earthquake_network/res/images.dart';
import 'package:flutter_earthquake_network/ui/widgets/base_screen_method.dart';
import 'package:flutter_earthquake_network/utils/common.dart';

class ChangeLanguageScreen extends StatefulWidget {
  @override
  _ChangeLanguageScreenState createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  bool _isShowSlection = false;
  List<Item> listLanguage = [];
  String _language = "";

  Future<String> getLanguage() async {
    String language = await Common.getTypeLanguage();
    setState(() {
      _language = language;
      listLanguage = [
        new Item(
            "Vietnam",
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(AppImages.ICON_LOGO_VIETNAM),
            ),
            "vi",
            language == "vi" ? true : false),
        new Item(
            "English",
            CircleAvatar(
              backgroundImage: AssetImage(AppImages.ICON_LOGO_ENGLAND),
            ),
            "en",
            language == "en" ? true : false),
      ];
    });
    return language;
  }

  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    getLanguage();
    print(_language + "ten ");
    return BaseScreenMethod(
      iconBack: true,
      title: "settings.change_language",
      body: Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              setState(() {
                _isShowSlection = !_isShowSlection;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.3),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              margin: EdgeInsets.only(left: 30, right: 30, top: 20),
              padding:
              EdgeInsets.only(left: 10, right: 10, top: 18, bottom: 18),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: Text(
                        Language.of(context)
                            .getText("settings.select_language"),
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Icon(Icons.keyboard_arrow_down),
                  ),
                ],
              ),
            ),
          ),
          _isShowSlection
              ? Container(
            margin: EdgeInsets.only(left: 30, right: 30, top: 20),
            padding: EdgeInsets.only(left: 10, right: 10, top: 18),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.3),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Column(
              children: List.generate(listLanguage.length, (index) {
                return InkWell(
                  onTap: () {
                    BlocProvider.of<AppBloc>(context).add(
                        ChangeLanguage(listLanguage[index].shortName));
                    getLanguage();
                  },
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 6,
                          child: Container(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 24,
                                  height: 24,
                                  margin: EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.pink,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: listLanguage[index].icon,
                                  ),
                                ),
                                Container(
                                  child: Center(
                                    //margin: EdgeInsets.only(right: 10,bottom: 10),
                                    child: Text(
                                      listLanguage[index].name,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: listLanguage[index].ischeck
                                ? Icon(Icons.check)
                                : Container(),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
            ),
          )
              : Container(),
        ],
      ),
    );
  }
}

class Item {
  final String name;
  final CircleAvatar icon;
  bool ischeck;
  String shortName;
  Item(this.name, this.icon, this.shortName, this.ischeck);
}
