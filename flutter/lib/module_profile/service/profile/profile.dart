import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/module_auth/enums/user_type.dart';
import 'package:tourists/module_auth/service/auth_service/auth_service.dart';
import 'package:tourists/module_profile/manager/my_profile_manager/my_profile_manager.dart';
import 'package:tourists/module_profile/model/profile_model/profile_model.dart';
import 'package:tourists/module_profile/presistance/profile_shared_preferences.dart';
import 'package:tourists/module_profile/request/create_profile.dart';
import 'package:tourists/module_profile/response/profile_response/profile_response.dart';

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

  Future<ProfileModel> createProfile(ProfileModel profileModel) async {
    String userId = await _authService.userID;
    UserRole role = await _authService.userRole;

    CreateProfileRequest request = CreateProfileRequest(
      userName: profileModel.name,
      image: profileModel.image,
      location: 'Saudi Arabia',
      userID: userId,
    );

    ProfileResponse response = await _manager.createMyProfile(request, role);
    if (response == null) return null;
    var result = ProfileModel(
      languages: [],
      locations: [],
      name: '${response.data.name}',
      image: '${response.data.image}',
    );
    await cacheProfile(result);
    return result;
  }

  Future<void> cacheProfile(ProfileModel response) async {
    await _preferencesHelper.setUserName(response.name);
    if (response.image.contains('http')) {
      await _preferencesHelper.setUserImage(response.image);
    } else {
      await _preferencesHelper.setUserImage(Urls.imagesRoot + response.image);
    }
  }

  Future<ProfileModel> getUserProfile(String userId) async {
    var me = await _authService.userID;
    var myProfile = await _manager.getUserProfile(me);

    return ProfileModel(
      name: '${myProfile.data.name} ',
      image: '${myProfile.data.image} ',
      locations: [],
      languages: [
        'en',
        'ar'
      ]
    );
  }

  Future<ProfileModel> getMyProfile() async {
    String uid = await _authService.userID;
    var me = await _authService.userID;
    var myProfile = await _manager.getUserProfile(me);

    return ProfileModel(
        name: '${myProfile.data.name} ',
        image: '${myProfile.data.image} ',
        locations: [],
        languages: [
          'en',
          'ar'
        ]
    );
  }
}
