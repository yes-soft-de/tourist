import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:inject/inject.dart';
import 'package:tourists/module_locations/manager/google_locations/google_locations_manager.dart';

@provide
class GoogleLocationsService {
  final GoogleLocationsManager _manager;
  GoogleLocationsService(this._manager);

  /// @returns Locations with Names
  ///
  Future<Map<String, LatLng>> getPredictions(String query) async {
    var response = await _manager.getPredictions(query);
    var predictions = <String, LatLng>{};
    response.features.forEach((feature) {
      predictions[feature.properties.name] = LatLng(
          feature.geometry.coordinates[0], feature.geometry.coordinates[1]);
    });

    return predictions;
  }
}
