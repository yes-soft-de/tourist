import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/module_authorization/user_authorization_module/request/create_profile/create_profile_body.dart';
import 'package:tourists/module_authorization/user_authorization_module/response/create_profile/create_profile_response.dart';
import 'package:tourists/module_network/http_client/http_client.dart';

@provide
class IntentionsRepository {
  HttpClient _client;

  IntentionsRepository(this._client);

  Future<CreateProfileResponse> createIntentions(
      CreateProfileBody createProfileBody) async {
    Map response =
        await _client.put(Urls.createProfileAPI, createProfileBody.toJson());
    if (response != null) {
      return CreateProfileResponse.fromJson(response);
    }
    return null;
  }
}
