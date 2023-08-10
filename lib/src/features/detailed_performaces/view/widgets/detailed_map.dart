import 'package:flutter/material.dart';
import 'package:performances_repository/performances_repository.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class DetailedMap extends StatefulWidget {
  final Point initialCoords;
  final List<Place> places;
  const DetailedMap({
    super.key,
    required this.initialCoords,
    required this.places,
  });

  @override
  State<DetailedMap> createState() => _DetailedMapState();
}

class _DetailedMapState extends State<DetailedMap> {
  List<MapObject> placemarks = [];

  @override
  Widget build(BuildContext context) {
    return YandexMap(
      zoomGesturesEnabled: false,
      mode2DEnabled: true,
      scrollGesturesEnabled: false,
      mapObjects: placemarks,
      onMapCreated: (controller) async {
        placemarks.addAll(
          widget.places
              .map(
                (e) => PlacemarkMapObject(
                  opacity: 1,
                  icon: PlacemarkIcon.single(
                    PlacemarkIconStyle(
                      scale: 2,
                      image: BitmapDescriptor.fromAssetImage(
                        ImagesSources.purplePlacemark,
                      ),
                    ),
                  ),
                  mapId: MapObjectId(e.address),
                  point: Point(
                    latitude: e.latitude,
                    longitude: e.longitude,
                  ),
                ),
              )
              .toList(),
        );
        placemarks.addAll(await _buildAllRoute(widget.places));

        controller.moveCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 13,
              target: widget.initialCoords,
            ),
          ),
        );
      },
    );
  }

  Future<List<MapObject>> _buildAllRoute(List<Place> places) async {
    List<MapObject> lines = [];
    BicycleResultWithSession resultWithSession = YandexBicycle.requestRoutes(
      points: places
          .map(
            (e) => RequestPoint(
              point: Point(
                latitude: e.latitude,
                longitude: e.longitude,
              ),
              requestPointType: RequestPointType.wayPoint,
            ),
          )
          .toList(),
      bicycleVehicleType: BicycleVehicleType.bicycle,
    );
    var result = await resultWithSession.result;

    if (result.error != null) {
      return lines;
    }

    result.routes!.asMap().forEach((i, route) {
      lines.add(
        PolylineMapObject(
          mapId: const MapObjectId('route'),
          polyline: Polyline(points: route.geometry),
          strokeColor: AppColor.purplePrimary,
          strokeWidth: 3,
        ),
      );
    });
    setState(() {});
    return lines;
  }
}
