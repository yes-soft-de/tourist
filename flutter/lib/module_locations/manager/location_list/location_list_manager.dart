import 'package:inject/inject.dart';
import 'package:tourists/module_locations/model/location_list_item/location_list_item.dart';
import 'package:tourists/module_locations/repository/location_list/location_list_repository.dart';
import 'package:tourists/module_locations/response/location_list/location_list_response.dart';
import 'package:tourists/utils/logger/logger.dart';

@provide
class LocationListManager {
  final LocationListRepository _locationListRepository;

  LocationListManager(this._locationListRepository);

  Future<List<LocationListItem>> getLocationList() async {
    LocationListResponse response =
        await _locationListRepository.getLocationList();

    if (response != null) {
      return response.locationList;
    }

    return null;
  }
}
