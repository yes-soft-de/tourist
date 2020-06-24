import 'package:inject/inject.dart';
import 'package:tourists/user/models/location_list_item/location_list_item.dart';
import 'package:tourists/user/repositories/location_list/location_list_repository.dart';
import 'package:tourists/user/responses/location_list/location_list_response.dart';

@provide
class LocationListManager {
  LocationListRepository _locationListRepository;

  LocationListManager(this._locationListRepository);

  Future<List<LocationListItem>> getLocationList() async {
    LocationListResponse response = await _locationListRepository.getLocationList();

    if (response != null) {
      return response.locationList;
    }

    return null;
  }
}