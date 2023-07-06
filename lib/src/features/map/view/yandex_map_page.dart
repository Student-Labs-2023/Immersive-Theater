import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locations_repository/locations_repository.dart';
import 'package:shebalin/src/features/map/bloc/map_pin_bloc.dart';

import 'package:shebalin/src/theme/images.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class YandexMapPage extends StatefulWidget {
  final List<Location> locations;
  const YandexMapPage({Key? key, required this.locations}) : super(key: key);

  @override
  State<YandexMapPage> createState() => _YandexMapState();
}

class _YandexMapState extends State<YandexMapPage> {
  final _initialCoords = const Point(latitude: 54.988707, longitude: 73.368659);
  late Completer<YandexMapController> _controller;
  late List<PlacemarkMapObject> mapObjects;

  // Position? _position;
  Timer? _timer;
  PlacemarkMapObject? _myPositionMarker;

  @override
  void initState() {
    mapObjects = widget.locations
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
            isDraggable: true,
            icon: PlacemarkIcon.single(
              PlacemarkIconStyle(
                image: BitmapDescriptor.fromAssetImage(ImagesSources.mark),
                scale: 0.3,
              ),
            ),
          ),
        )
        .toList();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _mapPinTapped(MapObject mapObject, Point point, BuildContext context) {
    context.read<MapPinBloc>().add(UpdateMapPinLocation(mapObject, point));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YandexMap(
        mapObjects: mapObjects,
        onMapCreated: (controller) {
          _controller = Completer<YandexMapController>();
          _controller.complete(controller);

          _moveCamera(coords: _initialCoords);
        },
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.12,
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () => {},
          child: const Image(
            image: AssetImage(ImagesSources.locationIcon),
          ),
        ),
      ),
    );
  }

  void _moveCamera({required Point coords}) async {
    final controller = await _controller.future;
    controller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(zoom: 15, target: coords),
      ),
    );
  }
}
