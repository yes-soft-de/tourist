import 'package:fluttertoast/fluttertoast.dart';
import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourists/module_auth/service/auth_service/auth_service.dart';
import 'package:tourists/module_comment/manager/comment/comment_service.dart';
import 'package:tourists/module_comment/request/create_comments/create_comments.dart';
import 'package:tourists/module_comment/response/create_comment/create_comment_response.dart';
import 'package:tourists/module_locations/service/location_details/location_details_service.dart';
import 'package:tourists/module_locations/ui/states/location_details_state/location_details_state.dart';
import 'package:tourists/module_locations/ui/states/location_details_state/location_details_state_error.dart';
import 'package:tourists/module_locations/ui/states/location_details_state/location_details_state_loaded.dart';
import 'package:tourists/module_locations/ui/states/location_details_state/location_details_state_loading.dart';
import 'package:tourists/module_persistence/sharedpref/shared_preferences_helper.dart';

@provide
class LocationDetailsBloc {
  final stateStream = PublishSubject<LocationDetailsState>();

  final LocationDetailsService _locationDetailsService;
  final SharedPreferencesHelper _preferencesHelper;
  final CommentManager _commentManager;
  final AuthService _authService;

  LocationDetailsBloc(
    this._locationDetailsService,
    this._preferencesHelper,
    this._commentManager,
    this._authService,
  );

  Future<void> getLocation(String locationId) async {
    stateStream.add(LocationDetailsStateLoading());
    var locationInfo =
        await _locationDetailsService.getLocationDetails(locationId);

    if (locationInfo == null) {
      stateStream.add(LocationDetailsStateError(
          'Error loading location or location does not exist!'));
      return;
    }

    var loggedIn = await _authService.isLoggedIn;
    loggedIn ??= false;

    stateStream.add(LocationDetailsStateLoaded(
        location: locationInfo,
        guides: locationInfo.guides ?? [],
        isLoggedIn: loggedIn,
        onPostComment: (commentMsg) {
          postComment(commentMsg, locationInfo.id.toString(), locationInfo.placeId);
        }));
  }

  void postComment(String commentMsg, String regionId, String detailsId) async {
    String uid = await this._preferencesHelper.getUserUID();
    if (uid == null) {
      return;
    }

    CreateCommentResponse response =
        await this._commentManager.createComment(CreateCommentRequest(
              comment: commentMsg,
              user: uid,
              region: regionId,
            ));
    if (response == null) return;

    return getLocation(detailsId);
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
