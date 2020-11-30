import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_earthquake_network/blocs/app_bloc.dart';
import 'package:flutter_earthquake_network/blocs/base_bloc/base.dart';
import 'package:flutter_earthquake_network/blocs/home_bloc.dart';
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
    BlocProvider.of<HomeBloc>(context).add(Loading());

    final double infoHeight = 364.0;
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        36;
    return BaseScreenMethod(
      title: 'home.map',
      isShowRefresh:true,
      iconSearch: true,
      iconMoreMenu: true,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Stack(
          children: [
            Column(
              children: [
                AspectRatio(
                  aspectRatio: 1.3,
                  child: BlocConsumer<HomeBloc, BaseState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return MapWidget(
                      );
                    },
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
                child: BlocConsumer<HomeBloc, BaseState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return Container(
                      constraints: BoxConstraints(
                        minHeight: infoHeight,
                        maxHeight:
                            tempHeight > infoHeight ? tempHeight : infoHeight,
                      ),
                      child: state is LoadingState
                          ? Center(child: CircularProgressIndicator())
                          : Container(
                              padding: EdgeInsets.only(top: 4),
                              child: state is LoadedState<List<EarthquakeModel>>
                                  ? ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      padding: EdgeInsets.only(
                                        top: 10,
                                        left: 10,
                                        right: 10,
                                        bottom: 20,
                                      ),
                                      itemCount: HomeBloc.listEarthquake.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        if (HomeBloc.listEarthquake.isNotEmpty) {
                                          return EarthquakeItem(
                                               HomeBloc.listEarthquake[index],index);
                                        } else
                                          return Text("connect server fail");
                                      },
                                    )
                                  : Text("f"),
                            ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
