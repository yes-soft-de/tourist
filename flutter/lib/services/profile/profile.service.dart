import 'dart:developer';

import 'package:inject/inject.dart';
import 'package:tourists/managers/profile/profile.manager.dart';
import 'package:tourists/persistence/sharedpref/shared_preferences_helper.dart';
import 'package:tourists/requests/create_profile/create_profile_body.dart';
import 'package:tourists/responses/create_profile/create_profile_response.dart';

@provide
class ProfileService {
  ProfileManager _profileManager;
  SharedPreferencesHelper _preferencesHelper;

  ProfileService(this._profileManager, this._preferencesHelper);

  Future<CreateProfileResponse> createProfile(CreateProfileBody profile) async {
    // Get UID
    String uid = await _preferencesHelper.getUserUID();

    if (uid == null) {
      log('Error, Null UID!');
      return null;
    }

    // Assign UID to the request
    profile.uid = uid;

    // Bye Bye, Sending Request
    return this._profileManager.createProfile(profile);
  }
}