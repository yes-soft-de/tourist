import 'package:inject/inject.dart';
import 'package:tourists/module_guide/manager/guides_manager/guides_manager.dart';
import 'package:tourists/module_guide/model/guide_list_item/guide_list_item.dart';
import 'package:tourists/module_guide/response/guide_response/guides_response.dart';

@provide
class GuideListService {
  GuidesManager _guidesManager;

  GuideListService(this._guidesManager);

  Future<List<GuideListItemModel>> getAllGuides() async {
    GuidesResponse response = await _guidesManager.getGuidesList();
    if (response != null) return response.data;
    return null;
  }
}
