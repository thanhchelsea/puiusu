import 'package:flutter/material.dart';
import 'package:flutter_earthquake_network/ui/widgets/widgets.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SearchWidget();
  }
}
