import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locations_repository/locations_repository.dart';
import 'package:shebalin/src/features/active_performance/bloc/perf_mode_map_bloc.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:shebalin/src/theme/theme.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapPage extends StatefulWidget {
  List<Location> locations;
  final Point initialCoords;
  MapPage({
    Key? key,
    required this.locations,
    required this.initialCoords,
  }) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late final List<MapObject> mapObjects = [];
  final List<BicycleSessionResult> results = [];
  int counter = 0;

  @override
  void initState() {
    super.initState();
  }

  void _loadMapPins() {
    mapObjects.addAll(
      widget.locations
          .map(
            (location) => PlacemarkMapObject(
              mapId: MapObjectId(location.number),
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
    return Scaffold(
      body: BlocBuilder<PerfModeMapBloc, PerfModeMapState>(
        builder: (context, state) {
          return YandexMap(
            mapObjects: mapObjects,
            onMapCreated: (controller) {
              context.read<PerfModeMapBloc>()
                ..add(PerfModeMapInitialEvent(controller))
                ..add(PerfModeMapMoveCameraEvent(widget.initialCoords));
              // _buildRouteUserLocationToPoint(Point(
              //     latitude: double.parse(widget.locations[0].latitude),
              //     longitude: double.parse(widget.locations[0].longitude)));
            },
            onUserLocationAdded: _onUserLocationAddedCallback,
          );
        },
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

  // Future<void> _buildRouteUserLocationToPoint(Point nextPoint) async {
  //   CameraPosition? userCameraPosition =
  //       await mapcontroller.getUserCameraPosition();
  //   if (userCameraPosition == null) {
  //     return;
  //   }

  //   var userPoint = userCameraPosition.target;
  //   BicycleResultWithSession resultWithSession = YandexBicycle.requestRoutes(
  //     points: [
  //       RequestPoint(
  //         point: userPoint,
  //         requestPointType: RequestPointType.wayPoint,
  //       ),
  //       RequestPoint(
  //         point: nextPoint,
  //         requestPointType: RequestPointType.wayPoint,
  //       ),
  //     ],
  //     bicycleVehicleType: BicycleVehicleType.bicycle,
  //   );
  //   var result = await resultWithSession.result;
  //   if (result.error != null) {
  //     return;
  //   }
  //   setState(() {
  //     results.add(result);
  //   });

  //   setState(() {
  //     result.routes!.asMap().forEach((i, route) {
  //       mapObjects.add(
  //         PolylineMapObject(
  //           mapId: MapObjectId('route_${counter}_polyline'),
  //           polyline: Polyline(points: route.geometry),
  //           strokeColor: Colors.pink,
  //           strokeWidth: 6,
  //         ),
  //       );
  //       counter += 1;
  //     });
  //   });
  // }

  // void buildRouteFromUserToFirstPoint() {
  //   Point firstPoint = Point(
  //     latitude: double.parse(widget.locations[0].latitude),
  //     longitude: double.parse(widget.locations[0].longitude),
  //   );
  //   _buildRouteUserLocationToPoint(firstPoint);
  // }

  // void _moveCamera({required Point coords}) async {
  //   mapcontroller.moveCamera(
  //     CameraUpdate.newCameraPosition(
  //       CameraPosition(zoom: 15, target: coords),
  //     ),
  //   );
  // }

  // void _getUserLocation() async {
  //   if (await locationPermissionNotGranted) {
  //     return;
  //   } else {
  //     mapcontroller.toggleUserLayer(
  //       visible: true,
  //       autoZoomEnabled: true,
  //     );
  //   }
  // }

  Future<UserLocationView> _onUserLocationAddedCallback(
    UserLocationView locationView,
  ) async {
    final userLocationView = locationView.copyWith(
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
}
