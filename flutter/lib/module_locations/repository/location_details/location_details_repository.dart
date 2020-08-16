import 'dart:convert';

import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/module_locations/response/location_details/location_response.dart';
import 'package:tourists/module_network/http_client/http_client.dart';

@provide
class LocationDetailsRepository {
  HttpClient _client;

  LocationDetailsRepository(this._client);

  Future<LocationDetailsResponse> getLocationDetails(String locationId) async {
    String response = await _client.get(Urls.locationDetails + locationId);

    if (response != null) {
      return new LocationDetailsResponse.fromJson(jsonDecode(response));
    }
    else return null;
  }
}