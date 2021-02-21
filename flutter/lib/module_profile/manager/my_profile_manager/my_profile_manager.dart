import 'package:inject/inject.dart';
import 'package:tourists/module_auth/enums/user_type.dart';
import 'package:tourists/module_profile/repository/my_profile/my_profile.dart';
import 'package:tourists/module_profile/request/create_profile.dart';
import 'package:tourists/module_profile/response/profile_response/profile_response.dart';

@provide
class MyProfileManager {
  final MyProfileRepository _repository;
  MyProfileManager(this._repository);

  Future<ProfileResponse> getMyProfile(UserRole role) {
    return _repository.getMyProfile(role);
  }

  Future<ProfileResponse> getUserProfile(String userId) {
    return _repository.getUserProfile(userId);
  }

  Future<ProfileResponse> createMyProfile(
      CreateProfileRequest createProfileRequest, UserRole role) {
    return _repository.createMyProfile(createProfileRequest, role);
  }
}
