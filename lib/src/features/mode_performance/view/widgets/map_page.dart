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
    perfModeMapBloc.add(
      PerfModeMapPinsLoadEvent(
        index,
        countLocations,
        widget.locations,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ModePerformanceBloc, ModePerformanceState>(
      listenWhen: (previous, current) {
        return previous.indexLocation < current.indexLocation;
      },
      listener: (context, state) async {
        _loadMapPins(state.indexLocation);
        _buildAllRoute(state.indexLocation);
      },
      child: Scaffold(
        body: BlocBuilder<PerfModeMapBloc, PerfModeMapState>(
          buildWhen: (previous, current) {
            log(previous.mapObjects.length.toString());
            log(current.mapObjects.length.toString());
            return true;
          },
          builder: (context, state) {
            return YandexMap(
              mapType: MapType.vector,
              mapObjects: state.mapObjects,
              onMapCreated: (controller) {
                context.read<PerfModeMapBloc>()
                  ..add(PerfModeMapInitialEvent(controller))
                  ..add(PerfModeMapMoveCameraEvent(widget.initialCoords));

                _loadMapPins(0);
                _buildAllRoute(0);
              },
              onUserLocationAdded: _onUserLocationAddedCallback,
            );
          },
        ),
      ),
    );
  }

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

  _buildAllRoute(int index) {
    perfModeMapBloc.add(
      PerfModeMapRoutesLoadEvent(
        index,
        countLocations,
        widget.locations,
      ),
    );
  }
}
