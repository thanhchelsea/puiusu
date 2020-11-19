import 'package:flutter/material.dart';
import 'package:flutter_earthquake_network/localizations.dart';
import 'package:flutter_earthquake_network/res/colors.dart';
import 'package:flutter_earthquake_network/utils/common.dart';

class DialogType extends StatefulWidget {
  final List<String> ds; // danh sach cac item type
  final Function changType;

  DialogType(this.ds, this.changType);

  @override
  _DialogState createState() => _DialogState();
}

class _DialogState extends State<DialogType> {
  String value1 = "";
  getType() async {
    String a = await Common.getTypeMap();
    setState(() {
      value1 = a;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getType();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))
      ),
      title: new Text(Language.of(context).getText("settings.map_type")),
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // dua coloum ve min height
          children: List.generate(widget.ds.length, (index) {
            return Material(
              color: AppColors.white,
              child: Row(
                children: <Widget>[
                  Radio(
                    value: widget.ds[index],
                    groupValue: value1,
                    onChanged: (String value) {
                      // code thay doi lua chon tai day
                      setState(() {
                        value1 = value;
                      });
                      if (widget.changType != null) {
                        widget.changType(value);
                      }
                      Navigator.of(context).pop();
                    },
                  ),
                  Text(widget.ds[index].toString()),
                ],
              ),
            );
          }),
        ),
      ),
    );
    ;
  }
}
