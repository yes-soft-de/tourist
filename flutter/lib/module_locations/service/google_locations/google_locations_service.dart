import 'package:inject/inject.dart';
import 'package:tourists/module_locations/manager/google_locations/google_locations_manager.dart';
import 'package:tourists/module_locations/response/google_locations/google_location_details_response.dart';
import 'package:tourists/module_locations/service/prefs/location_prefs.dart';

@provide
class GoogleLocationsService {
  final GoogleLocationsManager _manager;
  final LocationPreferencesHelper _preferencesHelper;
  GoogleLocationsService(this._manager, this._preferencesHelper);

  /// @returns Locations with Names
  Future<Map<String, String>> getPredictions(String query) async {
    var mapsKey = await _preferencesHelper.getKey();
    if (mapsKey == null) {
      var mapsApiKey = await this._manager.getKey();
      await _preferencesHelper.setKey(mapsApiKey);
      mapsKey = mapsApiKey;
    }

    var response = await _manager.getPredictions(mapsKey, query);
    var predictions = <String, String>{};
    response.predictions.forEach((feature) {
      predictions[feature.description] = feature.placeId;
    });

    return predictions;
  }

  Future<GoogleLocationDetailsResponse> getLocationDetails(String locationId) async {
    var mapsKey = await _preferencesHelper.getKey();
    if (mapsKey == null) {
      var mapsApiKey = await this._manager.getKey();
      await _preferencesHelper.setKey(mapsApiKey);
      mapsKey = mapsApiKey;
    }

    return _manager.getPlaceDetails(mapsKey, locationId);
  }
}
