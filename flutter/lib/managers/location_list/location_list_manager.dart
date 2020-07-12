import 'dart:developer';

import 'package:inject/inject.dart';
import 'package:tourists/models/location_list_item/location_list_item.dart';
import 'package:tourists/repositories/location_list/location_list_repository.dart';
import 'package:tourists/responses/location_list/location_list_response.dart';

@provide
class LocationListManager {
  LocationListRepository _locationListRepository;

  LocationListManager(this._locationListRepository);

  Future<List<LocationListItem>> getLocationList() async {
    LocationListResponse response = await _locationListRepository.getLocationList();

    if (response != null) {
      log('Got Network Response of ' + response.locationList.length.toString());
      return response.locationList;
    }

    return null;
  }
}