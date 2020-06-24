import 'package:inject/inject.dart';
import 'package:tourists/repositories/intentions/intentions_repository.dart';
import 'package:tourists/requests/create_profile/create_profile_body.dart';
import 'package:tourists/responses/create_profile/create_profile_response.dart';

@provide
class IntentionsManager {
  IntentionsRepository _intentionsRepository;
  
  IntentionsManager(this._intentionsRepository);
  
  Future<CreateProfileResponse> createIntentions(CreateProfileBody createProfileBody) {
    return _intentionsRepository.createIntentions(createProfileBody);
  }
}