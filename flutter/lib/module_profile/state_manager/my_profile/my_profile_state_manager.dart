import 'package:inject/inject.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tourists/module_auth/enums/user_type.dart';
import 'package:tourists/module_auth/service/auth_service/auth_service.dart';
import 'package:tourists/module_profile/model/profile_model/profile_model.dart';
import 'package:tourists/module_profile/service/profile/profile.dart';
import 'package:tourists/module_profile/ui/my_profile/my_profile.dart';
import 'package:tourists/module_profile/ui/states/edit_profile_state.dart';
import 'package:tourists/module_profile/ui/states/edit_profile_state_error.dart';
import 'package:tourists/module_profile/ui/states/edit_profile_state_guide_load_success.dart';
import 'package:tourists/module_profile/ui/states/edit_profile_state_tourist_load_success.dart';
import 'package:tourists/module_upload/service/image_upload/image_upload_service.dart';

@provide
class MyProfileStateManager {
  final PublishSubject<EditProfileState> _stateSubject = PublishSubject();

  Stream<EditProfileState> get stateStream => _stateSubject.stream;

  final ImageUploadService _uploadService;
  final ProfileService _myProfileService;
  final AuthService _authService;

  MyProfileStateManager(this._uploadService, this._myProfileService, this._authService);

  Future<void> refresh(MyProfileScreen screen, ProfileModel model) async {
    var userType = await this._authService.userRole;
    if (userType == UserRole.ROLE_GUIDE) {
      _stateSubject.add(EditProfileStateGuideLoadSuccess(screen, profile: model));
    } else {
      _stateSubject.add(EditProfileStateTouristLoadSuccess(screen, profile: model));
    }
  }

  Future<void> setMyProfile(MyProfileScreen screen, ProfileModel profile) async {
    var userType = await this._authService.userRole;
    var createdProfile = await _myProfileService.createProfile(profile);
    if (userType == UserRole.ROLE_GUIDE) {
      _stateSubject.add(EditProfileStateGuideLoadSuccess(screen, profile: createdProfile));
    } else {
      _stateSubject.add(EditProfileStateTouristLoadSuccess(screen, profile: createdProfile));
    }
  }

  void getMyProfile(MyProfileScreen screen) {
    this._myProfileService.getMyProfile().then((value) {
      if (value != null) {
        this._stateSubject.add(EditProfileStateGuideLoadSuccess(screen, profile: value));
      } else {
        this._stateSubject.add(null);
      }
    });
  }

  void upload(MyProfileScreen screen, String imagePath, ProfileModel model) {
    this._uploadService.uploadImage(imagePath).then((value) {
      if (value == null) {
        _stateSubject
            .add(EditProfileStateError(screen, 'Error Submitting Profile'));
      } else {
        model.image = value;
        _authService.userRole.then((value) {
          if (value == UserRole.ROLE_GUIDE) {
            _stateSubject.add(EditProfileStateGuideLoadSuccess(screen, profile: model));
          } else {
            _stateSubject.add(EditProfileStateTouristLoadSuccess(screen, profile: model));
          }
        });
      }
    });
  }
}
