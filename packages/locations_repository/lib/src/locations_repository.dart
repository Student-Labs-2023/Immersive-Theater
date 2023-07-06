import 'package:locations_repository/src/models/models.dart';

abstract class LocationsRepository {

  Future<List<Location>> fetchLocations();
}