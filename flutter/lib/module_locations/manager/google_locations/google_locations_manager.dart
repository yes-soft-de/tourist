import 'package:inject/inject.dart';
import 'package:tourists/module_locations/repository/google_location/google_location_repository.dart';
import 'package:tourists/module_locations/response/google_locations/google_locations.dart';

@provide
class GoogleLocationsManager {
  GoogleLocationRepository _repository;

  Future<String> getKey() => _repository.getMapKey();

  Future<GoogleLocationsResponse> getPredictions(String key, String query) =>
      _repository.getPredictions(query, key);
}
