import 'package:inject/inject.dart';
import 'package:tourists/managers/guides_manager/guides_manager.dart';
import 'package:tourists/managers/location_details/location_details.dart';
import 'package:tourists/models/guide_list_item/guide_list_item.dart';
import 'package:tourists/models/location_details/location_details.dart';
import 'package:tourists/responses/guide_response/guides_response.dart';
import 'package:tourists/responses/location_details/location_response.dart';

@provide
class LocationDetailsService {
  LocationDetailsManager _locationManager;
  GuidesManager _guidesManager;
  
  LocationDetailsService(this._locationManager, this._guidesManager);
  
  Future<LocationDetailsModel> getLocationDetails(String locationId) async {
    LocationDetailsResponse response = await _locationManager.getLocationDetails(locationId);
    
    return response.locationDetails;
  }

  Future<List<GuideListItemModel>> getGuidesByLocationId(String locationId) async {
    GuidesResponse guidesResponse = await this._guidesManager.getGuidesByLocationId(locationId);
    List<GuideListItemModel> guidesList = guidesResponse.data;

    return guidesList;
  }
}
