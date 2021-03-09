import 'package:inject/inject.dart';
import 'package:tourists/module_auth/enums/user_type.dart';
import 'package:tourists/module_profile/repository/my_profile/my_profile.dart';
import 'package:tourists/module_profile/request/create_profile.dart';
import 'package:tourists/module_profile/response/profile_response/profile_response.dart';

@provide
class MyProfileManager {
  final MyProfileRepository _repository;

  MyProfileManager(this._repository);

  Future<ProfileResponse> getUserProfile(String userId, UserRole role) =>
      _repository.getTouristProfile(userId, role);

  Future<ProfileResponse> createTouristProfile(
          CreateProfileRequest createProfileRequest) =>
      _repository.createTouristProfile(createProfileRequest);

  Future<ProfileResponse> createGuideProfile(
      CreateProfileRequest createProfileRequest) =>
      _repository.createGuideProfile(createProfileRequest);
}
