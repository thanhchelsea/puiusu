import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_earthquake_network/blocs/blocs.dart';
import 'package:flutter_earthquake_network/data/model/model.dart';
import 'package:flutter_earthquake_network/routes.dart';
import 'package:flutter_earthquake_network/ui/template/app_theme.dart';
import 'package:flutter_earthquake_network/ui/template/design_course_app_theme.dart';
import 'package:flutter_earthquake_network/ui/widgets/widgets.dart';
import 'package:flutter_earthquake_network/utils/device.dart';
import 'package:flutter_earthquake_network/data/model/earthquake_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../localizations.dart';

class PieChartSample2 extends StatefulWidget {
  EarthquakeModel e;

  PieChartSample2(this.e);

  @override
  PieChart2State createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {
  int touchedIndex;
  int lengthLevel = 0;

  void showDemoDialog({BuildContext context, int level, EarthquakeModel e}) {
    showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) => DialogConfirmReport(
        barrierDismissible: true,
        level: level,
        e: e,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    lengthLevel = int.parse((widget.e.magnitude).floor().toString()) + 1;
    BlocProvider.of<ReportBloc>(context).add(getReport(widget.e.id));
  }

  double levelPercent(
    int levelReport,
  ) {
    int countLevel = 0;
    for (ReportModel i in ReportBloc.listReport) {
      if (i.reportLevel == levelReport + 1) {
        countLevel++;
      }
    }
    return double.parse(
        (countLevel * 100 / ReportBloc.listReport.length).toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    final double infoHeight = 0;
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        12;
    return BlocConsumer<ReportBloc, BaseState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          child: Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 18,
                    ),
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        Container(
                          // color:Colors.red,
                          child: PieChart(
                            PieChartData(
                                pieTouchData: PieTouchData(
                                    touchCallback: (pieTouchResponse) {
                                  setState(() {
                                    if (pieTouchResponse.touchInput
                                            is FlLongPressEnd ||
                                        pieTouchResponse.touchInput
                                            is FlPanEnd) {
                                      touchedIndex = -1;
                                    } else {
                                      touchedIndex =
                                          pieTouchResponse.touchedSectionIndex;
                                    }
                                  });
                                }),
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                sectionsSpace: 0,
                                centerSpaceRadius: 40,
                                sections: showingSections()),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.MapReport,
                              arguments: InfoReport(
                                e: widget.e,
                                cameraPosition: CameraPosition(
                                  target: LatLng(
                                    double.parse(widget.e.lat),
                                    double.parse(widget.e.lng),
                                  ), // song gianh
                                  zoom: 8.2,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.6),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            margin: EdgeInsets.only(left: 10),
                            padding: EdgeInsets.all(8),
                            child: Text(
                              Language.of(context)
                                  .getText("details.view_on_map"),
                              style: TextStyle(
                                color: AppTheme.white,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SingleChildScrollView(
                      child: Column(
                          //mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: List.generate(lengthLevel, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0, left: 5),
                              child: Indicator(
                                color: AppTheme.levelColor(index),
                                text: 'Cấp độ ${index + 1}',
                                isSquare: true,
                              ),
                            );
                          })),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: DesignCourseAppTheme.nearlyWhite,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: DesignCourseAppTheme.grey.withOpacity(0.2),
                      offset: const Offset(
                        1.1,
                        1.1,
                      ),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Container(
                  padding: EdgeInsets.only(top: 15),
                  constraints: BoxConstraints(
                    minHeight: infoHeight,
                    maxHeight:
                        tempHeight > infoHeight ? tempHeight : infoHeight,
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(bottom: 15),
                          //alignment: Alignment.centerLeft,
                          child: Text(
                            "Chọn cấp độ đánh giá",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      Container(
                        child: Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: List.generate(lengthLevel, (index) {
                                return Container(
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  child: FlatButton(
                                    onPressed: () {
                                      showDemoDialog(
                                          context: context,
                                          level: index + 1,
                                          e: widget.e);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.only(
                                          left: 5,
                                          top: 12,
                                          bottom: 12,
                                          right: 5),
                                      width: DeviceUtil.getDeviceWidth(context),
                                      decoration: BoxDecoration(
                                          color: AppTheme.levelColor(index),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Text(
                                        "Cấp độ ${index + 1}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(lengthLevel, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      return PieChartSectionData(
        showTitle: levelPercent(i) != 0 ? true : false,
        color: AppTheme.levelColor(i),
        value: levelPercent(i),
        title: levelPercent(i).toString() + "%",
        radius: radius,
        titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff)),
      );
    });
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  const Indicator({
    Key key,
    this.color,
    this.text,
    this.isSquare,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
        )
      ],
    );
  }
}

class InfoReport {
  EarthquakeModel e;
  CameraPosition cameraPosition;

  InfoReport({this.e, this.cameraPosition});
}
