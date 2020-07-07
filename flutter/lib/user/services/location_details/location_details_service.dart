import 'package:inject/inject.dart';
import 'package:tourists/user/managers/location_details/location_details.dart';
import 'package:tourists/user/models/location_details/location_details.dart';
import 'package:tourists/user/responses/location_details/location_response.dart';

@provide
class LocationDetailsService {
  
  LocationDetailsManager _manager;
  
  LocationDetailsService(this._manager);
  
  Future<LocationDetailsModel> getLocationDetails(String locationId) async {
    LocationDetailsResponse response = await _manager.getLocationDetails(locationId);
    
    return response.locationDetails;
  }
}