import 'dart:convert';

import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/network/http_client/http_client.dart';
import 'package:tourists/responses/location_details/location_response.dart';

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