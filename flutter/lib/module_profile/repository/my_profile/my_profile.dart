import 'package:inject/inject.dart';
import 'package:tourists/consts/urls.dart';
import 'package:tourists/module_network/http_client/http_client.dart';
import 'package:tourists/module_profile/request/create_profile.dart';
import 'package:tourists/module_profile/response/profile_list/profile_list_response.dart';
import 'package:tourists/module_profile/response/profile_response/profile_response.dart';

@provide
class MyProfileRepository {
  final _apiClient = HttpClient();
  MyProfileRepository();

  Future<ProfileResponse> getMyProfile() async {
    Map<String, dynamic> response = await _apiClient.get(Urls.createProfileAPI);

    return response ?? ProfileResponse.fromJson(response);
  }

  Future<ProfileResponse> createMyProfile(
      CreateProfileRequest profileRequest) async {
    Map<String, dynamic> response =
        await _apiClient.post(Urls.getProfileAPI, profileRequest.toJson());

    return response == null
        ? null
        : ProfileListResponse.fromJson(response).data.last;
  }

  Future<ProfileResponse> getUserProfile(String userId) async {
    Map<String, dynamic> response =
        await _apiClient.get(Urls.getProfileAPI + '/$userId');

    return response != null && ProfileListResponse.fromJson(response).data.isNotEmpty
        ? ProfileListResponse.fromJson(response).data.last
        : null;
  }
}
