import 'package:inject/inject.dart';
import 'package:tourists/user/models/profile/profile.model.dart';
import 'package:tourists/user/repositories/profile/profile.repository.dart';
import 'package:tourists/user/requests/create_profile/create_profile_body.dart';
import 'package:tourists/user/responses/create_profile/create_profile_response.dart';

@provide
class ProfileManager {
  ProfileRepository _profileRepository;

  ProfileManager(this._profileRepository);

  Future<CreateProfileResponse> getProfile(String uid) {
    return _profileRepository.getProfile(uid);
  }

  Future<CreateProfileResponse> createProfile(CreateProfileBody profileModel) {
    return _profileRepository.createProfile(profileModel);
  }
}