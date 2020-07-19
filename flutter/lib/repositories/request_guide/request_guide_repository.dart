import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/network/http_client/http_client.dart';
import 'package:tourists/requests/request_guide/request_guide.dart';

@provide
class RequestGuideRepository {
  HttpClient _httpClient;
  RequestGuideRepository(this._httpClient);

  Future<dynamic> requestGuide(RequestGuideRequest request) {
    return _httpClient.post(Urls.orderGuide, request.toJson());
  }
}