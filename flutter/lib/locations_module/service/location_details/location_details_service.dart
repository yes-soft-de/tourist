import 'package:inject/inject.dart';
import 'package:tourists/locations_module/manager/location_details/location_details.dart';
import 'package:tourists/locations_module/model/location_details/location_details.dart';
import 'package:tourists/locations_module/response/location_details/location_response.dart';
import 'package:tourists/managers/guides_manager/guides_manager.dart';
import 'package:tourists/managers/rate/rate_manager.dart';
import 'package:tourists/models/guide_list_item/guide_list_item.dart';
import 'package:tourists/persistence/sharedpref/shared_preferences_helper.dart';
import 'package:tourists/requests/create_rating/create_rating.dart';
import 'package:tourists/responses/guide_response/guides_response.dart';

@provide
class LocationDetailsService {
  final LocationDetailsManager _locationManager;
  final GuidesManager _guidesManager;
  final RatingManager _ratingManager;
  final SharedPreferencesHelper _preferencesHelper;

  LocationDetailsService(this._locationManager, this._guidesManager,
      this._ratingManager, this._preferencesHelper);

  Future<LocationDetailsModel> getLocationDetails(String locationId) async {
    LocationDetailsResponse response =
        await _locationManager.getLocationDetails(locationId);

    return response.locationDetails;
  }

  Future<List<GuideListItemModel>> getGuidesByLocationId(
      String locationId) async {
    GuidesResponse guidesResponse =
        await this._guidesManager.getGuidesByLocationId(locationId);
    List<GuideListItemModel> guidesList = guidesResponse.data;

    return guidesList;
  }

  Future<dynamic> createRate(int rate, String locationId) async {
    String uid = await _preferencesHelper.getUserUID();
    dynamic response = await _ratingManager.createRating(
        CreateRatingRequest(user: uid, rate: rate, region: locationId));

    return response;
  }
}
