import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_earthquake_network/blocs/blocs.dart';
import 'package:flutter_earthquake_network/data/model/phone_number.dart';
import 'package:flutter_earthquake_network/res/dimens.dart';
import 'package:flutter_earthquake_network/ui/template/fintness_app_theme.dart';
import 'package:flutter_earthquake_network/ui/template/hotel_app_theme.dart';
import '../../blocs/blocs.dart';
import '../../data/model/phone_number.dart';
import '../../localizations.dart';
import '../../res/dimens.dart';
import '../../utils/device.dart';

class DialogConfirmReport extends StatefulWidget {
  const DialogConfirmReport({
    Key key,
    this.barrierDismissible = true,
    this.level,
  }) : super(key: key);

  final bool barrierDismissible;
  final int level;
  @override
  DialogConfirmReportState createState() => DialogConfirmReportState();
}

class DialogConfirmReportState extends State<DialogConfirmReport>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget ListPhoneWidget() {
    return Container(
      //state is LoadingState ? CircularProgressIndicator():Container(),
      padding: EdgeInsets.only(
        left: 15,right: 15,
        bottom: AppDimens.SIZE_10,
      ),
      child: Container(
        alignment: Alignment.center,
        child: Text(Language.of(context).getText("msk_64.${widget.level}")),
      ),
    );
  }

  Widget ButtonWidget() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: Container(
              width: 100,
              height: 48,
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 7, top: 7),
              decoration: BoxDecoration(
                color: FitnessAppTheme.nearlyBlue,
                borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    blurRadius: 8,
                    offset: const Offset(4, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                  highlightColor: Colors.transparent,
                  onTap: () {
                    try {
                     Navigator.pop(context);
                    } catch (_) {}
                  },
                  child: Center(
                    child: Text(
                      Language.of(context).getText(
                          "ok"), // cac so dien thaoi sau se dc gui thong bao khan cap
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: Container(
              width: 100,
              height: 48,
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 7, top: 7),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: const BorderRadius.all(
                  Radius.circular(24.0),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    blurRadius: 8,
                    offset: const Offset(4, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      24.0,
                    ),
                  ),
                  highlightColor: Colors.transparent,
                  onTap: () {
                    try {
                      Navigator.pop(context);
                    } catch (_) {}
                  },
                  child: Center(
                    child: Text(
                      Language.of(
                        context,
                      ).getText(
                        "cancel",
                      ),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap: () {
            if (widget.barrierDismissible) {
              Navigator.pop(context);
            }
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(AppDimens.SIZE_40),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(24.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(
                        4,
                        4,
                      ),
                    ),
                  ],
                ),
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(24.0),
                  ),
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                              top: 30,
                              bottom: 10,
                              left: 10,
                              right: 10,
                            ),
                            child: Text(
                              Language.of(context).getText("send_report"),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: FitnessAppTheme.dark_grey,
                              ),
                            ),
                          ),
                          ListPhoneWidget(),
                        ],
                      ),
                      const Divider(
                        height: 1,
                      ),
                      ButtonWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
