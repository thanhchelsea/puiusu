import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_earthquake_network/blocs/blocs.dart';
import 'package:flutter_earthquake_network/ui/template/fintness_app_theme.dart';
import 'package:flutter_earthquake_network/ui/widgets/dialog_sms_setting.dart';
import 'package:flutter_earthquake_network/ui/widgets/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../blocs/base_bloc/base.dart';
import '../../blocs/blocs.dart';
import '../../localizations.dart';

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

  void confirmEdit(
      {BuildContext context, String userName, String phoneNumber,int index}) {
    showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) => DialogSMSSetting(
        barrierDismissible: true,
        confirm: () => {print("edit")},
        username: userName,
        phonenumber: phoneNumber,
        index:index
      ),
    );
  }

  Widget itemPhone(int index) {
    return Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: FitnessAppTheme.nearlyBlue,
              child: Text(PhoneSetting.dsPhone[index].name[0].toUpperCase()),
              foregroundColor: Colors.white,
            ),
            title: Text(
              PhoneSetting.dsPhone[index].name,
              style: TextStyle(
                fontFamily: FitnessAppTheme.fontName,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              PhoneSetting.dsPhone[index].phone,
              style: TextStyle(
                color: FitnessAppTheme.grey.withOpacity(0.7),
              ),
            ),
          ),
        ),
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: Language.of(context).getText("settings.delete"),
            color: Colors.red,
            icon: Icons.delete,
            onTap: () => {
              BlocProvider.of<PhoneSetting>(context).add(DeletePhone(index))
            },
          ),
          IconSlideAction(
            caption: Language.of(context).getText("settings.edit"),
            color: Colors.teal,
            icon: Icons.mode_edit,
            onTap: () {
              confirmEdit(
                context: context,
                userName: PhoneSetting.dsPhone[index].name,
                phoneNumber: PhoneSetting.dsPhone[index].phone,
                index:index,
              );
              //BlocProvider.of<PhoneSetting>(context).add(EditPhone(index,))
            },
          ),
        ]);
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
                      padding: EdgeInsets.only(top: 2),
                      itemCount: PhoneSetting.dsPhone.length,
                      itemBuilder: (context, index) {
                        return itemPhone(index);
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
          if (PhoneSetting.dsPhone.length < 5) {
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
