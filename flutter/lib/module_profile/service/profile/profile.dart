import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/module_auth/service/auth_service/auth_service.dart';
import 'package:tourists/module_profile/manager/my_profile_manager/my_profile_manager.dart';
import 'package:tourists/module_profile/model/profile_model/profile_model.dart';
import 'package:tourists/module_profile/presistance/profile_shared_preferences.dart';
import 'package:tourists/module_profile/request/create_profile.dart';
import 'package:tourists/module_profile/response/profile_response/profile_response.dart';
import 'package:tourists/utils/logger/logger.dart';

@provide
class ProfileService {
  final MyProfileManager _manager;
  final ProfileSharedPreferencesHelper _preferencesHelper;
  final AuthService _authService;

  ProfileService(
    this._manager,
    this._preferencesHelper,
    this._authService,
  );

  Future<bool> hasProfile() async {
    String userImage = await _preferencesHelper.getImage();
    return userImage != null;
  }

  Future<ProfileModel> get profile async {
    var username = await _preferencesHelper.getUsername();
    var image = await _preferencesHelper.getImage();
    return ProfileModel(name: username, image: image);
  }

  Future<ProfileResponse> createProfile(
    String username,
    String userImage,
  ) async {
    String userId = await _authService.userID;

    CreateProfileRequest request = CreateProfileRequest(
        userName: username,
        image: userImage,
        location: 'Saudi Arabia',
        userID: userId);

    ProfileResponse response = await _manager.createMyProfile(request);
    if (response == null) return null;
    await cacheProfile(response);
    return response;
  }

  Future<void> cacheProfile(ProfileResponse response) async {
    await _preferencesHelper.setUserName(response.name);
    if (response.image.path.contains('http')) {
      await _preferencesHelper.setUserImage(response.image.path);
    } else {
      await _preferencesHelper.setUserImage(Urls.imagesRoot + response.image.path);
    }
  }

  Future<ProfileResponse> getUserProfile(String userId) async {
    var me = await _authService.userID;
    if (userId == me) {
      var myProfile = await profile;
      if (myProfile.name != null) {
        return ProfileResponse(
          name: myProfile.name,
          image: ApiImage(path: myProfile.image),
          language: myProfile.languages,
          city: myProfile.locations
        );
      }
    }
    return _manager.getUserProfile(userId);
  }

  Future<ProfileResponse> getMyProfile() async {
    String uid = await _authService.userID;
    return await getUserProfile(uid);
  }
}
