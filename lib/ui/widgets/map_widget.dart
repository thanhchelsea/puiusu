import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_earthquake_network/blocs/blocs.dart';
import 'package:flutter_earthquake_network/data/model/earthquake_model.dart';
import 'package:flutter_earthquake_network/ui/widgets/circle.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';

class MapWidget extends StatefulWidget {
  List<EarthquakeModel> listMaker = [];
  CameraPosition cameraPosition;
  MapWidget({this.listMaker, this.cameraPosition});

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapWidget>
    with
        AutomaticKeepAliveClientMixin<MapWidget>,
        SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  Completer<GoogleMapController> _controller = Completer();
  MapType mapType;
  String typeMap;
  Set<Marker> _markers = HashSet<Marker>();
  Set<Circle> _dscir = HashSet<Circle>();
  static double initZoom = 5.5;
  GoogleMap googleMap;

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

          print(" da thay doi sang " + typeMap);
          break;
        }
      case "Statellite":
        {
          setState(() {
            mapType = MapType.satellite;
          });

          print(" da thay doi sang " + typeMap);
          break;
        }
      case "Terrain":
        {
          setState(() {
            mapType = MapType.terrain;
          });
          print(" da thay doi sang" + typeMap);
          break;
        }
      case "Hybird":
        {
          setState(() {
            mapType = MapType.hybrid;
          });
          print(" da thay doi sang" + typeMap);
          break;
        }
    }
  }

  Future<Uint8List> getBytesFromCanvas(int width, int height) async {
    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color = Colors.blue;
    final Radius radius = Radius.circular(width / 2);

    SpritePainter a = new SpritePainter();
    a.paint(canvas, Size(100, 100));
    final img = await pictureRecorder.endRecording().toImage(width, height);
    final data = await img.toByteData(format: ImageByteFormat.png);
    return data.buffer.asUint8List();
  }

  Future<BitmapDescriptor> getClusterMarker(
    int clusterSize,
    Color clusterColor,
    Color textColor,
    int width,
  ) async {
    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final SpritePainter spritePainter = new SpritePainter();
    final double radius = width / 2;

    spritePainter.paint(
      canvas,
      Size(width.toDouble(), width.toDouble()),
    );
    final image = await pictureRecorder.endRecording().toImage(
          radius.toInt() * 2,
          radius.toInt() * 2,
        );
    final data = await image.toByteData(format: ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
  }

  Future<Uint8List> initMarker() async {
    if (widget.cameraPosition != null) {
      _kGooglePlex = widget.cameraPosition;
    }

    if (widget.listMaker != null) {
      int a = 0;
      print(widget.listMaker.length);
      for (EarthquakeModel earthquakeModel in widget.listMaker) {
        print("fd");
        //_addMarker(a, earthquakeModel, _markers, 100);
        _setCircles(a, earthquakeModel);
        a++;
      }
    }
  }

  Future<void> _addMarker(
      int id, EarthquakeModel earthquakeModel, Set marker, int width) async {
    marker.add(
      Marker(
        icon: await getClusterMarker(2, Colors.yellow, Colors.black, width),
        flat: true,
        markerId: MarkerId(id.toString()),
        position: LatLng(double.parse(earthquakeModel.lat), double.parse(earthquakeModel.lng)),
        infoWindow: InfoWindow(
          title: earthquakeModel.address,
        ),
        //anchor: Offset(0.5, 0.5),
      ),
    );
  }

  void _setCircles(id, EarthquakeModel e) {
    print(id.toString() + " dfdfdfd");
    for (double rad = 0; rad < 5; rad++) {
      if (rad == 0) {
        _dscir.add(
          Circle(
            strokeColor: Colors.green[900], //Color(0xff000000),
            circleId: CircleId(id.toString()),
            center: LatLng(double.parse(e.lat), double.parse(e.lng)),
            radius: 10000,
            strokeWidth: 1,
            fillColor: Colors.green[600],
          ),
        );
      } else {
        _dscir.add(
          Circle(
            strokeColor: Colors.green[600], //Color(0xff000000),
            circleId: CircleId(rad.toString()),
            center: LatLng(double.parse(e.lat), double.parse(e.lng)),
            radius: rad * 20000,
            strokeWidth: 0,
            fillColor: Colors.green[600].withOpacity(0.2),
          ),
        );
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
    // _controller1 = new AnimationController(
    //   vsync: this,
    // );
    // _setCircles();
    initMarker();
    getTypeMapShred();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AppBloc, BaseState>(
        listener: (context, state) {
          print(state.toString() + " sdfsdfsdfs");
          if (state is ChangeMap) {
            switch (state.Map) {
              case "Normal":
                {
                  mapType = MapType.normal;
                  print(" da thay doi " + state.Map);
                  break;
                }
              case "Statellite":
                {
                  mapType = MapType.satellite;
                  print(" da thay doi " + state.Map);
                  break;
                }
              case "Terrain":
                {
                  mapType = MapType.terrain;
                  print(" da thay doi " + state.Map);
                  break;
                }
              case "Hybird":
                {
                  mapType = MapType.hybrid;
                  print(" da thay doi " + state.Map);
                  break;
                }
            }
          }
        },
        child: Stack(
          children: <Widget>[
            GoogleMap(
              myLocationEnabled: true,
              markers: _markers,
              circles: _dscir != null
                  ? _dscir
                  : Set<Circle>.of([
                      Circle(
                        strokeColor: Colors.red,
                        circleId: CircleId("fgf"),
                        center: LatLng(
                          21.93,
                          104.66,
                        ),
                        radius: 10,
                        strokeWidth: 2,
                        fillColor: Color.fromRGBO(
                          102,
                          51,
                          153,
                          .5,
                        ),
                      ),
                    ]),
              mapType: mapType,
              zoomGesturesEnabled: true,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              // onCameraMove:(CameraPosition cameraPosition) async {
              //    var zoom = cameraPosition.zoom;
              //    print('Zoom: $zoom');
              //    Set<Marker> tempMarkers = HashSet<Marker>();
              //    int a = 0;
              //    for (EarthquakeModel earthquakeModel in widget.listMaker) {
              //      await _addMarker(a, earthquakeModel, tempMarkers, (100 * (zoom/initZoom)).toInt());
              //      a++;
              //    }
              //    setState(() {
              //      _markers = tempMarkers;
              //    });
              // },
            ),
          ],
        ),
      ),
    );
  }
}
