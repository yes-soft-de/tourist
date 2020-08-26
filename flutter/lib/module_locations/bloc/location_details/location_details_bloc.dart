import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourists/module_comment/manager/comment/comment_service.dart';
import 'package:tourists/module_comment/request/create_comments/create_comments.dart';
import 'package:tourists/module_comment/response/create_comment/create_comment_response.dart';
import 'package:tourists/module_guide/model/guide_list_item/guide_list_item.dart';
import 'package:tourists/module_locations/model/location_details/location_details.dart';
import 'package:tourists/module_locations/service/location_details/location_details_service.dart';
import 'package:tourists/module_persistence/sharedpref/shared_preferences_helper.dart';

@provide
class LocationDetailsBloc {
  static const int STATUS_CODE_INIT = 200;
  static const int STATUS_CODE_LOAD_SUCCESS = 201;
  static const int STATUS_CODE_LOAD_ERROR = 202;

  static const int KEY_STATUS = 321;
  static const int KEY_LOCATION_INFO = 311;
  static const int KEY_COMMENTS = 331;
  static const int KEY_GUIDES = 341;

  final LocationDetailsService _locationDetailsService;
  final SharedPreferencesHelper _preferencesHelper;
  final CommentManager _commentManager;

  LocationDetailsBloc(this._locationDetailsService, this._preferencesHelper,
      this._commentManager);

  Subject<Map<int, dynamic>> locationDetailsSubject =
      new PublishSubject<Map<int, dynamic>>();

  Stream<Map<int, dynamic>> get locationDetailsStream =>
      locationDetailsSubject.stream;

  getLocation(String locationId) async {
    LocationDetailsModel model =
        await _locationDetailsService.getLocationDetails(locationId);
    List<GuideListItemModel> guides =
        await _locationDetailsService.getGuidesByLocationId(locationId);

    if (model == null || guides == null) {
      locationDetailsSubject.add({KEY_STATUS: STATUS_CODE_LOAD_ERROR});
      return;
    }

    locationDetailsSubject.add({
      KEY_STATUS: STATUS_CODE_LOAD_SUCCESS,
      KEY_LOCATION_INFO: model,
      KEY_GUIDES: guides
    });
  }

  Future<bool> postComment(String commentMsg, String regionId) async {
    String uid = await this._preferencesHelper.getUserUID();
    if (uid == null) {
      return false;
    }

    CreateCommentResponse response = await this._commentManager.createComment(
        CreateCommentRequest(comment: commentMsg, user: uid, region: regionId));
    if (response == null) return false;

    return true;
  }

  void createRate(int rate, String locationId) {
    _locationDetailsService.createRate(rate, locationId).then((value) {
      if (value != null) {
        getLocation(locationId);
      } else {
        Fluttertoast.showToast(msg: 'Error Creating Rate');
      }
    });
  }
}
