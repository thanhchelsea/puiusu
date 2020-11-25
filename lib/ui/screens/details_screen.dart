import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_earthquake_network/data/model/model.dart';
import 'package:flutter_earthquake_network/localizations.dart';
import 'package:flutter_earthquake_network/res/dimens.dart';
import 'package:flutter_earthquake_network/ui/template/design_course_app_theme.dart';
import 'package:flutter_earthquake_network/ui/template/fintness_app_theme.dart';
import 'package:flutter_earthquake_network/ui/widgets/map_widget.dart';
import 'package:flutter_earthquake_network/ui/widgets/report_screen.dart';
import 'package:flutter_earthquake_network/ui/widgets/widgets.dart';
import 'package:flutter_earthquake_network/utils/common.dart';
import 'package:flutter_earthquake_network/utils/hex_color.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Details extends StatefulWidget {
  Details();

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  static GlobalKey _globalKey = GlobalKey();
  GlobalKey key1;
  Uint8List bytes1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }



  Widget Overview(EarthquakeModel earthquakeModel) {
    final double infoHeight = 364.0;
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        12;
    return Container(
      decoration: BoxDecoration(
        color: DesignCourseAppTheme.nearlyWhite,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32.0), topRight: Radius.circular(32.0)),
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
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Container(
          constraints: BoxConstraints(
            minHeight: infoHeight,
            maxHeight: tempHeight > infoHeight ? tempHeight : infoHeight,
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 12, left: 18, right: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: _itemDetail(
                        "details.time",
                        Common.readTimestamp(earthquakeModel.time, context),
                        Icon(
                          Icons.timer,
                          size: AppDimens.SIZE_30,
                          color: FitnessAppTheme.nearlyBlue,
                        ),
                      ),
                    ),
                    Expanded(
                      child: _itemDetail(
                        'details.location',
                        earthquakeModel.address,
                        Icon(
                          Icons.location_on,
                          size: AppDimens.SIZE_30,
                          color: FitnessAppTheme.nearlyBlue,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: _itemDetail(
                        'details.lat_lng',
                        Common.latitudeToHumanReadableString(
                                double.parse(earthquakeModel.lat)) +
                            "\n" +
                            Common.longitudeToHumanReadableString(
                                double.parse(earthquakeModel.lng)),
                        Icon(
                          Icons.golf_course,
                          size: AppDimens.SIZE_30,
                          color: FitnessAppTheme.nearlyBlue,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: _itemDetail(
                          'details.magnitude',
                          earthquakeModel.magnitude.toString(),
                          Icon(
                            Icons.show_chart,
                            size: AppDimens.SIZE_30,
                            color: FitnessAppTheme.nearlyBlue,
                          ),
                          unit: "details.unit"),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: _itemDetail(
                          'details.depth',
                          earthquakeModel.depth.toString(),
                          Icon(
                            Icons.track_changes,
                            size: AppDimens.SIZE_30,
                            color: FitnessAppTheme.nearlyBlue,
                          ),
                          unit: "details.km"),
                    ),
                    Expanded(
                      flex: 1,
                      child: _itemDetail(
                        'details.risk_level',
                        earthquakeModel.riskLevel.toString(),
                        Icon(
                          Icons.flash_on,
                          size: AppDimens.SIZE_30,
                          color: FitnessAppTheme.nearlyBlue,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemDetail(String title, String content, Icon icon, {String unit}) {
    return SizedBox(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 8, left: 8, bottom: 8),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: HexColor('#F8FAFB'),
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        ),
        child: Row(
          children: <Widget>[
            icon,
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                    child: Text(
                      Language.of(context).getText(title),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: FitnessAppTheme.nearlyBlue,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        letterSpacing: 0.27,
                        //color: DesignCourseAppTheme.darkerText,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 8, left: 8, right: 8, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          unit != null
                              ? content = content +
                                  " " +
                                  Language.of(context).getText(unit)
                              : content,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            letterSpacing: 0.27,
                            color: DesignCourseAppTheme.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> data = ['details.map', 'home.reports'];
  int initPosition = 0;

  @override
  Widget build(BuildContext context) {
    EarthquakeModel indexEarthqyuake =
        ModalRoute.of(context).settings.arguments;
    List<EarthquakeModel> list = new List<EarthquakeModel>();
    list.add(indexEarthqyuake);
    List<Widget> ds = [
      Scaffold(
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1.2,
                  child: MapWidget(
                    listMaker: list,
                    cameraPosition: CameraPosition(
                      target: LatLng(
                        double.parse(indexEarthqyuake.lat),
                        double.parse(indexEarthqyuake.lng),
                      ), // song gianh
                      zoom: 8,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: (MediaQuery.of(context).size.width / 1.2) - 12,
              bottom: 0,
              left: 0,
              right: 0,
              child: Overview(indexEarthqyuake),
            ),
          ],
        ),
      ),
      ReportScreen(indexEarthqyuake),

     // sendImage(indexEarthqyuake),
    ];
    return DefaultTabController(
      length: 2,
      child: RepaintBoundary(
        key: _globalKey,
        child: Scaffold(
          body: SafeArea(
            child: BaseScreenMethod(
              titleCity: indexEarthqyuake.address,
              iconShare: true,
              iconMoreMenu: true,
              iconBack: true,
            //  shareImage: () => _shareImages(),
              body: CustomTabView(
                initPosition: initPosition,
                itemCount: data.length,
                tabBuilder: (context, index) => Tab(
                  icon: Text(
                    Language.of(context).getText(data[index]),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                pageBuilder: (context, index) => Center(child: ds[index]),
                onPositionChange: (index) {
                  initPosition = index;
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
