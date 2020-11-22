import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_earthquake_network/blocs/blocs.dart';
import 'package:flutter_earthquake_network/data/model/model.dart';
import 'package:flutter_earthquake_network/data/model/phone_number.dart';
import 'package:flutter_earthquake_network/data/repository/repository.dart';
import 'package:flutter_earthquake_network/res/dimens.dart';
import 'package:flutter_earthquake_network/ui/template/fintness_app_theme.dart';
import 'package:flutter_earthquake_network/ui/template/hotel_app_theme.dart';
import 'package:platform_device_id/platform_device_id.dart';
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
    this.e,
  }) : super(key: key);

  final bool barrierDismissible;
  final int level;
  final EarthquakeModel e;
  @override
  DialogConfirmReportState createState() => DialogConfirmReportState();
}

class DialogConfirmReportState extends State<DialogConfirmReport>
    with TickerProviderStateMixin {
 // final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey1 = new GlobalKey<ScaffoldState>();

  Widget AboutReport() {
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
    return BlocConsumer<ReportBloc,BaseState>(
      listener: (context, state) {

      },
      builder: (context, state) {
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
                      onTap: ()async {
                        try {
                          BlocProvider.of<ReportBloc>(context).add(Report(level: widget.level, id:widget.e.id));
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // key: _scaffoldKey1,
      backgroundColor: Colors.transparent,
      body:Container(
        child: BlocConsumer<ReportBloc,BaseState>(
          listener: (context, state) {

          },
          builder: (context, state) {

            return  InkWell(
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
                              AboutReport(),
                              BlocConsumer<ReportBloc,BaseState>(
                                listener: (context, state) {
                                  if(state is SuccessReport){
                                    Scaffold.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 2),
                                      content: Text(
                                          Language.of(context).getText("report_success")
                                        // Language.of(context).getText("report_success"),
                                      ),
                                    ));
                                  }
                                },builder: (context, state) {
                                  return Container();
                                },
                              )
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
            );
          },
        ),
      ),
    );
  }
}
