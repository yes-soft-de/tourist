import 'package:tourists/managers/profile/profile.manager.dart';
import 'package:tourists/models/profile/profile.model.dart';
import 'package:tourists/responses/create_profile/create_profile_response.dart';

class ProfileService {
  ProfileManager _profileManager;

  ProfileService(this._profileManager);

  createProfile(ProfileModel profileModel) async {
    CreateProfileResponse createResponse = await _profileManager.createProfile(profileModel);

    // If the request succeeded, save login credentials
    if (createResponse != null) {

    } else {
      // Something Happened!
      return;
    }
  }
}