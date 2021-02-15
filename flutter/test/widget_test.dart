import 'package:flutter_test/flutter_test.dart';
import 'package:tourists/module_locations/repository/google_location/google_location_repository.dart';
import 'package:tourists/module_network/http_client/http_client.dart';

Future<void> main() async {
  HttpClient client = HttpClient();
  test('Test Location Search', () async {
    var repo = GoogleLocationRepository();
    var predictions = await repo.getPredictions('Berlin');
    expect(predictions, isNot(null));
  });
}
