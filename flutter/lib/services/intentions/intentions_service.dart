import 'package:inject/inject.dart';
import 'package:tourists/managers/intentions/intentions_manager.dart';
import 'package:tourists/requests/create_profile/create_profile_body.dart';
import 'package:tourists/responses/create_profile/create_profile_response.dart';

@provide
class IntentionService {
  IntentionsManager _intentionsManager;

  IntentionService(this._intentionsManager);

  Future<bool> createIntentions(CreateProfileBody createProfileBody) async {
    CreateProfileResponse response = await _intentionsManager.createIntentions(createProfileBody);

    if (response == null) {
      return false;
    }

    // TODO Cache Result

    return true;
  }
}