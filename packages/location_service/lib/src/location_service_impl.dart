import 'package:geolocator/geolocator.dart';
import 'package:location_service/src/location_service.dart';

class LocationServiceImpl implements LocationService {
  @override
  Future<bool> checkLocationPermissionOnDevice() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    return true;
  }

  @override
  Future<bool> checkLocationServiceOnDevice() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  @override
  double getDistanceBetweenTwoLocations(double startLatitude,
      double startLongitude, double endLatitude, double endLongitude) {
    return Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
  }

  @override
  Stream<Position> getPositionStream(LocationSettings locationSettings) {
    return Geolocator.getPositionStream(locationSettings: locationSettings);
  }
}
