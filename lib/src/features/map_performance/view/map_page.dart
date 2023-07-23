import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locations_repository/locations_repository.dart';
import 'package:shebalin/src/features/map_performance/bloc/perf_mode_map_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

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
  late final int countLocations;
  late PerfModeBloc perfModeMapBloc;
  final int startIndex = 0;

  @override
  void initState() {
    perfModeMapBloc = context.read<PerfModeBloc>();
    countLocations = perfModeMapBloc.countLocations;
    super.initState();
  }

  void _loadMapPins(int index) {
    perfModeMapBloc.add(
      PerfModePinsLoadEvent(
        index,
        countLocations,
        widget.locations,
      ),
    );
  }

  void _loadRoutes(int index) {
    perfModeMapBloc.add(
      PerfModeRoutesLoadEvent(
        index,
        countLocations,
        widget.locations,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PerfModeBloc, PerfModeState>(
      listenWhen: (previous, current) {
        return previous.indexLocation < current.indexLocation;
      },
      listener: (context, state) async {
        // _loadMapPins(state.indexLocation);
        // _loadRoutes(state.indexLocation);
      },
      child: Scaffold(
        body: BlocBuilder<PerfModeBloc, PerfModeState>(
          builder: (context, state) {
            return YandexMap(
              mapType: MapType.vector,
              mapObjects: state.mapObjects,
              onMapCreated: (controller) {
                perfModeMapBloc
                  ..add(PerfModeInitialEvent(controller))
                  ..add(PerfModeMoveCameraEvent(widget.initialCoords));
                _loadMapPins(startIndex);
                _loadRoutes(startIndex);
              },
              onUserLocationAdded: _onUserLocationAddedCallback,
            );
          },
        ),
      ),
    );
  }

  Future<UserLocationView>? _onUserLocationAddedCallback(
    UserLocationView locationView,
  ) {
    return perfModeMapBloc.onUserLocationAddedCallback(locationView);
  }
}
