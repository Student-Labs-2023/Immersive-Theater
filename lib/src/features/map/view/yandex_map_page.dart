import 'dart:async';
import 'package:flutter/material.dart';

import 'package:shebalin/src/theme/images.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class YandexMapPage extends StatefulWidget {
  final List<PlacemarkMapObject> mapObjects;

  const YandexMapPage({Key? key, required this.mapObjects}) : super(key: key);

  @override
  State<YandexMapPage> createState() => _YandexMapState();
}

class _YandexMapState extends State<YandexMapPage> {
  final _initialCoords = const Point(latitude: 54.988707, longitude: 73.368659);
  late Completer<YandexMapController> _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YandexMap(
        mapObjects: widget.mapObjects,
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
        CameraPosition(zoom: 11, target: coords),
      ),
    );
  }
}
