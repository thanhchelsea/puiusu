import 'dart:async';
import 'dart:collection';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_earthquake_network/blocs/blocs.dart';
import 'package:flutter_earthquake_network/blocs/home_bloc.dart';
import 'package:flutter_earthquake_network/data/model/earthquake_model.dart';
import 'package:flutter_earthquake_network/localizations.dart';
import 'package:flutter_earthquake_network/ui/template/app_theme.dart';
import 'package:flutter_earthquake_network/utils/common.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import '../../routes.dart';

class MapWidget extends StatefulWidget {
  List<EarthquakeModel> listMaker = [];
  CameraPosition cameraPosition;
  MapWidget({this.listMaker, this.cameraPosition});

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapWidget>
    with AutomaticKeepAliveClientMixin<MapWidget> {
  @override
  bool get wantKeepAlive => true;

  Completer<GoogleMapController> _controller = Completer();
  MapType mapType;
  String typeMap;
  Set<Marker> _markers = HashSet<Marker>();
  Set<Circle> _dscir = HashSet<Circle>();
  static double initZoom = 4.5;
  GoogleMap googleMap;
  bool _isShowInfo = false;

  static CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(17.712952, 106.442713), // song gianh
    zoom: initZoom,
  );

  Future getTypeMapShred() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    typeMap = preferences.get(SPrefCache.TYPE_MAP);
    switch (typeMap) {
      case "Normal":
        {
          setState(() {
            mapType = MapType.normal;
          });
          break;
        }
      case "Statellite":
        {
          setState(() {
            mapType = MapType.satellite;
          });

          break;
        }
      case "Terrain":
        {
          setState(() {
            mapType = MapType.terrain;
          });
          break;
        }
      case "Hybird":
        {
          setState(() {
            mapType = MapType.hybrid;
          });
          break;
        }
    }
  }

  initMarker() async {
    _dscir.clear();
    if (widget.cameraPosition != null) {
      _kGooglePlex = widget.cameraPosition;
    }

    if (widget.listMaker != null) {
    } else {
      if (HomeBloc.listEarthquake != null) {
        int count = 0;
        for (int i = 0; i < HomeBloc.listEarthquake.length; i++) {
          for (int rad = 0;
              rad < Common.circleCount(HomeBloc.listEarthquake[i].magnitude);
              rad++) {
            if (rad == 0) {
              _dscir.add(
                Circle(
                  onTap: () {
                    List<EarthquakeModel> e = new List<EarthquakeModel>();
                    Navigator.pushNamed(
                      context,
                      Routes.earthquakeDetais,
                      arguments: HomeBloc.listEarthquake[i],
                    );
                  },
                  consumeTapEvents: true,
                  strokeColor: AppTheme.monthColor(Common.readTimestampToMonth(
                      HomeBloc.listEarthquake[i].time)), //Color(0xff000000),
                  circleId: CircleId(_dscir.length.toString()),
                  center: LatLng(
                      double.parse((HomeBloc.listEarthquake[i].lat)),
                      double.parse((HomeBloc.listEarthquake[i]
                          .lng))), // id cua circle khong bao h trung nhau
                  radius: 5000,
                  strokeWidth: 1,
                  fillColor: AppTheme.monthColor(Common.readTimestampToMonth(
                      HomeBloc.listEarthquake[i].time)),
                ),
              );
            } else {
              _dscir.add(
                Circle(
                  strokeColor: AppTheme.monthColor(Common.readTimestampToMonth(
                      HomeBloc.listEarthquake[i].time)), //Color(0xff000000),
                  circleId: CircleId(_dscir.length.toString()),
                  //circleId: CircleId((a + rad).toString()),
                  center: LatLng(double.parse((HomeBloc.listEarthquake[i].lat)),
                      double.parse((HomeBloc.listEarthquake[i].lng))),
                  radius: double.parse((rad * 10000).toString()),
                  strokeWidth: 0,
                  fillColor: AppTheme.monthColor(Common.readTimestampToMonth(
                          HomeBloc.listEarthquake[i].time))
                      .withOpacity(0.4),
                ),
              );
            }
          }
          count++;
        }

      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTypeMapShred();
    if (widget.listMaker != null) {
      for (int rad = 0;
          rad < Common.circleCount(widget.listMaker[0].magnitude);
          rad++) {
        if (rad == 0) {
          _dscir.add(
            Circle(
              consumeTapEvents: true,
              strokeColor: AppTheme.monthColor(Common.readTimestampToMonth(
                  widget.listMaker[0].time)), //Color(0xff000000),
              circleId: CircleId(_dscir.length.toString()),
              center: LatLng(
                double.parse((widget.listMaker[0].lat)),
                double.parse((widget.listMaker[0].lng)),
              ), // id cua circle khong bao h trung nhau
              radius: 5000,
              strokeWidth: 1,
              fillColor: AppTheme.monthColor(
                Common.readTimestampToMonth(widget.listMaker[0].time),
              ),
            ),
          );
        } else {
          _dscir.add(
            Circle(
              strokeColor: AppTheme.monthColor(Common.readTimestampToMonth(
                  widget.listMaker[0].time)), //Color(0xff000000),
              circleId: CircleId(_dscir.length.toString()),
              //circleId: CircleId((a + rad).toString()),
              center: LatLng(double.parse((widget.listMaker[0].lat)),
                  double.parse((widget.listMaker[0].lng))),
              radius: double.parse((rad * 10000).toString()),
              strokeWidth: 0,
              fillColor: AppTheme.monthColor(
                      Common.readTimestampToMonth(widget.listMaker[0].time))
                  .withOpacity(0.4),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> listTime = [
      Language.of(context).getText("time.0"),
      Language.of(context).getText("time.1"),
      Language.of(context).getText("time.2"),
      Language.of(context).getText("time.3"),
      Language.of(context).getText("time.4"),
    ];
    return Scaffold(
      body: BlocConsumer<AppBloc, BaseState>(
        listener: (context, state) {
          if (state is ChangeMap) {
            switch (state.Map) {
              case "Normal":
                {
                  mapType = MapType.normal;
                  break;
                }
              case "Statellite":
                {
                  mapType = MapType.satellite;
                  break;
                }
              case "Terrain":
                {
                  mapType = MapType.terrain;
                  break;
                }
              case "Hybird":
                {
                  mapType = MapType.hybrid;
                  break;
                }
            }
          }
        },
        builder: (context, state) {
          return Stack(
            children: <Widget>[
              Container(
                child: BlocConsumer<HomeBloc, BaseState>(
                  listener: (context, state) {
                    if (state is LoadedState<List<EarthquakeModel>>) {
                      initMarker();
                    }
                  },
                  builder: (context, state) {
                    return GoogleMap(
                      myLocationEnabled: true,
                      markers: _markers,
                      mapType: mapType,
                      circles: _dscir != null ? _dscir : Set<Circle>.of([]),
                      initialCameraPosition: widget.cameraPosition != null
                          ? widget.cameraPosition
                          : _kGooglePlex,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                        new Factory<OneSequenceGestureRecognizer>(() => new EagerGestureRecognizer(),),
                      ].toSet(),
                    );
                  },
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _isShowInfo = !_isShowInfo;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.info_outline,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              _isShowInfo
                  ? Positioned(
                      top: 50,
                      left: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "Thời gian",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                  margin: EdgeInsets.only(top: 10),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  width: 110,
                                  height: 150,
                                  child: ListView.builder(
                                    padding: EdgeInsets.only(top: 5),
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: 16,
                                              height: 25,
                                              color: AppTheme.listColorMonth(
                                                  index),
                                            ),
                                            Text(
                                              listTime[index],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.6),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ],
          );
        },
      ),
    );
  }
}
