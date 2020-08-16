import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourists/module_guide/model/guide_list_item/guide_list_item.dart';
import 'package:tourists/module_guide/service/guide_list/guide_list.dart';
@provide
class GuideListBloc {
  static const int STATUS_CODE_INIT = 845;
  static const int STATUS_CODE_LOAD_SUCCESS = 855;
  static const int STATUS_CODE_LOAD_ERROR = 865;

  GuideListService _guideListService;
  GuideListBloc(this._guideListService);

  PublishSubject<Pair<int, List<GuideListItemModel>>> _guidesListSubject = new PublishSubject();
  Stream<Pair<int, List<GuideListItemModel>>> get guidesStream => _guidesListSubject.stream;

  getAllGuides(){
    _guideListService.getAllGuides().then((value) {
      if (value != null)
        _guidesListSubject.add(Pair(STATUS_CODE_LOAD_SUCCESS, value));
      else
        _guidesListSubject.add(Pair(STATUS_CODE_LOAD_ERROR, null));
    });
  }
}