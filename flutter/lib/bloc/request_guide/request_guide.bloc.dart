import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourists/models/guide_list_item/guide_list_item.dart';
import 'package:tourists/models/request_guide/request_guide.model.dart';
import 'package:tourists/services/request_guide/request_guide.service.dart';

@provide
class RequestGuideBloc {
  RequestGuideService _requestGuideService;

  RequestGuideBloc(this._requestGuideService);

  PublishSubject<bool> _requestGuideSubject = new PublishSubject();
  PublishSubject<GuideListItemModel> _guideInfoSubject = new PublishSubject();

  Stream<bool> get requestGuideStream => _requestGuideSubject.stream;

  Stream<GuideListItemModel> get guideInfoStream => _guideInfoSubject.stream;

  requestGuide(
      String guideId,
      List<String> requiredServices,
      String arrivalDate,
      String stayingDays,
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
        .then((requestStatus) => _requestGuideSubject.add(requestStatus));
  }

  getGuideWithId(String guid) {
    _requestGuideService
        .getGuideInfoWithId(guid)
        .then((guideInfo) => _guideInfoSubject.add(guideInfo));
  }
}
