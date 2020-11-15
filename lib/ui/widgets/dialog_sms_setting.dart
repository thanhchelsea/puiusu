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

class DialogSMSSetting extends StatefulWidget {
  const DialogSMSSetting({
    Key key,
    this.barrierDismissible = true,
  }) : super(key: key);

  final bool barrierDismissible;
  @override
  DialogSMSSettingState createState() => DialogSMSSettingState();
}

class DialogSMSSettingState extends State<DialogSMSSetting>
    with TickerProviderStateMixin {
  TextEditingController nameContact = new TextEditingController();
  TextEditingController phoneContact = new TextEditingController();
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
        left: 30,
        bottom: AppDimens.SIZE_10,
      ),
      child: Container(
        alignment: Alignment.center,
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10),
                width: 0.7 * DeviceUtil.getDeviceWidth(context),
                decoration: BoxDecoration(
                  color: HotelAppTheme.buildLightTheme().backgroundColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.person,
                      color: FitnessAppTheme.nearlyBlue,
                      size: 30,
                    ),
                    Container(
                      width: 0.5 * DeviceUtil.getDeviceWidth(context),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 4, bottom: 4),
                        child: TextFormField(
                          controller: nameContact,
                          validator: (value) {
                            if (value.isEmpty) {
                              return Language.of(context)
                                  .getText("settings.validate_contact");
                            }
                            return null;
                          },
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                          cursorColor:
                              HotelAppTheme.buildLightTheme().primaryColor,
                          decoration: InputDecoration(
                            labelText:
                                Language.of(context).getText("settings.name"),
                            labelStyle: TextStyle(fontSize: 16),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                width: 0.7 * DeviceUtil.getDeviceWidth(context),
                decoration: BoxDecoration(
                  color: HotelAppTheme.buildLightTheme().backgroundColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.call,
                      color: FitnessAppTheme.nearlyBlue,
                      size: 30,
                    ),
                    Container(
                      width: 0.5 * DeviceUtil.getDeviceWidth(context),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 4, bottom: 4),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: phoneContact,
                          validator: (value) {
                            if (value.isEmpty) {
                              return Language.of(context)
                                  .getText("settings.validate_contact");
                            }
                            return null;
                          },
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                          cursorColor:
                              HotelAppTheme.buildLightTheme().primaryColor,
                          decoration: InputDecoration(
                            labelText: Language.of(context)
                                .getText("settings.phone_number"),
                            labelStyle: TextStyle(fontSize: 16),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
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
                      String name = nameContact.text;
                      String phone = phoneContact.text;
                      if (_formKey.currentState.validate()) {
                        BlocProvider.of<PhoneSetting>(context).add(
                          SaveListPhone(
                            new PhoneNumber(name: name, phone: phone),
                          ),
                        );
                        Navigator.pop(context);
                      }
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
                             Language.of(context).getText("settings.add_contact"),
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
