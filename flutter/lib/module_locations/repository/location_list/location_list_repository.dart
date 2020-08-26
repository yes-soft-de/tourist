import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/module_locations/response/location_list/location_list_response.dart';
import 'package:tourists/module_network/http_client/http_client.dart';

@provide
class LocationListRepository {
  final HttpClient _httpClient;

  LocationListRepository(this._httpClient);

  Future<LocationListResponse> getLocationList() async {
    Map response = await _httpClient.get(Urls.locationList);

    if (response != null) {
      return LocationListResponse.fromJson(response);
    }

    return null;
  }
}
