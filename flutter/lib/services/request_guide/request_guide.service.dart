import 'package:inject/inject.dart';
import 'package:tourists/managers/request_guide/request_guide_manager.dart';
import 'package:tourists/models/guide_list_item/guide_list_item.dart';
import 'package:tourists/models/request_guide/request_guide.model.dart';
import 'package:tourists/persistence/sharedpref/shared_preferences_helper.dart';
import 'package:tourists/requests/request_guide/request_guide.dart';
import 'package:tourists/services/guide_list/guide_list.dart';

@provide
class RequestGuideService {
  final SharedPreferencesHelper _preferencesHelper;
  final GuideListService _guidesService;
  final RequestGuideManager _requestGuideManager;

  RequestGuideService(this._preferencesHelper, this._guidesService, this._requestGuideManager);

  Future<bool> requestGuide(RequestGuideModel requestGuide) async {
    String uid = await _preferencesHelper.getUserUID();
    if (uid == null) {
      return false;
    }

    dynamic requestResult = await _requestGuideManager.requestGuide(RequestGuideRequest(
      touristUserID: uid,
      guidUserID: requestGuide.uid,
      city: requestGuide.location,
      language: requestGuide.language,
      arriveDate: requestGuide.arrivalDate,
      leaveDate: requestGuide.arrivalDate.add(Duration(days: requestGuide.stayingDays)),
      services: requestGuide.services,
      status: "waitingPayment")
    );

    if (requestResult != null) {
      return true;
    }

    return false;
  }

  Future<GuideListItemModel> getGuideInfoWithId(String guideId) async {
    List<GuideListItemModel> availableGuides =
        await _guidesService.getAllGuides();

    GuideListItemModel targetGuide;

    availableGuides.forEach((guide) {
      if (guideId == guide.user) targetGuide = guide;
    });

    return targetGuide;
  }
}
