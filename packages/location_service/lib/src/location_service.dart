import 'package:geolocator/geolocator.dart';

abstract class LocationService {
  Future<bool> checkLocationServiceOnDevice();
  Future<bool> checkLocationPermissionOnDevice();

  Stream<Position> getPositionStream(LocationSettings locationSettings);
  double getDistanceBetweenTwoLocations(double startLatitude,
      double startLongitude, double endLatitude, double endLongitude);
}
