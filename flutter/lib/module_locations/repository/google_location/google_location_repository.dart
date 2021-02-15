import 'package:inject/inject.dart';
import 'package:tourists/module_locations/response/google_locations/google_locations.dart';
import 'package:tourists/module_network/http_client/http_client.dart';

@provide
class GoogleLocationRepository {
  final _client = HttpClient();
  GoogleLocationRepository();

  Future<GoogleLocationsResponse> getPredictions(String query) async {
    Map<String, dynamic> response =
        await _client.get('https://photon.komoot.io/api/?q=$query');

    if (response == null) return null;

    return GoogleLocationsResponse.fromJson(response);
  }
}
