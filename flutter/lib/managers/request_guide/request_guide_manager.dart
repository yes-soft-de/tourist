import 'package:inject/inject.dart';
import 'package:tourists/repositories/request_guide/request_guide_repository.dart';
import 'package:tourists/requests/request_guide/request_guide.dart';

@provide
class RequestGuideManager {
  RequestGuideRepository _requestGuideRepository;

  RequestGuideManager(this._requestGuideRepository);

  Future<dynamic> requestGuide(RequestGuideRequest request) {
    return _requestGuideRepository.requestGuide(request);
  }
}