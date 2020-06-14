import 'dart:convert';

import 'package:tourists/consts/urls.dart';
import 'package:tourists/models/profile/profile.model.dart';
import 'package:tourists/network/http_client/http_client.dart';
import 'package:tourists/responses/create_profile/create_profile_response.dart';

class ProfileRepository {
  HttpClient _httpClient;

  ProfileRepository(this._httpClient);

  Future<CreateProfileResponse> createProfile(ProfileModel profile) async {
    var stringResponse = await _httpClient.post(Urls.createProfileAPI, profile.toMap());
    CreateProfileResponse parsedResponse = new CreateProfileResponse().fromJson(json.decode(stringResponse));
    return parsedResponse;
  }

  Future<CreateProfileResponse> getProfile(String uid) async {
    var stringResponse = await _httpClient.get(Urls.getProfileAPI + '/' + uid);
    CreateProfileResponse parsedResponse = new CreateProfileResponse().fromJson(json.decode(stringResponse));
    return parsedResponse;
  }
}