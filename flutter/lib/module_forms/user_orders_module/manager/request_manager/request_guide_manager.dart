import 'package:inject/inject.dart';
import 'package:tourists/module_forms/user_orders_module/repository/request_guide/request_guide_repository.dart';
import 'package:tourists/module_forms/user_orders_module/request/request_guide/request_guide.dart';

@provide
class RequestGuideManager {
  RequestGuideRepository _requestGuideRepository;

  RequestGuideManager(this._requestGuideRepository);

  Future<Map> requestGuide(RequestGuideRequest request) {
    return _requestGuideRepository.requestGuide(request);
  }
}