import 'package:tourists/models/profile/profile.model.dart';
import 'package:tourists/repositories/profile/profile.repository.dart';
import 'package:tourists/responses/create_profile/create_profile_response.dart';

class ProfileManager {
  ProfileRepository _profileRepository;

  ProfileManager(this._profileRepository);

  Future<CreateProfileResponse> getProfile(String uid) {
    return _profileRepository.getProfile(uid);
  }

  Future<CreateProfileResponse> createProfile(ProfileModel profileModel) {
    return _profileRepository.createProfile(profileModel);
  }
}