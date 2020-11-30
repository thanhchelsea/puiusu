import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_earthquake_network/blocs/blocs.dart';
import 'package:flutter_earthquake_network/res/colors.dart';
import 'package:flutter_earthquake_network/res/dimens.dart';
import 'dart:math' as math;
import 'package:url_launcher/url_launcher.dart';
import '../../blocs/base_bloc/base.dart';
import '../../blocs/blocs.dart';
import '../../blocs/sos_bloc.dart';
import '../../localizations.dart';

class DialogSOS extends StatefulWidget {
  const DialogSOS({
    Key key,
    this.onApplyClick,
    this.onCancelClick,
    this.barrierDismissible = true,
  }) : super(key: key);

  final bool barrierDismissible;
  final Function(DateTime, DateTime) onApplyClick;

  final Function onCancelClick;
  @override
  DialogSOSState createState() => DialogSOSState();
}

class DialogSOSState extends State<DialogSOS> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _launchCaller(String phone) async {
    String url = "tel:${phone}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget ListPhoneWidget(state) {
    return BlocConsumer<SOSBloc, BaseState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          //state is LoadingState ? CircularProgressIndicator():Container(),
          padding: EdgeInsets.only(
            left: 30,
            bottom: AppDimens.SIZE_10,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              SOSBloc.dsP.length > 0
                  ? Column(
                      children: List.generate(
                        SOSBloc.dsP.length,
                        (index) {
                          return Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.only(
                              top: 5,
                            ),
                            child: Container(
                              padding: EdgeInsets.only(
                                top: AppDimens.SIZE_20,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 6,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(15),
                                          margin: EdgeInsets.only(
                                              right: AppDimens.SIZE_20,),
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black,),
                                            shape: BoxShape.circle,
                                          ),
                                          child:
                                              Text(SOSBloc.dsP[index].name[0],),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  bottom: AppDimens.SIZE_5,),
                                              child: Text(
                                                SOSBloc.dsP[index].name,
                                                style: TextStyle(
                                                  fontSize: AppDimens.SIZE_20,
                                                  color: AppColors.blue,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              SOSBloc.dsP[index].phone,
                                              style: TextStyle(
                                                fontSize: AppDimens.SIZE_15,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: InkWell(
                                      onTap: () {
                                        _launchCaller(SOSBloc.dsP[index].phone);
                                      },
                                      child: Center(
                                        child: Transform(
                                          alignment: Alignment.center,
                                          transform: Matrix4.rotationY(math.pi),
                                          child: Icon(
                                            Icons.phone,
                                            size: 30,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Text(Language.of(context).getText("settings.empty_contact")),
              state is LoadingState
                  ? SizedBox(
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                      ),
                      height: 20,
                      width: 20,
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }

  Widget ButtonWidget(state) {
    return BlocConsumer<SOSBloc, BaseState>(
      listener: (context, state) {},
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
                  decoration: BoxDecoration(
                    color: Colors.red,
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
                      borderRadius:
                          const BorderRadius.all(Radius.circular(24.0)),
                      highlightColor: Colors.transparent,
                      onTap: () {
                        try {
                          BlocProvider.of<SOSBloc>(context).add(SendingMess());
                          //Navigator.pop(context);
                        } catch (_) {}
                      },
                      child: Center(
                        child: Text(
                          Language.of(context).getText(
                              "ok"),
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
    BlocProvider.of<SOSBloc>(context).add(LoadListPhone());
    return Scaffold(
      backgroundColor: Colors.transparent,
      key: _scaffoldKey,
      body: Container(
        child: BlocConsumer<SOSBloc, BaseState>(
          listener: (context, state) {
            if (state is ErrorState<String>) {
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text(
                  Language.of(context).getText(state.data),
                ),
              ));
            }
          },
          builder: (context, state) {
            return Center(
              child: InkWell(
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
                    padding: const EdgeInsets.all(24.0),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                    top: 30,
                                    bottom: 10,
                                    left: 30,
                                    right: 20,
                                  ),
                                  child: Text(
                                    Language.of(context).getText(
                                      "sos.contact_to",
                                    ),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                ListPhoneWidget(
                                  state,
                                ),
                              ],
                            ),
                            const Divider(
                              height: 1,
                            ),
                            ButtonWidget(state),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
//              child: Scaffold(
//                backgroundColor: Colors.transparent,
//                body:,
//              ),
            );
          },
        ),
      ),
    );
  }
}
