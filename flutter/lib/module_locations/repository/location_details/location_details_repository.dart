import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/module_locations/request/create_location_request.dart';
import 'package:tourists/module_locations/response/location_details/location_response.dart';
import 'package:tourists/module_network/http_client/http_client.dart';

@provide
class LocationDetailsRepository {
  final HttpClient _client;

  LocationDetailsRepository(this._client);

  Future<LocationDetailsResponse> getLocationDetails(String locationId) async {
    Map response = await _client.get(Urls.locationDetails + locationId);

    if (response != null) {
      return new LocationDetailsResponse.fromJson(response);
    } else {
      return null;
    }
  }

  Future<LocationDetailsResponse> createLocationDetails(CreateLocationRequest createLocationRequest) async {
    Map response = await _client.post(Urls.createLocationDetails, createLocationRequest.toJson());

    if (response != null) {
      return new LocationDetailsResponse.fromJson(response);
    } else {
      return null;
    }
  }

  Future<LocationDetailsResponse> updateLocationDetails(CreateLocationRequest createLocationRequest) async {
    Map response = await _client.put('${Urls.createLocationDetails}/${createLocationRequest.placeId}', createLocationRequest.toJson());

    if (response != null) {
      return new LocationDetailsResponse.fromJson(response);
    } else {
      return null;
    }
  }
}
