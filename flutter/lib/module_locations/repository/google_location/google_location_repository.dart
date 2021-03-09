import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/module_locations/response/google_locations/google_locations.dart';
import 'package:tourists/module_network/http_client/http_client.dart';

@provide
class GoogleLocationRepository {
  final _client = HttpClient();

  GoogleLocationRepository();

  Future<String> getMapKey() async {
    Map<String, dynamic> response = await _client.get(Urls.mapHelper);
    if (response == null) {
      return null;
    }
    return response == null ? null : response['data'];
  }

  Future<GoogleLocationsResponse> getPredictions(
    String query,
    String key,
  ) async {
    Map<String, dynamic> response =
        await _client.get(Urls.googleAutoComplete, queryParams: {
      'input': query,
      'key': key,
      'language': 'ar',
    });
    if (response == null) return null;
    return GoogleLocationsResponse.fromJson(response);
  }
}
