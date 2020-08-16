import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/module_forms/user_orders_module/request/request_guide/request_guide.dart';
import 'package:tourists/module_network/http_client/http_client.dart';

@provide
class RequestGuideRepository {
  HttpClient _httpClient;
  RequestGuideRepository(this._httpClient);

  Future<dynamic> requestGuide(RequestGuideRequest request) {
    return _httpClient.post(Urls.orderGuide, request.toJson());
  }
}