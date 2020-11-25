import 'package:flutter/material.dart';
import 'package:flutter_earthquake_network/localizations.dart';
import 'package:flutter_earthquake_network/routes.dart';
import 'package:flutter_earthquake_network/ui/widgets/pop_menu.dart';
import 'package:flutter_earthquake_network/utils/device.dart';

class BaseScreenMethod extends StatelessWidget {
  final String title;
  final String titleCity;
  final bool iconMoreMenu;
  final bool iconShare;
  final bool iconSearch;
  final bool iconBack;
  final Widget body;
  Function  shareImage;

  BaseScreenMethod({
    Key key,
    this.title,
    this.titleCity,
    this.iconMoreMenu,
    this.iconShare,
    this.iconBack,
    this.body,
    this.iconSearch,
    this.shareImage,
  }) : super(key: key);

  Widget getAppBarUI(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            offset: const Offset(0, 2),
            blurRadius: 8.0,
          ),
        ],
      ),
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            left: 8,
            right: 8,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                width: DeviceUtil.getDeviceWidth(context),
                alignment: Alignment.centerLeft,
                height: AppBar().preferredSize.height,
                child: Container(
                  color: Colors.transparent,
                  child: iconBack != null && iconBack
                      ? InkWell(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(32.0),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.arrow_back),
                          ),
                        )
                      : Container(),
                ),
              ),
              Container(
                width: DeviceUtil.getDeviceWidth(context),
                alignment: Alignment.center,
                child: Text(
                  title != null
                      ? Language.of(context).getText(title)
                      : titleCity != null
                          ? titleCity
                          : "",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                  maxLines: 1,
                ),
              ),
              Container(
                width: DeviceUtil.getDeviceWidth(context),
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    iconSearch != null
                        ? Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(32.0),
                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.searchScreen,
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: Icon(Icons.search),
                              ),
                            ),
                          )
                        : Container(),
                    iconShare != null
                        ? Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(32.0),
                              ),
                              onTap: () {
                                shareImage();
                              },
                              child: Container(
                                child: Icon(Icons.share),
                              ),
                            ),
                          )
                        : Container(),
                    iconMoreMenu != null
                        ? Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(32.0),
                              ),
                              onTap: () {},
                              child: Container(
                                child: PopMenu(
                                  isRefresh: true,
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
// Widget Text("sds");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          getAppBarUI(context),
          Expanded(
            child: body != null ? body : Container(),
          ),
        ],
      ),
    );
  }
}
