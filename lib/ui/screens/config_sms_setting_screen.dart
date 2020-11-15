import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_earthquake_network/blocs/blocs.dart';
import 'package:flutter_earthquake_network/ui/template/fintness_app_theme.dart';
import 'package:flutter_earthquake_network/ui/widgets/dialog_sms_setting.dart';
import 'package:flutter_earthquake_network/ui/widgets/widgets.dart';
import '../../blocs/base_bloc/base.dart';
import '../../blocs/blocs.dart';
import '../../localizations.dart';
import '../template/app_theme.dart';

class SMSSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhoneSetting, BaseState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConfigSMSSetting();
      },
    );
  }
}

class ConfigSMSSetting extends StatefulWidget {
  @override
  _ConfigSMSSettingState createState() => _ConfigSMSSettingState();
}

class _ConfigSMSSettingState extends State<ConfigSMSSetting> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    // List ds=_getList() as List;
    super.initState();
    BlocProvider.of<PhoneSetting>(context).add(LoadPhone());
  }

  void showDemoDialog({BuildContext context}) {
    showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) => DialogSMSSetting(
        barrierDismissible: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: BlocConsumer<PhoneSetting, BaseState>(
        listener: (context, state) {
          print(PhoneSetting.dsPhone.length);
        },
        builder: (context, state) {
          return BaseScreenMethod(
            iconBack: true,
            title: "settings.sms_help",
            body: Container(
              child: PhoneSetting.dsPhone.length > 0
                  ? ListView.builder(
                      itemCount: PhoneSetting.dsPhone.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 24,
                            right: 24,
                            top: 8,
                            bottom: 8,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: FitnessAppTheme.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color:
                                        FitnessAppTheme.grey.withOpacity(0.2),
                                    offset: Offset(1.1, 1.1),
                                    blurRadius: 10.0),
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                    left: 16,
                                    right: 24,bottom: 8,
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                              color: FitnessAppTheme.nearlyBlue,
                                              shape: BoxShape.circle,
                                            ),
                                            padding: EdgeInsets.all(17),
                                            child: Text(
                                              PhoneSetting
                                                  .dsPhone[index].name[0]
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  color: AppTheme.white,
                                                  fontSize: 17),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    PhoneSetting
                                                        .dsPhone[index].name,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          FitnessAppTheme
                                                              .fontName,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 18,
                                                      letterSpacing: 0.0,
                                                      color: FitnessAppTheme
                                                          .nearlyBlack,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    PhoneSetting
                                                        .dsPhone[index].phone,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          FitnessAppTheme
                                                              .fontName,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16,
                                                      letterSpacing: 0.0,
                                                      color: FitnessAppTheme
                                                          .grey
                                                          .withOpacity(0.5),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(Language.of(context)
                          .getText("settings.empty_contact"))),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (PhoneSetting.dsPhone.length < 10) {
            showDemoDialog(context: context);
          } else {
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content:
                  Text(Language.of(context).getText("settings.count_phone")),
            ));
          }
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
        backgroundColor: FitnessAppTheme.nearlyBlue,
      ),
    );
  }
}
