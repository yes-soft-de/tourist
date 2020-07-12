import 'package:inject/inject.dart';
import 'package:tourists/models/guide_list_item/guide_list_item.dart';
import 'package:tourists/models/request_guide/request_guide.model.dart';
import 'package:tourists/persistence/sharedpref/shared_preferences_helper.dart';
import 'package:tourists/services/guide_list/guide_list.dart';

@provide
class RequestGuideService {
  SharedPreferencesHelper _preferencesHelper;
  GuideListService _guidesService;

  RequestGuideService(this._preferencesHelper, this._guidesService);

  Future<bool> requestGuide(RequestGuideModel requestGuide) async {
    String uid = await _preferencesHelper.getUserUID();
    if (uid == null) {
      return false;
    }

    // TODO: Request the Guide From the Backend

    return true;
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
