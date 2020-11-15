import 'package:flutter/material.dart';
import 'package:flutter_earthquake_network/ui/widgets/widgets.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: PieChartSample2(),
    );
  }
}
