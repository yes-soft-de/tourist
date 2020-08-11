import 'package:inject/inject.dart';
import 'package:tourists/managers/location_list/location_list_manager.dart';
import 'package:tourists/models/location_list_item/location_list_item.dart';

@provide
class LocationListService {
  LocationListManager _locationListManager;

  LocationListService(this._locationListManager);

  Future<List<LocationListItem>> getLocationList() {
    return _locationListManager.getLocationList();
  }
}