import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourists/models/guide_list_item/guide_list_item.dart';
import 'package:tourists/services/guide_list/guide_list.dart';

@provide
class GuideListBloc {
  GuideListService _guideListService;

  GuideListBloc(this._guideListService);

  PublishSubject<List<GuideListItemModel>> _guidesListSubject = new PublishSubject();
  Stream<List<GuideListItemModel>> get guidesStream => _guidesListSubject.stream;

  getAllGuides(){
    _guideListService.getAllGuides().then((value) => _guidesListSubject.add(value));
  }
}