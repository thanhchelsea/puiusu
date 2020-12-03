import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_earthquake_network/blocs/blocs.dart';
import 'package:flutter_earthquake_network/data/model/model.dart';
import 'package:flutter_earthquake_network/ui/template/app_theme.dart';
import 'package:flutter_earthquake_network/ui/widgets/widgets.dart';
import 'package:flutter_earthquake_network/utils/common.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';

class MapReportEarthquake extends StatefulWidget {
  @override
  _MapReportEarthquakeState createState() => _MapReportEarthquakeState();
}

class _MapReportEarthquakeState extends State<MapReportEarthquake> {
  Completer<GoogleMapController> _controller = Completer();
  MapType mapType;
  String typeMap;
  Set<Marker> _markers = HashSet<Marker>();
  Set<Circle> _dscir = HashSet<Circle>();
  GoogleMap googleMap;
  static CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(17.712952, 106.442713), // song gianh
    zoom: 4.5,
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
  int _markerIdCounter = 1;
  GlobalKey key1;
  Uint8List bytes1;
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }
  Future<Uint8List> getImageColor(int level){
    switch (level) {
      case 1:
        return getBytesFromAsset('assets/images/star1.png', 60);
      case 2:
        return getBytesFromAsset('assets/images/star2.png', 60);
      case 3:
        return getBytesFromAsset('assets/images/star3.png', 60);
      case 4:
        return getBytesFromAsset('assets/images/star4.png', 60);
      case 5:
        return getBytesFromAsset('assets/images/star5.png', 60);
      case 6:
        return getBytesFromAsset('assets/images/star6.png', 60);
      case 7:
        return getBytesFromAsset('assets/images/star7.png', 60);
      case 8:
        return getBytesFromAsset('assets/images/star8.png', 60);
      case 9:
        return getBytesFromAsset('assets/images/star9.png', 60);
      case 10:
        return getBytesFromAsset('assets/images/star10.png', 60);
      case 11:
        return getBytesFromAsset('assets/images/star11.png', 60);
      case 12:
        return getBytesFromAsset('assets/images/star12.png', 60);
    }
  }
  abc() async {
    for (ReportModel i in ReportBloc.listReport) {
      final Uint8List  markericon= await getImageColor(i.reportLevel);
      final String markerIdVal = 'marker_id_$_markerIdCounter';
      _markerIdCounter++;
      final MarkerId markerId = MarkerId(markerIdVal);
        _markers.add(Marker(
          markerId:markerId,
          position: LatLng(double.parse(i.latUser), double.parse(i.lngUser)),
            infoWindow: InfoWindow(title:"level:" +i.reportLevel.toString(),),
          icon: BitmapDescriptor.fromBytes(markericon)
        ));
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getTypeMapShred();
    Future.delayed(Duration.zero, () => abc());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // abc();
  }

  @override
  Widget build(BuildContext context) {
    InfoReport e = ModalRoute.of(context).settings.arguments;
    if (e.e != null) {
      _dscir.add(
        Circle(
          strokeColor:
              AppTheme.monthColor(Common.readTimestampToMonth(e.e.time)),
          circleId: CircleId(_dscir.length.toString()),
          center: LatLng(double.parse((e.e.lat)), double.parse((e.e.lng))),
          radius: double.parse(
              (Common.circleCount(e.e.magnitude) * 10000).toString()),
          strokeWidth: 2,
          fillColor: AppTheme.monthColor(Common.readTimestampToMonth(e.e.time)).withOpacity(0.04),
        ),
      );
    }
    BlocProvider.of<MapReportBloc>(context).add(LoadReport());
    return BaseScreenMethod(
        iconBack: true,
        title: "details.map_report",
        body: Container(
          child: BlocConsumer<MapReportBloc, BaseState>(
            listener: (context, state) {
            },
            builder: (context, state) {
              return Stack(
                children: <Widget>[
                  Container(
                    child: GoogleMap(
                      myLocationEnabled: true,
                      markers: _markers != null ? _markers : Set<Marker>.of([]),
                      mapType: mapType,
                      circles: _dscir != null ? _dscir : Set<Circle>.of([]),
                      initialCameraPosition: e.cameraPosition != null
                          ? e.cameraPosition
                          : _kGooglePlex,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      gestureRecognizers:
                          <Factory<OneSequenceGestureRecognizer>>[
                        new Factory<OneSequenceGestureRecognizer>(
                          () => new EagerGestureRecognizer(),
                        ),
                      ].toSet(),
                    ),
                  ),
                ],
              );
            },
          ),
        ));
  }
}
