import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locations_repository/locations_repository.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shebalin/src/features/map/bloc/map_pin_bloc.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/audio_player/audio_player.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/panel_widget.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/progress_bar.dart';

import 'package:shebalin/src/theme/images.dart';
import 'package:shebalin/src/theme/theme.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapPage extends StatefulWidget {
  final List<Location> locations;
  const MapPage({Key? key, required this.locations}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final _initialCoords = const Point(latitude: 54.988707, longitude: 73.368659);
  late YandexMapController mapcontroller;
  late final List<MapObject> mapObjects = [];
  final List<BicycleSessionResult> results = [];
  Future<bool> get locationPermissionNotGranted async =>
      !(await Permission.location.request().isGranted);
  int counter = 0;
  final panelController = PanelController();

  late UserLocationView userLocationView;

  @override
  void initState() {
    super.initState();
  }

  void _mapPinTapped(MapObject mapObject, Point point, BuildContext context) {
    context.read<MapPinBloc>().add(UpdateMapPinLocation(mapObject, point));
  }

  void _loadMapPins() {
    mapObjects.addAll(
      widget.locations
          .map(
            (location) => PlacemarkMapObject(
              onTap: (mapObject, point) {
                _mapPinTapped(mapObject, point, context);
              },
              mapId: MapObjectId(location.number),
              opacity: 1,
              point: Point(
                latitude: double.parse(location.latitude),
                longitude: double.parse(location.longitude),
              ),
              icon: PlacemarkIcon.single(
                PlacemarkIconStyle(
                  image: BitmapDescriptor.fromAssetImage(ImagesSources.mark),
                  scale: 0.3,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => _loadMapPins(),
    );
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: YandexMap(
        mapObjects: mapObjects,
        onMapCreated: (controller) {
          mapcontroller = controller;
          _moveCamera(coords: _initialCoords);
          _buildAllRoute();
        },
        onUserLocationAdded: _onUserLocationAddedCallback,
      ),
    );
  }

  void _buildAllRoute() async {
    BicycleResultWithSession resultWithSession = YandexBicycle.requestRoutes(
      points: widget.locations
          .map(
            (e) => RequestPoint(
              point: Point(
                latitude: double.parse(e.latitude),
                longitude: double.parse(e.longitude),
              ),
              requestPointType: RequestPointType.wayPoint,
            ),
          )
          .toList(),
      bicycleVehicleType: BicycleVehicleType.bicycle,
    );
    var result = await resultWithSession.result;

    if (result.error != null) {
      return;
    }

    setState(() {
      results.add(result);
    });
    setState(() {
      result.routes!.asMap().forEach((i, route) {
        mapObjects.add(
          PolylineMapObject(
            mapId: MapObjectId('route_${counter}_polyline'),
            polyline: Polyline(points: route.geometry),
            strokeColor: accentTextColor,
            strokeWidth: 3,
          ),
        );
        counter += 1;
      });
    });
  }

  Future<void> _buildRouteUserLocationToPoint(Point nextPoint) async {
    CameraPosition? userCameraPosition =
        await mapcontroller.getUserCameraPosition();
    if (userCameraPosition == null) {
      return;
    }

    var userPoint = userCameraPosition.target;
    BicycleResultWithSession resultWithSession = YandexBicycle.requestRoutes(
      points: [
        RequestPoint(
          point: userPoint,
          requestPointType: RequestPointType.wayPoint,
        ),
        RequestPoint(
          point: nextPoint,
          requestPointType: RequestPointType.wayPoint,
        ),
      ],
      bicycleVehicleType: BicycleVehicleType.bicycle,
    );
    var result = await resultWithSession.result;
    if (result.error != null) {
      return;
    }
    setState(() {
      results.add(result);
    });

    setState(() {
      result.routes!.asMap().forEach((i, route) {
        mapObjects.add(
          PolylineMapObject(
            mapId: MapObjectId('route_${counter}_polyline'),
            polyline: Polyline(points: route.geometry),
            strokeColor: Colors.pink,
            strokeWidth: 6,
          ),
        );
        counter += 1;
      });
    });
  }

  void buildRouteFromUserToFirstPoint() {
    Point firstPoint = Point(
      latitude: double.parse(widget.locations[0].latitude),
      longitude: double.parse(widget.locations[0].longitude),
    );
    _buildRouteUserLocationToPoint(firstPoint);
  }

  void _moveCamera({required Point coords}) async {
    mapcontroller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(zoom: 15, target: coords),
      ),
    );
  }

  void _getUserLocation() async {
    if (await locationPermissionNotGranted) {
      return;
    } else {
      mapcontroller.toggleUserLayer(
        visible: true,
        autoZoomEnabled: true,
      );
    }
  }

  Future<UserLocationView>? _onUserLocationAddedCallback(
    UserLocationView locationView,
  ) async {
    userLocationView = locationView.copyWith(
      arrow: locationView.arrow.copyWith(
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage(ImagesSources.markStar),
            scale: 0.3,
          ),
        ),
      ),
      pin: locationView.pin.copyWith(
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage(ImagesSources.markStar),
            scale: 0.3,
          ),
        ),
      ),
      accuracyCircle: locationView.accuracyCircle
          .copyWith(fillColor: Colors.green.withOpacity(0.5)),
    );
    return userLocationView;
  }

  void _endPerformance() {}
}
