import 'package:inject/inject.dart';
import 'package:tourists/module_forms/user_orders_module/repository/request_guide/request_guide_repository.dart';
import 'package:tourists/module_forms/user_orders_module/request/request_guide/request_guide.dart';
import 'package:tourists/module_orders/response/request_guide_response/request_guide_response.dart';

@provide
class RequestGuideManager {
  final RequestGuideRepository _requestGuideRepository;

  RequestGuideManager(this._requestGuideRepository);

  Future<RequestGuideResponse> requestGuide(RequestGuideRequest request) {
    return _requestGuideRepository.requestGuide(request);
  }
}
