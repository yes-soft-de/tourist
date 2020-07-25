import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourists/models/request_guide/request_guide.model.dart';
import 'package:tourists/services/request_guide/request_guide.service.dart';

@provide
class RequestGuideBloc {
  static const int STATUS_CODE_INIT = 512;
  static const int STATUS_CODE_LOAD_ERROR = 613;
  static const int STATUS_CODE_LOAD_SUCCESS = 714;
  static const int STATUS_CODE_REQUEST_SUCCESS = 815;
  static const int STATUS_CODE_REQUEST_ERROR = 916;

  // Services and DI
  RequestGuideService _requestGuideService;

  RequestGuideBloc(this._requestGuideService);

  PublishSubject<Pair<int, dynamic>> _requestGuideForm = new PublishSubject();

  Stream<Pair<int, dynamic>> get guideInfoStream => _requestGuideForm.stream;

  requestGuide(
      String guideId,
      List<String> requiredServices,
      DateTime arrivalDate,
      int stayingDays,
      String language,
      String location) {
    _requestGuideService
        .requestGuide(new RequestGuideModel(
            services: requiredServices,
            arrivalDate: arrivalDate,
            stayingDays: stayingDays,
            language: language,
            guideId: guideId,
            location: location))
        .then((requestSuccess) {
      if (requestSuccess)
        _requestGuideForm.add(Pair(STATUS_CODE_REQUEST_SUCCESS, null));
      else
        _requestGuideForm.add(Pair(STATUS_CODE_REQUEST_ERROR, null));
    });
  }

  getGuideWithId(String guid) {
    _requestGuideService.getGuideInfoWithId(guid).then((guideInfo) {
      if (guideInfo != null)
        _requestGuideForm.add(Pair(STATUS_CODE_LOAD_SUCCESS, guideInfo));
      else
        _requestGuideForm.add(Pair(STATUS_CODE_LOAD_ERROR, null));
    });
  }
}
