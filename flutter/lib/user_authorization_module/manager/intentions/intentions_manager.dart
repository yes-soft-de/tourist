import 'package:inject/inject.dart';
import 'package:tourists/user_authorization_module/repository/intentions/intentions_repository.dart';
import 'package:tourists/user_authorization_module/request/create_profile/create_profile_body.dart';
import 'package:tourists/user_authorization_module/response/create_profile/create_profile_response.dart';

@provide
class IntentionsManager {
  IntentionsRepository _intentionsRepository;
  
  IntentionsManager(this._intentionsRepository);
  
  Future<CreateProfileResponse> createIntentions(CreateProfileBody createProfileBody) {
    return _intentionsRepository.createIntentions(createProfileBody);
  }
}