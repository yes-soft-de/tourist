import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/network/http_client/http_client.dart';
import 'package:tourists/requests/create_rating/create_rating.dart';

@provide
class RatingRepository {
  final HttpClient _client;

  RatingRepository(this._client);

  Future<bool> postRating(CreateRatingRequest request) async {
    String response = await this._client.post(Urls.rate, request.toJson());

    print(response);

    if (response == null) return false;

    return true;
  }
}
