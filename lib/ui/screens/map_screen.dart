import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_earthquake_network/blocs/app_bloc.dart';
import 'package:flutter_earthquake_network/blocs/base_bloc/base.dart';
import 'package:flutter_earthquake_network/data/model/earthquake_model.dart';
import 'package:flutter_earthquake_network/ui/template/design_course_app_theme.dart';
import 'package:flutter_earthquake_network/ui/widgets/earthquake_item.dart';
import 'package:flutter_earthquake_network/ui/widgets/map_widget.dart';
import 'package:flutter_earthquake_network/ui/widgets/widgets.dart';

import '../../constants.dart';

class MapScreen extends StatelessWidget {
  MapScreen();

  List<EarthquakeModel> list = new List<EarthquakeModel>();

  @override
  Widget build(BuildContext context) {
    list.add(new EarthquakeModel(
      address: 'Ha Noi',
      magnitude: 5.4,
      lat: 21.333,
      lng: 103.600,
      time: "14:30 Hôm nay",
      depth: 10,
      riskLevel: 4,
    ));
    list.add(new EarthquakeModel(
      address: 'Ha Noi1',
      magnitude: 3.2,
      lat: 20.326,
      lng: 105.454,
      time: "14:30 Hôm nay",
      depth: 13,
      riskLevel: 4,
    ));
    list.add(new EarthquakeModel(
      address: 'Ha Noi2',
      magnitude: 3.7,
      lat: 22.575,
      lng: 102.605,
      time: "14:30 Hôm nay",
      depth: 60,
      riskLevel: 4,
    ));
    list.add(new EarthquakeModel(
      address: 'Ha Noi3',
      magnitude: 5.4,
      lat: 15.292,
      lng: 108.193,
      time: "14:30 Hôm nay",
      depth: 10,
      riskLevel: 4,
    ));
    list.add(new EarthquakeModel(
      address: 'Ha Noi4',
      magnitude: 3.2,
      lat: 18.227,
      lng: 105.378,
      time: "14:30 Hôm nay",
      depth: 13,
      riskLevel: 4,
    ));
    list.add(new EarthquakeModel(
      address: 'Ha Noi5',
      magnitude: 3.7,
      lat: 22.013,
      lng: 103.165,
      time: "14:30 Hôm nay",
      depth: 6,
      riskLevel: 4,
    ));

    return BlocBuilder<AppBloc, BaseState>(
      builder: (context, state) {
        final double infoHeight = 364.0;
        final double tempHeight = MediaQuery.of(context).size.height -
            (MediaQuery.of(context).size.width / 1.2) +
            36;
        return BaseScreenMethod(
          title: 'home.map',
          iconSearch: true,
          iconMoreMenu: true,
          body: Stack(
            children: [
              Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1.3,
                    child: MapWidget(
                      listMaker: list,
                    ),
                  ),
                ],
              ),
              Positioned(
                top: (MediaQuery.of(context).size.width / 1.2) - 36,
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
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
                    constraints: BoxConstraints(
                      minHeight: infoHeight,
                      maxHeight:
                          tempHeight > infoHeight ? tempHeight : infoHeight,
                    ),
                    child: Container(
                      padding: EdgeInsets.only(top: 4),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.only(
                          top: 10,
                          left: 10,
                          right: 10,
                          bottom: 20,
                        ),
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return EarthquakeItem(list[index]);
                        },
                      ),
                    ),
                  ),
                ),
              ),

              // Expanded(
              //   flex: 5,
              //   child: MapWidget(
              //     listMaker: list,
              //   ),
              // ),
              // Expanded(
              //   flex: 5,
              //   child: Container(
              //     child: ListView.builder(
              //       //padding: const EdgeInsets.only(top: 8),
              //       scrollDirection: Axis.vertical,
              //       padding: EdgeInsets.only(
              //         top: 10,
              //         left: 10,
              //         right: 10,
              //         bottom: 20,
              //       ),
              //       itemCount: list.length,
              //       itemBuilder: (BuildContext context, int index) {
              //         return EarthquakeItem(list[index]);
              //       },
              //     ),
              //   ),
              // )
              //ListView()
            ],
          ),
        );
      },
    );
  }
}
