import 'dart:convert';

import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/network/http_client/http_client.dart';
import 'package:tourists/responses/location_list/location_list_response.dart';

@provide
class LocationListRepository {
  HttpClient _httpClient;

  LocationListRepository(this._httpClient);

  Future<LocationListResponse> getLocationList() async {
    String response = await _httpClient.get(Urls.locationList);

    if (response != null) {
      return LocationListResponse.fromJson(jsonDecode(response));
    }

    return null;
  }
}