import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:performances_repository/performances_repository.dart';
import 'package:shebalin/src/features/mode_perf_home/bloc/perf_home_mode_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class HomeMapPage extends StatefulWidget {
  final List<Place> locations;
  final Point initialCoords;

  const HomeMapPage({
    Key? key,
    required this.locations,
    required this.initialCoords,
  }) : super(key: key);

  @override
  State<HomeMapPage> createState() => _HomeMapPageState();
}

class _HomeMapPageState extends State<HomeMapPage> {
  late final int countLocations;
  late PerfHomeModeBloc perfHomeModeBloc;
  final int startIndex = 0;

  @override
  void initState() {
    perfHomeModeBloc = context.read<PerfHomeModeBloc>();
    countLocations = widget.locations.length;
    super.initState();
  }

  void _loadMapPins(int index) {
    perfHomeModeBloc.add(
      PerfHomeModePinsLoadEvent(
        index,
        countLocations,
      ),
    );
  }

  void _loadRoutes(int index) {
    perfHomeModeBloc.add(
      PerfHomeModeRoutesLoadEvent(
        index,
        countLocations,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PerfHomeModeBloc, PerfHomeModeState>(
      builder: (context, state) {
        return YandexMap(
          mapType: MapType.vector,
          mapObjects: state.mapObjects,
          onMapCreated: (controller) {
            perfHomeModeBloc
              ..add(PerfHomeModeInitialEvent(controller))
              ..add(PerfHomeModeMoveCameraEvent(widget.initialCoords));
            _loadMapPins(startIndex);
            _loadRoutes(startIndex);
          },
        );
      },
    );
  }
}
