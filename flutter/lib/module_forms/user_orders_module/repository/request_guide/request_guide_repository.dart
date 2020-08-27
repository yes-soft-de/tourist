import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/module_forms/user_orders_module/request/request_guide/request_guide.dart';
import 'package:tourists/module_network/http_client/http_client.dart';
import 'package:tourists/module_orders/response/request_guide_response/request_guide_response.dart';

@provide
class RequestGuideRepository {
  final HttpClient _httpClient;
  RequestGuideRepository(this._httpClient);

  Future<RequestGuideResponse> requestGuide(RequestGuideRequest request) async {
    Map response = await _httpClient.post(Urls.orderGuide, request.toJson());

    if (response == null) {
      return null;
    }

    return RequestGuideResponse.fromJson(response);
  }
}
