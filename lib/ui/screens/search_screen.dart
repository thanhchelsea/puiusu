import 'package:flutter/material.dart';
import 'package:flutter_earthquake_network/localizations.dart';
import 'package:flutter_earthquake_network/res/resources.dart';
import 'package:flutter_earthquake_network/ui/template/hotel_app_theme.dart';
import 'package:flutter_earthquake_network/ui/widgets/base_screen_method.dart';
import 'package:flutter_earthquake_network/ui/widgets/widgets.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String valueDropDownMagniyude = 'All Magnitude';
  String valueDropCity = 'All City';
  List<String> dsMagniyude = <String>[
    'All Magnitude',
    '1.0 +',
    '2.0 +',
    '3.0 +',
    '4.0 +',
    '5.0 +',
    '6.0 +',
    '7.0 +'
  ];
  List<String> dsCity = <String>['All City', 'Ha noi', 'Cao bang', 'Hai Phong'];
  @override
  Widget build(BuildContext context) {
    return SearchWidget();
  }
}
