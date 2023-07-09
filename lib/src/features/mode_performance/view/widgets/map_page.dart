import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locations_repository/locations_repository.dart';
import 'package:shebalin/src/features/active_performance/bloc/perf_mode_map_bloc.dart';
import 'package:shebalin/src/features/mode_performance/bloc/mode_performance_bloc.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:shebalin/src/theme/theme.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'dart:developer';

class MapPage extends StatefulWidget {
  final List<Location> locations;
  final Point initialCoords;

  const MapPage({
    Key? key,
    required this.locations,
    required this.initialCoords,
  }) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final List<BicycleSessionResult> results = [];
  late final int countLocations;
  late PerfModeMapBloc perfModeMapBloc;

  @override
  void initState() {
    countLocations = context.read<ModePerformanceBloc>().state.countLocations;
    perfModeMapBloc = context.read<PerfModeMapBloc>();
    super.initState();
  }

  void _loadMapPins(int index) {
    perfModeMapBloc
        .add(PerfModeMaPinsLoadEvent(index, countLocations, widget.locations));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ModePerformanceBloc, ModePerformanceState>(
      listenWhen: (previous, current) {
        return previous.indexLocation < current.indexLocation;
      },
      listener: (context, state) async {
        // _buildAllRoute(state.indexLocation);
        _loadMapPins(state.indexLocation);
      },
      child: Scaffold(
        body: BlocBuilder<PerfModeMapBloc, PerfModeMapState>(
          builder: (context, state) {
            return YandexMap(
              mapType: MapType.vector,
              mapObjects: state.mapObjects,
              onMapCreated: (controller) {
                context.read<PerfModeMapBloc>()
                  ..add(PerfModeMapInitialEvent(controller))
                  ..add(PerfModeMapMoveCameraEvent(widget.initialCoords));
                // _buildAllRoute(0);
                _loadMapPins(0);
              },
              onUserLocationAdded: _onUserLocationAddedCallback,
            );
          },
        ),
      ),
    );
  }

  // void _buildAllRoute(int index) async {
  //   final locationsNotDone = widget.locations.sublist(index);
  //   if (index != 0) {
  //     final locationsDone = widget.locations.sublist(0, index + 1);
  //     BicycleResultWithSession resultWithSessionDone =
  //         YandexBicycle.requestRoutes(
  //       points: locationsDone
  //           .map(
  //             (e) => RequestPoint(
  //               point: Point(
  //                 latitude: double.parse(e.latitude),
  //                 longitude: double.parse(e.longitude),
  //               ),
  //               requestPointType: RequestPointType.wayPoint,
  //             ),
  //           )
  //           .toList(),
  //       bicycleVehicleType: BicycleVehicleType.bicycle,
  //     );
  //     var result = await resultWithSessionDone.result;

  //     if (result.error != null) {
  //       return;
  //     }
  //     result.routes!.asMap().forEach((i, route) {
  //       mapObjects.add(
  //         PolylineMapObject(
  //           mapId: const MapObjectId('done'),
  //           polyline: Polyline(points: route.geometry),
  //           strokeColor: AppColor.grey,
  //           strokeWidth: 3,
  //         ),
  //       );
  //     });
  //   }

  //   if (index != countLocations - 1) {
  //     BicycleResultWithSession resultWithSession = YandexBicycle.requestRoutes(
  //       points: locationsNotDone
  //           .map(
  //             (e) => RequestPoint(
  //               point: Point(
  //                 latitude: double.parse(e.latitude),
  //                 longitude: double.parse(e.longitude),
  //               ),
  //               requestPointType: RequestPointType.wayPoint,
  //             ),
  //           )
  //           .toList(),
  //       bicycleVehicleType: BicycleVehicleType.bicycle,
  //     );
  //     var resultNotDone = await resultWithSession.result;

  //     if (resultNotDone.error != null) {
  //       return;
  //     }
  //     setState(() {
  //       resultNotDone.routes!.asMap().forEach((i, route) {
  //         mapObjects.add(
  //           PolylineMapObject(
  //             mapId: const MapObjectId("not_done"),
  //             polyline: Polyline(points: route.geometry),
  //             strokeColor: AppColor.purplePrimary,
  //             strokeWidth: 3,
  //           ),
  //         );
  //       });
  //     });
  //   }
  // }

  Future<UserLocationView> _onUserLocationAddedCallback(
    UserLocationView locationView,
  ) async {
    final userLocationView = locationView.copyWith(
      arrow: locationView.arrow.copyWith(
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage(ImagesSources.userPlacemark),
            scale: 4,
          ),
        ),
      ),
      pin: locationView.pin.copyWith(
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage(ImagesSources.userPlacemark),
            scale: 4,
          ),
        ),
      ),
      accuracyCircle: locationView.accuracyCircle.copyWith(
        fillColor: Colors.transparent,
        strokeColor: Colors.transparent,
      ),
    );

    return userLocationView;
  }
}
