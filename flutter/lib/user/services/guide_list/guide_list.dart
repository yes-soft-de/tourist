import 'package:inject/inject.dart';
import 'package:tourists/user/managers/guides_manager/guides_manager.dart';
import 'package:tourists/user/models/guide_list_item/guide_list_item.dart';
import 'package:tourists/user/responses/guide_response/guides_response.dart';

@provide
class GuideListService {
  GuidesManager _guidesManager;

  GuideListService(this._guidesManager);

  Future<List<GuideListItemModel>> getAllGuides() async {
    GuidesResponse response = await _guidesManager.getGuidesList();
    return response.data;
  }
}