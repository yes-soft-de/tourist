import 'package:inject/inject.dart';
import 'package:tourists/locations_module/repository/location_details/location_details_repository.dart';
import 'package:tourists/locations_module/response/location_details/location_response.dart';

@provide
class LocationDetailsManager {
  LocationDetailsRepository _repository;
  
  LocationDetailsManager(this._repository);
  
  Future<LocationDetailsResponse> getLocationDetails(String locationId) {
    return this._repository.getLocationDetails(locationId);
  }
  
}